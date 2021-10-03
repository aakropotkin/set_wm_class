{
  description = "Add X11 tool set_wm_class";

  inputs.nixpkgs.follows = "nix/nixpkgs";

  outputs = { self, nix, nixpkgs, ... }: {

    overlays.set_wm_class = import ./overlay.nix;
    overlay = self.overlays.set_wm_class;

    packages.x86_64-linux.set_wm_class = ( import nixpkgs {
      sys = "x86_64-linux";
      overlays = [self.overlay nix.overlay];
    } ).set_wm_class;
    defaultPackage.x86_64-linux = self.packages.x86_64-linux.set_wm_class;

    nixosModules.set_wm_class = { pkgs, ... }: {
      nixpkgs.overlays = [self.overlay];
    };
    nixosModule = self.nixosModules.set_wm_class;

  };
}
