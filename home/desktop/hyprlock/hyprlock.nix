{ lib, config, ... }:

{
  programs.hyprlock = {
    enable = true;
    settings = {
      general = {
        disable_loading_bar = true;
        hide_cursor = true;
        grace = 0;
      };
    
      background = lib.mkForce [
        {
          path = "screenshot";
          blur_passes = 2;
          blur_size = 5;
        }
      ];
    
      input-field = let
        colorsRaw = config.lib.stylix.colors;
        mkRgba =
          opacity: color:
          let
            r = colorsRaw."${color}-rgb-r";
            g = colorsRaw."${color}-rgb-g";
            b = colorsRaw."${color}-rgb-b";
          in
            "rgba(${r}, ${g}, ${b}, ${builtins.toString opacity})";
      in
        lib.mkForce [
          {
            size = "200, 50";
            position = "0, 0";
    
            fade_on_empty = true;
    
            dots_center = true;
            dots_fade_time = 0;
            rounding = 10;
            outline_thickness = 1;
    
            placeholder_text = "Enter password...";
            fail_text = "Incorrect";
    
            check_color = mkRgba 0.5 "base0A";
            fail_color = mkRgba 0.5 "base08";
            font_color =  mkRgba 0.9 "base05";
            inner_color = mkRgba 0.4 "base00";
            outer_color = mkRgba 0.7 "base03";
          }
        ];
    };
  };
}

