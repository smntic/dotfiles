{ ... } :

{
  imports = [
    ./apps/apps.nix
    ./browser/browser.nix
    ./desktop/desktop.nix
    ./editor/editor.nix
    ./git/git.nix
    ./terminal/terminal.nix
    ./theme/theme.nix
  ];

  home.stateVersion = "24.11"; 
}
