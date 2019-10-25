{ pkgs ? import <nixpkgs> {} }:
let
  elmPackages = (import <nixos-unstable> {}).elmPackages;
in
with pkgs;
with stdenv;
mkDerivation {
  name = "material-components";
  buildInputs = [ elmPackages.elm nodejs ];
  shellHook = ''
    export PATH=./node_modules/.bin:$PATH
  '';
}
