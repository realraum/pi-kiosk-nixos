{
 inputs = {
    nixpkgs.url = github:NixOS/nixpkgs/nixos-unstable;
  };

  outputs = { self, nixpkgs }: let
    supportedSystems = [ "x86_64-linux" "aarch64-linux" ];
    forAllSystems = f: nixpkgs.lib.genAttrs supportedSystems (system: f system);
  in {
    packages = forAllSystems (system:
      let
        pkgs = (import nixpkgs {
          inherit system;
          overlays = [ self.overlays.default ];
        });
      in
      {
      }
    );

    formatter = forAllSystems (system:
      let
        pkgs = (import nixpkgs {
          inherit system;
          overlays = [ self.overlays.default ];
        });
      in
      pkgs.nixfmt-rfc-style
    );

    overlays.default = import ./overlay.nix;

    nixosConfigurations.pi-kiosk = nixpkgs.lib.nixosSystem {
      system = "aarch64-linux";
      modules = [
        "${nixpkgs}/nixos/modules/installer/sd-card/sd-image-aarch64.nix"
        ./configuration.nix
        {
          nixpkgs.overlays = [
            self.overlays.default
          ];
        }
      ];
    };
  };
}
