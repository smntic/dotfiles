{ pkgs, ... }:

let
  katagoModel = pkgs.fetchurl {
    url = "https://media.katagotraining.org/uploaded/networks/models/kata1/kata1-b18c384nbt-s9996604416-d4316597426.bin.gz";
    sha256 = "9d7a6afed8ff5b74894727e156f04f0cd36060a24824892008fbb6e0cba51f1d";
  };

  katagoConfig = pkgs.writeText "katago-analysis.cfg" ''
    numAnalysisThreads = 4
    numSearchThreads = 4
    maxVisits = 800
    nnMaxBatchSize = 16
    reportAnalysisWinratesAs = BLACK
  '';

  katagoWrapped = pkgs.writeShellScriptBin "katago-sabaki" ''
    exec ${pkgs.katagoCPU}/bin/katago analysis \
      -model ${katagoModel} \
      -config ${katagoConfig}
  '';

in {
  home.packages = [
    katagoWrapped
  ];
}
