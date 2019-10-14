{ pkgs, ... }:
let
    package = import ../packages/percona-server80.nix { inherit pkgs; };
in {
    services.mysql = {
        inherit package;
        enable = true;
        dataDir = "/zroot/mysql";
    };
}
