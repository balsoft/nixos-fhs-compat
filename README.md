# A library that implements support for LSB and FHS in NixOS.

## :warning: This library is only intended to be used in containers. Usage on a NixOS host system may result in irreproducibility and prevent you from contributing to nixpkgs. Use at your own risk.

## TLDR

```nix
containers.fhs-compat.config = {...}: {
  imports = [ inputs.nixos-fhs-compat.nixosModules.combined ];
  environment.fhs.enable = true;
  environment.fhs.linkLibs = true;
  environment.lsb.enable = true;
  environment.lsb.support32Bit = true;
}
```

## Credits

All the hard work was done by @matthewbauer
