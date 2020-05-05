# A library that implements support for LSB and FHS in NixOS.

## :warning: This library is only intended to be used in containers! Do not use on NixOS hosts!

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
