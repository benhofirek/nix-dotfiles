{
  services.dunst = {
    enable = true;

    settings = {
      global = {
        width = 300;
        height = 300;
        offset = "30x30";
        origin = "top-right";
        transparency = 10;
        frame_color = "#89b4fa";
        font = "Sans 10";
        corner_radius = 10;
        padding = 8;
        horizontal_padding = 10;
      };

      urgency_low = {
        background = "#1e1e2e";
        foreground = "#cdd6f4";
        timeout = 5;
      };

      urgency_normal = {
        background = "#1e1e2e";
        foreground = "#cdd6f4";
        timeout = 10;
      };

      urgency_critical = {
        background = "#1e1e2e";
        foreground = "#f38ba8";
        frame_color = "#f38ba8";
        timeout = 0; # Stays until dismissed
      };
    };
  };
}
