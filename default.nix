with (import <nixpkgs> {});

let env = bundlerEnv {
  name = "suffix";
  inherit ruby;
  gemfile = ./Gemfile;
  lockfile = ./Gemfile.lock;
  gemset = ./gemset.nix;
};

in stdenv.mkDerivation {
  name = "suffix";
  buildInputs = [bundler ruby imagemagick];

  shellHook = ''
    exec ${env}/bin/jekyll serve
  '';
}
