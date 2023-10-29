{ config
, lib
, pkgs
, ...
}:
with lib;
{
  options = {
    catppuccin = {
      flavor = mkOption
        {
          type = types.enum [ "latte" "frappe" "macciato" "mocha" ];
          default = "latte";
          description = "The flavor to use.";
        };
    };
  };

  imports = [
    ./bat.nix
    ./wezterm.nix
  ];
}
