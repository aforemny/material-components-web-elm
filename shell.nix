{ pkgs ? import <nixpkgs> {} }:
with pkgs;
mkShell {
  buildInputs = [
    chromium
    elmPackages.elm
    (ghc.withPackages(pkgs: [ pkgs.pandoc ]))
    nodejs
  ];
  shellHook = ''
    export PATH=./node_modules/.bin:$PATH
    export PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=true
    export CHROMIUM_PATH=${chromium}/bin/chromium
    export PUPPETEER_PRODUCT=firefox
  '';
}
