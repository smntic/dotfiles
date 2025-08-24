{ ... }:

{
  programs.kitty = {
    enable = true;

    keybindings = {
      # Disable tab bindings
      "kitty_mod+t" = "no_op";
      "kitty_mod+q" = "no_op";
      "kitty_mod+alt+t" = "no_op";

      # Disable window bindings
      "kitty_mod+enter" = "no_op";
      "kitty_mod+n" = "no_op";
      "kitty_mod+w" = "no_op";
      "kitty_mod+r" = "no_op";
    };

    extraConfig = ''
      confirm_os_window_close 0
      enable_audio_bell no
      paste_actions filter
    '';
  };
}
