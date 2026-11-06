{ inputs, pkgs, ... }:

{
  programs.plover = {
    enable = true;
    package = inputs.plover-flake.packages.${pkgs.stdenv.hostPlatform.system}.plover.withPlugins (
      ps: with ps; [
        plover-uinput
        plover-python-dictionary
        plover-stenotype-extended
      ]
    );

    # Or, use `plover-full` if you want Plover with all the plugins installed:
    # package = inputs.plover-flake.packages.${pkgs.stdenv.hostPlatform.system}.plover-full;

    # (optional) Generate `plover.cfg`:
    settings = {
      "Output Configuration" = {
        undo_levels = 100;
        space_placement = "Before Output";
        time_between_key_presses = 0;
        start_attached = true;
        keyboard_layout = "qwerty";
      };

      "Logging Configuration" = {
        log_file = "~/strokes.log";
        enable_stroke_logging = true;
        enable_translation_logging = true;
      };

      Startup = {
        "start minimized" = false;
      };

      "Translation Frame" = {
        opacity = 100;
      };

      "Machine Configuration" = {
        machine_type = "Gemini PR";
        auto_start = true;
      };

      "Gemini PR" = {
        baudrate = 9600;
        bytesize = 8;
        parity = "N";
        port = "/dev/serial/by-id/usb-Noll_Electronics_LLC_Nolltronics_Ecosteno-if02";
        stopbits = 2;
        timeout = 0.01;
      };

      Plugins = {
        enabled_extensions = [
          "plover_python_dictionary"
          "plover_uinput"
          "prover_stenotype_extended"
        ];
      };

      System = {
        name = "Stenotype Extended";
      };

      "System: Stenotype Extended" = {
        dictionaries = builtins.toJSON [
          {
            enabled = true;
            path = "~/steno-dictionary/python-dicts/main_dict.py";
          }
        ];
        "keymap[gemini pr]" = builtins.toJSON [
          [
            "#"
            [
              "#1"
              "#2"
              "#3"
              "#4"
              "#5"
              "#6"
              "#7"
              "#8"
              "#9"
              "#A"
              "#B"
              "#C"
              "Fn"
              "S1-"
              "pwr"
            ]
          ]
          [
            "^-"
            [ "res1" ]
          ]
          [
            "+-"
            [ "res2" ]
          ]
          [
            "S-"
            [ "S2-" ]
          ]
          [
            "T-"
            [ "T-" ]
          ]
          [
            "K-"
            [ "K-" ]
          ]
          [
            "P-"
            [ "P-" ]
          ]
          [
            "W-"
            [ "W-" ]
          ]
          [
            "H-"
            [ "H-" ]
          ]
          [
            "R-"
            [ "R-" ]
          ]
          [
            "A-"
            [ "A-" ]
          ]
          [
            "O-"
            [ "O-" ]
          ]
          [
            "+-"
            [
              "*1"
              "*2"
            ]
          ]
          [
            "*"
            [
              "*3"
              "*4"
            ]
          ]
          [
            "-E"
            [ "-E" ]
          ]
          [
            "-U"
            [ "-U" ]
          ]
          [
            "-F"
            [ "-F" ]
          ]
          [
            "-R"
            [ "-R" ]
          ]
          [
            "-P"
            [ "-P" ]
          ]
          [
            "-B"
            [ "-B" ]
          ]
          [
            "-L"
            [ "-L" ]
          ]
          [
            "-G"
            [ "-G" ]
          ]
          [
            "-T"
            [ "-T" ]
          ]
          [
            "-S"
            [ "-S" ]
          ]
          [
            "-D"
            [ "-D" ]
          ]
          [
            "-Z"
            [ "-Z" ]
          ]
          [
            "no-op"
            [ ]
          ]
        ];
      };

      GUI = {
        classic_dictionaries_display_order = false;
      };
    };
  };
}
