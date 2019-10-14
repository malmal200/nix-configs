{ pkgs ? import <nixpkgs> {} }:
let
    version = "8.0.16-7";
in pkgs.percona-server.overrideAttrs (oldAttrs: {
    name = "percona-server80";
    buildInputs = oldAttrs.buildInputs ++ [ pkgs.rapidjson pkgs.curl pkgs.boost ];
    # patches = [
        # ./no-werror.patch
    # ];
    src = pkgs.fetchurl {
        url = "https://www.percona.com/downloads/Percona-Server-LATEST/Percona-Server-${version}/source/tarball/percona-server-${version}.tar.gz";
        sha256 = "1677jm271l8jy7566r7lb5z1bfbfrc50yfkvggs58w4i4df6i3wg";
    };
    meta = pkgs.percona-server.meta // { inherit version; };
})
