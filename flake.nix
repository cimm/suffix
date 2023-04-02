{
  description = "Jekyll Development Environment";

  inputs = {
    nixpkgs.url = "nixpkgs";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};

        env = pkgs.bundlerEnv {
          name = "bundler";
          ruby = pkgs.ruby_3_1;
          gemdir = ./.; # points to Gemfile.lock and gemset.nix
        };

      in with pkgs; {
        # when running `nix develop`
        devShells.default = mkShell {
          buildInputs = [ env bundix imagemagick ];
        };
      }
    );
}
