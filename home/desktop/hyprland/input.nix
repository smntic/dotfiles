{ ... }:

{
  wayland.windowManager.hyprland.settings = {
    gesture = [
      "3, horizontal, workspace"
    ];

    input = {
      # Global mouse config
      accel_profile = "flat";

      # Global touchpad config
      touchpad = {
        scroll_factor = 0.5;
      };

      # Global keyboard config
      kb_layout = "us";
      kb_options = "caps:escape,altwin:swap_alt_win";
      repeat_rate = 30;
      repeat_delay = 300; 
    };

    # Find these devices with `hyprctl devices`
    device = [
      {
        name = "elan06c2:00-04f3:3195-touchpad";
        accel_profile = "adaptive";
        natural_scroll = true;
      }

      {
        name = "tpps/2-elan-trackpoint";
        sensitivity = -0.5;
      }

      {
        name = "wacom-one-by-wacom-s-pen";
        output = "HDMI-A-1";
      }
    ];
  };
}
