
{
  description = "A NixOS FHS+LSB compatibility layer for containers and VMs. Not recommended on hosts.";

  outputs = { self }: {

    nixosModules = {
      fhs = import ./modules/fhs.nix;
      lsb = import ./modules/lsb.nix;

      combined = import ./default.nix;
    };

  };
}
