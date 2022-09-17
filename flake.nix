{

  description = "Add X11 tool set_wm_class";

  outputs = { self, nixpkgs, ... }: let
    supportedSystems = [
      "x86_64-linux"  "aarch64-linux"
      "x86_64-darwin" "aarch64-darwin"
    ];
    eachSupportedSystemMap = fn:
      builtins.listToAttrs ( map ( name: {
        inherit name;     # System arch/plat pair
        value = fn name;
      } ) supportedSystems );
  in {

    overlays.set_wm_class = import ./overlay.nix;
    overlays.default      = self.overlays.set_wm_class;

    packages = eachSupportedSystemMap ( system: {
      set_wm_class = ( import nixpkgs {
        overlays = [self.overlays.default];
        inherit system;
      } ).set_wm_class;
      default = self.packages.${system}.set_wm_class;
    } );

    nixosModules = {
      set_wm_class = { ... }: {
        nixpkgs.overlays = [self.overlay];
      };
      default = self.nixosModules.set_wm_class;
    };

  };

}
