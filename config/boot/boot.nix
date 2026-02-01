{ ... }:

{
  boot.loader = {
    grub = {
      enable = true;
      efiSupport = true;
      device = "nodev";

      backgroundColor = "#000000";
      splashImage = ./backgrounds/background.png;
      splashMode = "normal";
    };
    efi.canTouchEfiVariables = true;
  };

  # unfortunately, this seems required, for now. maybe try to remove later.
  boot.kernelParams = [
    "amdgpu.dcdebugmask=0x10"
    "snd_hda_intel.dmic_detect=0" # mic issue (not not working AT ALL)
    # fix mic clicking sound
    "snd_hda_intel.power_save=0"
    "snd_hda_intel.power_save_controller=N"
  ];
}
