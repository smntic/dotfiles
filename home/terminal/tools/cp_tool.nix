{ pkgs, inputs, ... }:

{
  home = {
    packages = [
      inputs.cp-tool.packages.${pkgs.stdenv.hostPlatform.system}.cptool-py
    ];
    shellAliases = {
      cpt = "cpt -tf=${./.}/templates/";
    };
  };
}
