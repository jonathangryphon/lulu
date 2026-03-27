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

  outputs = { self, nixpkgs, rpi, ... }@ inputs: { 
    nixosConfigurations = {
      lulu = nixpkgs.lib.nixosSystem {
        system = "aarch64-linux";
        modules = [ ./configuration.nix ];
      };
    };
  };
}
