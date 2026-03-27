{
  description = "Lulu: the raspberry pi 5 backup server flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    rpi.url = "github:nvmd/nixos-raspberrypi/main";
  };

  outputs = { self, nixpkgs, ... }: { 
    nixosConfigurations = {
      lulu = nixpkgs.lib.nixosSystem {
        system = "aarch64-linux";
        modules = [ ./configuration.nix ];
      };
    };
  };
}
