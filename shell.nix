{ pkgs ? import
    (builtins.fetchTarball
      "https://github.com/NixOS/nixpkgs/archive/refs/heads/nixos-21.11.tar.gz")
    { }
}:
with pkgs;
mkShell {
  buildInputs = [
    chromium
    elmPackages.elm
    elmPackages.elm-format
    elmPackages.elm-json
    (ghc.withPackages (pkgs: [ pkgs.pandoc ]))
    nodejs
    python3
  ];
  shellHook = ''
    export PATH=./node_modules/.bin:$PATH
    export PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=true
    export CHROMIUM_PATH=${chromium}/bin/chromium
    export PUPPETEER_PRODUCT=firefox
  '';
}
