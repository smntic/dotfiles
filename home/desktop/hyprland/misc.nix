{ ... }:

{
  wayland.windowManager.hyprland = {
    settings = {
      misc = {
        # Disable splash screen
        disable_hyprland_logo = true;
        disable_splash_rendering = true;

        # How to disable update messages?

        # Animate events like resizeactive
        animate_manual_resizes = true;
      };

      env = [
        "XDG_CURRENT_DESKTOP,Hyprland"
        "GTK_IM_MODULE,fcitx"
        "QT_IM_MODULE,fcitx"
        "XMODIFIERS,@im=fcitx"
        "INPUT_METHOD,fcitx"
        "SDL_IM_MODULE,fcitx"
        "GLFW_IM_MODULE,ibus"
      ];
    };
  };
}
