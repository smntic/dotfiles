{ ... }:

{
  programs.git = {
    enable = true;
    settings.user = {
      name = "Simon Ashton";
      email = "simon@smntic.dev";
    };
  };
}
