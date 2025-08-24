{ ... }:

{
  programs.waybar.style = ''
    /* We have to be more specific than this, because stylix overwrites it below this in the config file.
    * {
      font-family: "monospace";
    }
    */

    label.module {
      font-family: "monospace";
    }

    #workspaces label {
      font-family: "monospace";
    }

    #workspaces button {
      padding: 0 0.3em;
      border-radius: 0;
      font-weight: normal;
    }

    #waybar #workspaces button {
      border-bottom: none;
    }

    #workspaces button:hover {
      background: alpha(@base04, 0.2);
    }

    #workspaces button.active {
      background: alpha(@base04, 0.1);
    }

    #workspaces button.active:hover {
      background: alpha(@base04, 0.2);
    }

    #workspaces button.urgent {
      background: alpha(@base08, 0.3);
    }

    .modules-right label.module {
      margin-right: 0.35em;
    }

    #network.wifi, #network.linked, #network.ethernet {
      color: @base0B;
    }

    #network.disabled, #network.disconnected {
      color: @base08;
    }

    #wireplumber.muted {
      color: @base09;
    }

    #custom-separator {
      color: @base04;
    }
  '';
}
