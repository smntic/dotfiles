{ ... }:

{
  imports = [
    ./android/android.nix
    ./audio/audio.nix
    ./boot/boot.nix
    ./desktop/desktop.nix
    ./locale/locale.nix
    ./network/network.nix
    ./printing/printing.nix
    ./theme/theme.nix
    ./tools/tools.nix
    ./users/users.nix
    ./virtualization/virtualization.nix
    ./overlays.nix
  ];

  services.logind.settings.Login = {
    HandlePowerKey = "suspend";
  };

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  system.stateVersion = "25.11";
}
