{ config, lib, pkgs, ... }: {
  options.environment.fhs = {
    enable = lib.mkEnableOption
      "FHS compatibility mode (not recommended on host systems)";
    linkExes = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = ''
        Whether to link executables to /bin, /sbin and /usr/bin
      '';
    };
    linkLibs = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = ''
        Whether to link libraries from /etc/lsb to /lib, /lib64, /usr/lib
        Useful in conjunction with environment.lsb
      '';
    };
  };
  config = lib.mkIf config.environment.fhs.enable {
    systemd.tmpfiles.rules = lib.optionals config.environment.fhs.linkExes [
      "L+ /bin     - - - - /run/current-system/sw/bin"
      "L+ /sbin    - - - - /run/current-system/sw/bin"
      "L+ /usr/bin - - - - /run/current-system/sw/bin"
    ] ++ lib.optionals config.environment.fhs.linkLibs ([
      "L+ /lib     - - - - /etc/lsb/lib"
      "L+ /lib64   - - - - /etc/lsb/lib"
      "L+ /usr/lib - - - - /etc/lsb/lib"
    ]);
    environment.sessionVariables.LD_LIBRARY_PATH = lib.mkIf config.environment.fhs.linkLibs (lib.mkForce "/lib");
    system.activationScripts.binsh = lib.mkIf config.environment.fhs.linkExes (lib.mkForce "");
    system.activationScripts.usrbinenv = lib.mkIf config.environment.fhs.linkExes (lib.mkForce "");
  };
}
