{ pkgs, ... }:

{
  imports = [
    ./cp_tool.nix
    ./precomp_bits.nix
  ];

  home.packages = [
    # System information
    pkgs.btop
    pkgs.htop
    pkgs.neofetch

    # System tools
    pkgs.cloc
    pkgs.tree
    pkgs.file
    pkgs.psmisc

    # Audio tools
    pkgs.bluetui

    # Build tools
    pkgs.bear
    pkgs.cmake
    pkgs.gcc
    pkgs.gnumake
    pkgs.ninja
    pkgs.scons

    # Debugging tools
    pkgs.gdb
    pkgs.valgrind

    # Compression tools
    pkgs.zip
    pkgs.unzip

    # Networking tools
    pkgs.netcat-gnu
    pkgs.openfortivpn
    pkgs.wget
    pkgs.yt-dlp

    # Viewers
    pkgs.sxiv

    # Nix tools
    pkgs.appimage-run
    pkgs.steam-run-free
    pkgs.nix-inspect
  ];
}
