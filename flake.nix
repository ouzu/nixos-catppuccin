{
  description = "The Catppuccin Theme for NixOS";

  outputs = { self, nixpkgs }:
    {
      homeManagerModules.default = import ./home;
    };
}
