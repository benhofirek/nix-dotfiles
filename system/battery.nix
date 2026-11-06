{ pkgs, ... }:

# test: cat /sys/class/power_supply/BAT0/charge_control_end_threshold
{
  systemd.services.battery-charge-threshold = {
    description = "Set battery charge threshold";
    wantedBy = [
      "multi-user.target"
      "post-resume.target"
    ];
    after = [
      "multi-user.target"
      "post-resume.target"
    ];
    serviceConfig = {
      Type = "oneshot";
      ExecStart = "${pkgs.runtimeShell} -c 'echo 55 > /sys/class/power_supply/BAT0/charge_control_end_threshold'";
    };
  };
}
