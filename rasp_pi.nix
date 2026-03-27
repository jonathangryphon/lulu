{ config, pkgs, ...}:

{ 
  # Raspberry Pi 5 specific configurations
  
  # Boot method
  boot.loader.rpi.bootloader = "kernel" #explicitly stating the default and recommended bootloader for new installs

  # My attempt at all the pi configuration details regarding the main flake stuff
  nixosConfigurations.lulu = nixos-raspberrypi.lib.nixosSystem {
    specialArgs = inputs;
    modules = [
      {
        # Hardware specific configuration, see section below for a more complete
        # list of modules
        imports = with nixos-raspberrypi.nixosModules; [
          raspberry-pi-5.base
          raspberry-pi-5.page-size-16k
          raspberry-pi-5.display-vc4
          raspberry-pi-5.bluetooth
        ];
      }

      ({ config, pkgs, lib, ... }: {
        networking.hostName = "lulu";

        system.nixos.tags = let
          cfg = config.boot.loader.raspberry-pi;
        in [
          "raspberry-pi-${cfg.variant}"
          cfg.bootloader
          config.boot.kernelPackages.kernel.version
        ];
      })

      # ...

    ];
  };
}
