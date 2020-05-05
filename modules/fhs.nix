{ config, lib, pkgs, ... }: {
  options.environment.fhs = {
    enable = lib.mkEnableOption
      "FHS compatibility mode (not recommended on host systems)";
    linkExes = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = ''
        Whether to link executables to /bin and /usr/bin
      '';
    };
    linkLibs = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = ''
        Whether to link libraries from LD_LIBRARY_PATH_AFTER to /lib, /lib64, /usr/lib
        Useful in conjunction with environment.lsb
      '';
    };
  };
  config = lib.mkIf config.environment.fhs.enable {
    systemd.tmpfiles.rules = lib.optionals config.environment.fhs.linkExes [
      "L+ /bin     - - - - /run/current-system/sw/bin"
      "L+ /usr/bin - - - - /run/current-system/sw/bin"
    ] ++ lib.optionals config.environment.fhs.linkLibs (let
      libdir = pkgs.buildEnv {
        name = "fhs-libdir";
        paths = builtins.filter builtins.isString (builtins.split ":" config.environment.sessionVariables.LD_LIBRARY_PATH_AFTER);
      };
    in [
      "L+ /lib     - - - - ${libdir}"
      "L+ /lib64   - - - - ${libdir}"
      "L+ /usr/lib - - - - ${libdir}"
    ]);
  };
}
