{ pkgs, ... }:
let
    #package = import ../packages/percona-server80.nix { inherit pkgs; };
    package = pkgs.mysql80;
in {
    services.mysql = {
        inherit package;
        enable = true;
        dataDir = "/zroot/mysql";
    };
}
