{ config
, pkgs
, lib
, options
, ...
}:
let
  cfg = config.catppuccin.wezterm;
  flavor = config.catppuccin.flavor;
  src = pkgs.fetchFromGitHub
    {
      owner = "catppuccin";
      repo = "wezterm";
      rev = "b1a81bae74d66eaae16457f2d8f151b5bd4fe5da";
      sha256 = "";
    };
  toUpperFirst = with lib.strings; s: with builtins; toUpper (substring 0 1 s);
  toLowerRest = with lib.strings; s: with builtins; toLower (substring 1 (-1) s);
  capitalize = with lib.strings; word: (toUpperFirst word) + (toLowerRest word);
in
with lib;
{
  options = {
    catppuccin.wezterm = {
      enable = mkOption
        {
          type = types.bool;
          default = false;
          example = true;
          description = "Enable wezterm theming.";
        };
      adaptive = {
        enable = mkOption {
          type = types.bool;
          default = false;
          example = true;
          description = "Enable syncing OS theme.";
        };
        light = mkOption {
          type = types.enum [ "latte" "frappe" "macciato" "mocha" ];
          default = "latte";
          description = "Light theme.";
        };
        dark = mkOption {
          type = types.enum [ "latte" "frappe" "macciato" "mocha" ];
          default = "mocha";
          description = "Dark theme.";
        };
      };
    };
  };

  config = mkIf cfg.enable {
    programs.wezterm = {
      enable = true;
      # TODO: make font and tab bar configurable or remove them
      extraConfig = ''
        function scheme_for_appearance(appearance)
          if appearance:find "Dark" then
            return "Catppuccin ${capitalize cfg.adaptive.dark}"
          else
            return "Catppuccin ${capitalize cfg.adaptive.light}"
          end
        end

        return {
          font = wezterm.font "BlexMono Nerd Font",
          font_size = 15.0,

          enable_tab_bar = false,

          color_scheme = ${
            if cfg.adaptive.enable
            then ''scheme_for_appearance(wezterm.approved_colorscheme())''
            else ''"Catppuccin ${capitalize flavor}"''
          }
        }
      '';
    };
  };
}
