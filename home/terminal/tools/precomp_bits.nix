{ pkgs, lib, ... }:

let
  precompBits = pkgs.runCommand "precomp-bits" {
    buildInputs = [ pkgs.gcc ];
  } ''
    mkdir -p $out
    export BITS_PATH=${pkgs.gcc.cc}/include/c++/${pkgs.gcc.version}/$(gcc -dumpmachine)/bits/
    cp $BITS_PATH/stdc++.h $out/
    ${pkgs.gcc}/bin/g++ -x c++-header $out/stdc++.h -o $out/stdc++.h.gch
  '';
in
  {
    options = {
      home.terminal.tools.precomp-bits.out = lib.mkOption {
        type = lib.types.str;
        description = "path to the precomp-bits derivation output";
      };
    };
    
    config = {
      home.terminal.tools.precomp-bits.out = builtins.toString precompBits;
    };
  }
