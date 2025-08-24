{ ... }:

{
  wayland.windowManager.hyprland.settings = {
    monitor = [
      ", preferred, auto-left, 1"
      "eDP-1, preferred, 0x0, 1"
    ];

    workspace = [
      "1, monitor:HDMI-A-1"
    ];

    cursor = {
      default_monitor = "HDMI-A-1";
    };
  };
}
