{ username, ... }:

{
  users.users.${username}.extraGroups = [
    "dialout"
    "input"
  ];

  services.udev.extraRules = ''
    # Allow Plover to inject strokes via uinput (required under Wayland / Hyprland)
    KERNEL=="uinput", GROUP="input", MODE="0660", OPTIONS+="static_node=uinput"

    # Allow access to USB serial adapters (EcoSteno / Gemini PR)
    KERNEL=="ttyACM[0-9]*", MODE="0666", GROUP="dialout"
    KERNEL=="ttyUSB[0-9]*", MODE="0666", GROUP="dialout"

    # Allow HID raw access
    KERNEL=="hidraw*", SUBSYSTEM=="hidraw", MODE="0666", GROUP="dialout"
  '';
}
