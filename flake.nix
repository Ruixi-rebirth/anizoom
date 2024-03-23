{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    devenv.url = "github:cachix/devenv";
    flake-root.url = "github:srid/flake-root";
    treefmt-nix.url = "github:numtide/treefmt-nix";
    fenix = {
      url = "github:nix-community/fenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  nixConfig = {
    extra-trusted-public-keys = "devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw=";
    extra-substituters = "https://devenv.cachix.org";
  };

  outputs = inputs@{ flake-parts, nixpkgs, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      imports = [
        inputs.devenv.flakeModule
        inputs.flake-root.flakeModule
        inputs.treefmt-nix.flakeModule
      ];
      systems = nixpkgs.lib.systems.flakeExposed;

      perSystem = { config, self', pkgs, ... }:
        {
          treefmt.config = {
            inherit (config.flake-root) projectRootFile;
            package = pkgs.treefmt;
            programs.nixpkgs-fmt.enable = true;
            programs.rustfmt.enable = true;
          };
          packages.default = pkgs.callPackage ./build.nix { };
          devShells.default = pkgs.mkShell {
            inputsFrom = [
              config.packages.default
              config.flake-root.devShell
              self'.devShells.anizoom
            ];
            buildInputs = with pkgs; [
            ];
            shellHook =
              ''
              '';
          };
          devenv.shells.anizoom = {
            name = "anizoom";
            languages.rust = {
              enable = true;
              channel = "nightly";
            };
            enterShell = ''
              echo $'\e[1;32mWelcom to anizoom project~\e[0m'
            '';
          };
        };
    };
}
