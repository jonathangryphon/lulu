{ config, pkgs, ...}:

{ 
  # Raspberry Pi 5 specific configurations
  
  # Boot method
  boot.loader.raspberry-pi.bootloader = "kernel" #explicitly stating the default and recommended bootloader for new installs

}
