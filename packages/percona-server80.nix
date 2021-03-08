{ pkgs ? import <nixpkgs> {} }:
let
    version = "8.0.21-12";
in pkgs.mysql80.overrideAttrs (oldAttrs: {
    name = "percona-server80";
    inherit version;

    src = pkgs.fetchurl {
        url = "https://www.percona.com/downloads/Percona-Server-8.0/Percona-Server-${version}/source/tarball/percona-server-${version}.tar.gz";
        sha256 = "1lvds94r0244rjd08chhqy2z4ma17wgdj4qqd9y5ifkn8yjhxkrd";
    };


    postPatch = oldAttrs.postPatch + ''
      substituteInPlace sql/mysqld.cc --replace 'my_getopt_skip_unknown = TRUE' 'my_getopt_skip_unknown = true'
    '';

    buildInputs = with pkgs; [
        rapidjson curl boost172 libtirpc cyrus_sasl openldap.dev
        # Build inputs from upstream mysql 8 excluding boot
        icu libedit libevent lz4 ncurses openssl protobuf re2 readline zlib zstd
        numactl libtirpc
    ];
    cmakeFlags = oldAttrs.cmakeFlags ++ [
        "-DWITH_ROCKSDB=0"
    ];

    meta = pkgs.percona-server.meta // { inherit version; };
})
