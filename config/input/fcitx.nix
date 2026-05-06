{ pkgs, ... }:

{
  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";

    fcitx5 = {
      waylandFrontend = true;
      ignoreUserConfig = false;

      addons = with pkgs; [
        fcitx5-mozc
        fcitx5-gtk
        fcitx5-nord
        fcitx5-hangul
        qt6Packages.fcitx5-configtool
        qt6Packages.fcitx5-chinese-addons
      ];
    };
  };
}
