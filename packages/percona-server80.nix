{ pkgs ? import <nixpkgs> {} }:
let
    version = "8.0.16-7";
in pkgs.mysql80.overrideAttrs (oldAttrs: {
    name = "percona-server80";

    src = pkgs.fetchurl {
        url = "https://www.percona.com/downloads/Percona-Server-8.0/Percona-Server-${version}/source/tarball/percona-server-${version}.tar.gz";
        sha256 = "1677jm271l8jy7566r7lb5z1bfbfrc50yfkvggs58w4i4df6i3wg";
    };

    buildInputs = oldAttrs.buildInputs ++ [
        pkgs.rapidjson pkgs.curl pkgs.boost169 pkgs.libtirpc pkgs.cyrus_sasl
    ];
    cmakeFlags = oldAttrs.cmakeFlags ++ [
        "-DWITH_ROCKSDB=0"
    ];

    meta = pkgs.percona-server.meta // { inherit version; };
})
