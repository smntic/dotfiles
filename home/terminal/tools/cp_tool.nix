{ pkgs, inputs, ... }:

{
  home = {
    packages = [
      inputs.cp-tool.packages.${pkgs.system}.cptool-py
    ];
    shellAliases = {
      cpt = "cpt -tf=${./.}/templates/";
    };
  };
}
