{ pkgs, lib, config, ... }:

{
  programs.rofi = {
    enable = true;

    extraConfig = {
      monitor = -1;

      modi = "drun,run";
      show-icons = true;
      fuzzy = true;
      terminal = "kitty";

      # Based on https://www.reddit.com/r/qtools/comments/kaiaa8/comment/i4ifgyf
      kb-row-up = "Up,Control+k,Shift+Tab,Shift+ISO_Left_Tab";
      kb-row-down = "Down,Control+j";
      kb-accept-entry = "Control+m,Return,KP_Enter";
      kb-remove-to-eol = "Control+Shift+e";
      kb-mode-next = "Shift+Right,Control+Tab,Control+l";
      kb-mode-previous = "Shift+Left,Control+Shift+Tab,Control+h";
      kb-remove-char-back = "BackSpace";
      kb-cancel = "Escape,Control+c";
      kb-mode-complete = ""; # Otherwise bound to Control+l
      kb-secondary-copy = ""; # Otherwise bound to Control+c
    };

    theme = let
      inherit (config.lib.formats.rasi) mkLiteral;
      colorsRaw = config.lib.stylix.colors;
      colors = colorsRaw.withHashtag;
      mkRgba =
        opacity': color:
        let
          r = colorsRaw."${color}-rgb-r";
          g = colorsRaw."${color}-rgb-g";
          b = colorsRaw."${color}-rgb-b";
        in
          mkLiteral "rgba ( ${r}, ${g}, ${b}, ${opacity'} % )";
      none = mkLiteral "rgba ( 0, 0, 0, 0 % )";
      mkRgb = mkRgba "100";
      rofiOpacity = toString 95;
    in
      lib.mkForce {
        "*" = {
          width = 512;

          background = mkRgba rofiOpacity "base00";
          lightbg = mkRgba rofiOpacity "base01";
          red = mkRgba rofiOpacity "base08";
          blue = mkRgba rofiOpacity "base0D";
          lightfg = mkRgba rofiOpacity "base0D";
          foreground = mkRgba rofiOpacity "base05";

          background-color = none;
          separatorcolor = mkLiteral "@foreground";
          border-color = mkLiteral "@foreground";
          selected-normal-foreground = mkLiteral "@lightbg";
          selected-normal-background = mkLiteral "@lightfg";
          selected-active-foreground = mkLiteral "@background";
          selected-active-background = mkLiteral "@blue";
          selected-urgent-foreground = mkLiteral "@background";
          selected-urgent-background = mkLiteral "@red";
          normal-foreground = mkLiteral "@foreground";
          normal-background = none;
          active-foreground = mkLiteral "@blue";
          active-background = mkLiteral "@background";
          urgent-foreground = mkLiteral "@red";
          urgent-background = mkLiteral "@background";
          alternate-normal-foreground = mkLiteral "@foreground";
          alternate-normal-background = none;
          alternate-active-foreground = mkLiteral "@blue";
          alternate-active-background = mkLiteral "@lightbg";
          alternate-urgent-foreground = mkLiteral "@red";
          alternate-urgent-background = mkLiteral "@lightbg";

          # Text Colors
          base-text = mkRgb "base05";
          selected-normal-text = mkRgb "base01";
          selected-active-text = mkRgb "base00";
          selected-urgent-text = mkRgb "base00";
          normal-text = mkRgb "base05";
          active-text = mkRgb "base0D";
          urgent-text = mkRgb "base08";
          alternate-normal-text = mkRgb "base05";
          alternate-active-text = mkRgb "base0D";
          alternate-urgent-text = mkRgb "base08";
        };

        window = {
          border = mkLiteral "1px";
          border-color = mkLiteral colors.base0D;
          background-color = mkLiteral "@background";

          padding = mkLiteral "5px";
        };

        message.border-color = mkLiteral "@separatorcolor";

        textbox.text-color = mkLiteral "@base-text";

        listview = {
          padding = mkLiteral "2px 0px 0px 0px";
          lines = 10;
        };

        element = {
          padding = mkLiteral "3px 5px 3px 5px";
          spacing = mkLiteral "5px";
        };

        element-text = {
          background-color = mkLiteral "inherit";
          text-color = mkLiteral "inherit";
          font = "monospace 14px";
        };

        element-icon = {
          background-color = mkLiteral "inherit";
          text-color = mkLiteral "inherit";
          size = mkLiteral "1.9ch";
        };

        "element normal.normal" = {
          background-color = mkLiteral "@normal-background";
          text-color = mkLiteral "@normal-text";
        };
        "element normal.urgent" = {
          background-color = mkLiteral "@urgent-background";
          text-color = mkLiteral "@urgent-text";
        };
        "element normal.active" = {
          background-color = mkLiteral "@active-background";
          text-color = mkLiteral "@active-text";
        };

        "element selected.normal" = {
          background-color = mkLiteral "@selected-normal-background";
          text-color = mkLiteral "@selected-normal-text";
        };
        "element selected.urgent" = {
          background-color = mkLiteral "@selected-urgent-background";
          text-color = mkLiteral "@selected-urgent-text";
        };
        "element selected.active" = {
          background-color = mkLiteral "@selected-active-background";
          text-color = mkLiteral "@selected-active-text";
        };

        "element alternate.normal" = {
          background-color = mkLiteral "@alternate-normal-background";
          text-color = mkLiteral "@alternate-normal-text";
        };
        "element alternate.urgent" = {
          background-color = mkLiteral "@alternate-urgent-background";
          text-color = mkLiteral "@alternate-urgent-text";
        };
        "element alternate.active" = {
          background-color = mkLiteral "@alternate-active-background";
          text-color = mkLiteral "@alternate-active-text";
        };

        scrollbar.handle-color = mkLiteral "@normal-foreground";
        sidebar.border-color = mkLiteral "@separatorcolor";
        button.text-color = mkLiteral "@normal-text";
        "button selected" = {
          background-color = mkLiteral "@selected-normal-background";
          text-color = mkLiteral "@selected-normal-text";
        };

        inputbar = {
          padding = mkLiteral "5px";
          spacing = mkLiteral "5px";
          text-color = mkLiteral "@normal-text";
          border = mkLiteral "0px 0px 1px 0px";
          border-color = mkLiteral "@separatorcolor";
        };

        case-indicator.text-color = mkLiteral "@normal-text";

        entry = {
          text-color = mkLiteral "@normal-text";
          font = "monospace 14px";
        };

        prompt = {
          text-color = mkLiteral "@normal-text";
          font = "monospace 14px";
        };

        textbox-prompt-colon.text-color = mkLiteral "inherit";
      };
  };
}

