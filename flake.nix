{
  description = "Lulu: the raspberry pi 5 backup server flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    rpi.url = "github:nvmd/nixos-raspberrypi/main";
  };

  # Optional: Binary cache for the rpi flake
  nixConfig = {
    extra-substituters = [
      "https://nixos-raspberrypi.cachix.org"
    ];
    extra-trusted-public-keys = [
      "nixos-raspberrypi.cachix.org-1:4iMO9LXa8BqhU+Rpg6LQKiGa2lsNh/j2oiYLNOQ5sPI="
    ];
  };

  outputs = { self, nixpkgs, rpi, ... }@ inputs: 
  let
    system = "aarch64-linux";
  in { 
    nixosConfigurations = {
      inherit system;

      lulu = rpi.lib.nixosSystem {
        specialArgs = inputs;
        modules = [ 
          rpi.nixosModules.raspberry-pi-5.base
          rpi.nixosModules.raspberry-pi-5.page-size-16k
          rpi.nixosModules.raspberry-pi-5.display-vc4
          rpi.nixosModules.raspberry-pi-5.bluetooth

          rpi.nixosModules.usb-gadget-ethernet # Configures USB Gadget/Ethernet - Ethernet emulation over USB

          ./pi5-configtxt.nix
          
          ./configuration.nix
        
        ];
      };
    };
  };
}
