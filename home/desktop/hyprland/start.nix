{ pkgs, ... }:

let
  # Runs only when Hyprland is opened initially
  setupScript = pkgs.pkgs.writeShellScript "setup" ''
    uwsm app -- ${pkgs.waybar}/bin/waybar &
    uwsm app -- ${pkgs.wl-clipboard}/bin/wl-paste --watch ${pkgs.cliphist}/bin/cliphist store &
    uwsm app -- ${pkgs.wl-clip-persist}/bin/wl-clip-persist --clipboard regular &
  '';

  # Runs every time hyprland reloads
  reloadScript = pkgs.pkgs.writeShellScript "reload" ''
  '';
in
  {
    home.packages = [
      pkgs.hyprpaper
      pkgs.waybar
      pkgs.wl-clipboard
      pkgs.wl-clip-persist
    ];

    wayland.windowManager.hyprland.settings = {
      exec-once = ''${setupScript}'';
      exec = ''${reloadScript}'';
    };
  }

