{
  description = "A flake to build konoui/lipo Go package";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };

        lipo = pkgs.buildGoModule rec {
          pname = "lipo";
          version = "0.9.3";

          src = pkgs.fetchFromGitHub {
            owner = "konoui";
            repo = "lipo";
            rev = "v${version}";
            sha256 = "sha256-FW2mOsshpXCTTjijo0RFdsYX883P2cudyclRtvkCxa0=";
          };

          vendorHash = "sha256-7M6CRxJd4fgYQLJDkNa3ds3f7jOp3dyloOZtwMtCBQk=";
          doCheck = false;
        };
      in
        {
          packages.lipo = lipo;
          defaultPackage = lipo;
        }
    );
}

