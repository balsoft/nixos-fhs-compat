
{
  description = "A NixOS FHS+LSB compatibility layer for containers and VMs. Not recommended on hosts.";

  edition = 201909;

  outputs = { self }: {

    nixosModules = {
      fhs = import ./modules/fhs.nix;
      lsb = import ./modules/lsb.nix;

      combined = import ./default.nix;
    };

  };
}
