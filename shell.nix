{ pkgs ? import <nixpkgs> {} }:
with pkgs;
mkShell {
  buildInputs = [ elmPackages.elm nodejs chromium ];
  shellHook = ''
    export PATH=./node_modules/.bin:$PATH
    export PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=true
    export CHROMIUM_PATH=${chromium}/bin/chromium
    export PUPPETEER_PRODUCT=firefox
  '';
}
