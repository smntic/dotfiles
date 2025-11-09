{ ... }:

{
  users.users = {
    "simon" = {
      isNormalUser = true;
      extraGroups = [ "wheel" "networkmanager" "libvirtd" "kvm" "scanner" "lp" ];
      hashedPassword = "$6$rounds=4096$l2kpean.aM0buyhc$jBdmzGn7KNDLVFNIohinggosVdmUYVAxyVp.7XC5TbdcMIWkuD6BonSitTT15QGS0isPF0McCupayZEcomS2W/";
    };
  };
}
