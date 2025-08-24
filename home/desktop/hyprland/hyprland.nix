{ ... }:

{
  imports = [
    ./animation.nix
    ./appearance.nix
    ./bindings.nix
    ./input.nix
    ./misc.nix
    ./monitor.nix
    ./start.nix
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = false;
  };

  home.shellAliases = {
    hypr = "uwsm start hyprland-uwsm.desktop";
    hyprexit = "pkill -9 gammastep & uwsm stop";
  };
}
