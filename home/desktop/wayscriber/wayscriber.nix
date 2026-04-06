{ pkgs, ... }:

{
  home.packages = [ pkgs.wayscriber ];

  xdg.configFile."wayscriber/config.toml" = {
    text = ''
      [tablet]
      enabled = true
      min_thickness = 1.0
      max_thickness = 5.0

      [ui]
      show_status_bar = false

      [ui.toolbar]
      layout_mode = "simple"

      [drawing]
      default_color = "red"
      default_thickness = 3.0
      default_eraser_size = 12.0
      default_eraser_mode = "stroke"
    '';
    force = true;
  };
}
