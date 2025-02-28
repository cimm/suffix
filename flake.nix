{
  description = "Jekyll Development Environment";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};

        gems = pkgs.bundlerEnv {
          name = "bundler";
          ruby = pkgs.ruby_3_4;
          gemdir = ./.; # points to Gemfile.lock and gemset.nix
        };

      in with pkgs; {
        # when running `nix develop`
        devShells.default = mkShell {
          buildInputs = [ gems bundix imagemagick ];
        };
      }
    );
}
