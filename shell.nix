{ pkgs ? import <nixpkgs> {} }:
with pkgs;
mkShell {
  buildInputs = [ elmPackages.elm nodejs ];
  shellHook = ''
    export PATH=./node_modules/.bin:$PATH
  '';
}
