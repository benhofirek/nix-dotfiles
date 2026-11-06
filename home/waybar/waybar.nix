{
  programs.waybar = {
    enable = false;
    systemd = {
      enable = true;
      targets = [ "graphical-session.target" ];
    };

    style = "${./style.css}";

    settings = {
      workspaceBar = {
        name = "workspaceBar";
        output = "!eDP-1";
        layer = "top";
        position = "right";
        mode = "overlay";
        reload_on_stylesheet_change = true;
        on-sigusr1 = "toggle";
        on-sigusr2 = "reload";

        modules-left = [ "hyprland/workspaces" ];

        "hyprland/workspaces" = {
          format = "{name}";
          on-click = "activate";
          all-outputs = false;
        };
      };

      mainBar = {
        name = "mainBar";
        output = "eDP-1";
        layer = "top";
        position = "top";
        mode = "dock";
        reload_on_stylesheet_change = true;
        on-sigusr1 = "toggle";
        on-sigusr2 = "reload";

        modules-left = [ "hyprland/workspaces" ];
        modules-center = [ "clock" ];
        modules-right = [
          "hyprland/submap"
          "group/volume"
          "battery"
          "bluetooth"
          "network"
          "cpu"
          "memory"
        ];

        "hyprland/window" = {
          max-length = 50;
        };

        battery = {
          interval = 60;
          format = "{capacity}% {icon}";
          format-icons = {
            default = [
              "󰂎"
              "󰁺"
              "󰁻"
              "󰁼"
              "󰁽"
              "󰁾"
              "󰁿"
              "󰂀"
              "󰂁"
              "󰂂"
              "󰁹"
            ];
            charging = [
              "󰢟"
              "󰢜"
              "󰂆"
              "󰂇"
              "󰂈"
              "󰢝"
              "󰂉"
              "󰢞"
              "󰂊"
              "󰂋"
              "󰂅"
            ];
          };
        };

        bluetooth = {
          format = "";
          format-disabled = "";
          format-connected = " {num_connections}";
          tooltip-format = "{controller_alias}\t{controller_address}";
          tooltip-format-connected = "{controller_alias}\t{controller_address}\n\n{device_enumerate}";
          tooltip-format-enumerate-connected = "{device_alias}\t{device_address}";
          on-click = "exec kitty --title=bluetui -e bluetui";
        };

        cpu = {
          interval = 10;
          format = " {}%";
          max-length = 10;
          on-click = "exec kitty --title=btop -e btop";
        };

        memory = {
          interval = 30;
          format = " {percentage}%";
          tooltip-format = "{used:0.1f}G/{total:0.1f}G used";
          on-click = "exec kitty --title=htop -e htop";
        };

        network = {
          format = "";
          format-wifi = "";
          format-ethernet = "";
          format-disconnected = "󰤭";
          tooltip-format = "{ifname} via {gwaddr} 󰊗";
          tooltip-format-wifi = "{essid} ({signalStrength}%) ";
          tooltip-format-ethernet = "{ifname} ";
          tooltip-format-disconnected = "󰖪";
          max-length = 50;
          on-click = "exec nmrs";
        };

        clock = {
          format = "󰥔 {:%a, %d. %b %I:%M %p}";
          tooltip-format = "<tt><small>{calendar}</small></tt>";
          calendar = {
            format = {
              today = "<span color='#75f1fa'><b>{}</b></span>";
            };
          };
          on-click = "exec google-chrome --app=https://calendar.google.com";
        };

        pulseaudio = {
          format = "{volume}% {icon}";
          format-muted = "";
          format-icons = {
            default = [
              ""
              ""
            ];
          };
          scroll-step = 1;
          ignored-sinks = [ "Easy Effects Sink" ];
          on-click = "pavucontrol";
        };

        "pulseaudio/slider" = {
          min = 0;
          max = 100;
          orientation = "horizontal";
        };

        "group/volume" = {
          orientation = "horizontal";
          modules = [
            "pulseaudio"
            "pulseaudio/slider"
          ];
        };
      };
    };
  };
}
