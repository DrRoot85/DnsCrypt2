{
  description = "My configuration with DNSCrypt Proxy";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable"; # Use the unstable channel
    flake-utils.url = "github:numtide/flake-utils"; # Provides helper functions for flake definitions
  };


  outputs =
    { self, nixpkgs, ... }@inputs:
    {
      nixosConfigurations.ThinkPad-P50 = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
        modules = [
            ./dnscrypt2.nix
            ];
              };
            };
}
