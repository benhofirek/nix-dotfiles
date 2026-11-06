{ pkgs, ... }:

let
  # ---- Tunables (conservative values; adjust here only) ----
  coreMaxKhz = 4500000; # core frequency cap, kHz (4.5 GHz)
  uncoreMaxKhz = 4000000; # uncore / ring-bus cap, kHz (4.0 GHz)
  epp = "balance_power"; # "power" is even cooler
  tempTarget = 75; # throttle at 75°C
  pl1 = {
    limit = 55;
    window = 28;
  };
  pl2 = {
    limit = 65;
    window = 0.002;
  };
  requireUncoreInterface = true; # fail loudly if the uncore cap can't be applied
in
{
  # Needed by undervolt to access the MSRs
  boot.kernelModules = [ "msr" ];

  # ---- Core frequency governor and cap ----
  powerManagement = {
    cpuFreqGovernor = "powersave";
    cpufreq.max = coreMaxKhz;
  };

  # ---- Power limits + thermal throttle point ----
  services.undervolt = {
    enable = true;
    useTimer = true;
    temp = tempTarget;
    p1 = pl1;
    p2 = pl2;
  };

  # ---- turbo off - not needed, handled by frequency cap
  #systemd.tmpfiles.rules = [
  #  "w /sys/devices/system/cpu/intel_pstate/no_turbo - - - - 1"
  #];

  # ---- EPP + uncore frequency cap ----
  systemd.services.intel-cpu-tuning = {
    description = "Apply Intel CPU EPP and uncore frequency limits";
    wantedBy = [ "multi-user.target" ];
    after = [ "systemd-modules-load.service" ];
    wants = [ "systemd-modules-load.service" ];

    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
      ExecStart = pkgs.writeShellScript "intel-cpu-tuning" ''
        set -euo pipefail

        # Energy Performance Preference on every CPU
        for f in /sys/devices/system/cpu/cpu*/cpufreq/energy_performance_preference; do
          if [[ -e "$f" ]]; then
            echo ${epp} > "$f"
          fi
        done

        # Uncore / ring-bus frequency cap on every package/die
        uncore_dir=/sys/devices/system/cpu/intel_uncore_frequency

        if [[ ! -d "$uncore_dir" ]]; then
          echo "intel_uncore_frequency interface not found" >&2
          ${if requireUncoreInterface then "exit 1" else "exit 0"}
        fi

        for d in "$uncore_dir"/*/; do
          if [[ -e "$d/max_freq_khz" ]]; then
            echo ${toString uncoreMaxKhz} > "$d/max_freq_khz"
          fi
        done
      '';
    };
  };
}
