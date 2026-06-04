{ pkgs, ... }:

let
  wacomFollowMonitor = pkgs.writeShellScriptBin "wacom-follow-monitor" ''
    SOCKET="$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock"

    remap_tablet() {
      local monitor="$1"
      hyprctl keyword input:tablet:output "$monitor"
    }

    ${pkgs.socat}/bin/socat -U - "UNIX-CONNECT:$SOCKET" | while IFS= read -r line; do
      if [[ "$line" == focusedmon\>\>* ]]; then
        monitor="''${line#focusedmon\>\>}"
        monitor="''${monitor%%,*}"
        remap_tablet "$monitor"
      fi
    done
  '';

  # Runs only when Hyprland is opened initially
  setupScript = pkgs.pkgs.writeShellScript "setup" ''
    uwsm app -- ${pkgs.waybar}/bin/waybar &
    uwsm app -- ${pkgs.wl-clip-persist}/bin/wl-clip-persist --clipboard regular &
    ${wacomFollowMonitor}/bin/wacom-follow-monitor &
    fcitx5-remote -r
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
      wacomFollowMonitor
    ];

    wayland.windowManager.hyprland.settings = {
      exec-once = ''${setupScript}'';
      exec = ''${reloadScript}'';
    };
  }

