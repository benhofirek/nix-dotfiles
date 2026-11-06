{
  systemd.services.fan-curve = {
    wantedBy = [
      "multi-user.target"
      "post-resume.target"
    ];
    after = [ "post-resume.target" ];
    serviceConfig.Type = "oneshot";
    script = ''
      for h in /sys/class/hwmon/hwmon*; do
        [ "$(cat $h/name)" = asus_custom_fan_curve ] || continue
        
        apply() {
          fan=$1; shift
          [ -e $h/''${fan}_enable ] || return 0
          i=1
          for pair in "$@"; do
            t=''${pair%%:*}; p=''${pair##*:}
            echo $t > $h/''${fan}_auto_point''${i}_temp
            echo $p > $h/''${fan}_auto_point''${i}_pwm
            i=$((i+1))
          done
          echo 1 > $h/''${fan}_enable
        }

        # CPU: Responsive
        apply pwm1 40:15 46:30 52:55 58:90 63:130 68:175 72:215 75:255
        
        # GPU: Quiet and scaled to higher thermal limit
        apply pwm2 45:0  50:15 56:30 62:60 68:100 74:150 80:200 85:255
        
        # Center: Balanced middle ground
        apply pwm3 40:10 48:25 55:50 62:85 68:120 74:160 80:200 85:255
      done
    '';
  };
}
