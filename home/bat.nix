{ config
, pkgs
, lib
, options
, ...
}:
let
  cfg = config.catppuccin.bat;
  flavor = config.catppuccin.flavor;
  src = pkgs.fetchFromGitHub
    {
      owner = "catppuccin";
      repo = "bat";
      rev = "ba4d16880d63e656acced2b7d4e034e4a93f74b1";
      sha256 = "sha256-6WVKQErGdaqb++oaXnY3i6/GuH2FhTgK0v4TN4Y0Wbw=";
    };
in
with lib; {
  options = {
    catppuccin.bat = {
      enable = mkOption
        {
          type = types.bool;
          default = false;
          example = true;
          description = "Enable bat theming.";
        };
    };
  };

  config = mkIf cfg.enable {
    programs.bat = {
      enable = true;
      config = {
        theme = "catppuccin-${flavor}";
      };
      themes = {
        catppuccin-latte = builtins.readFile (src + "/Catppuccin-latte.tmTheme");
        catppuccin-frappe = builtins.readFile (src + "/Catppuccin-frappe.tmTheme");
        catppuccin-macchiato = builtins.readFile (src + "/Catppuccin-macchiato.tmTheme");
        catppuccin-mocha = builtins.readFile (src + "/Catppuccin-mocha.tmTheme");
      };
    };
  };
}
