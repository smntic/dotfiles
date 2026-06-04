{ ... }:

{
  wayland.windowManager.hyprland.settings = {
    monitor = [
      ", preferred, auto-left, 1"
      "eDP-1, preferred, 0x0, 1"
      "desc:Dell Inc. DELL P2719H 8ZMZ6R2, preferred, auto-right, 1"
    ];

    workspace = [
      "1, monitor:HDMI-A-1"
    ];

    cursor = {
      default_monitor = "HDMI-A-1";
    };
  };
}
