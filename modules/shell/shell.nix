{
  config,
  lib,
  ...
}: let
  inherit
    (lib)
    pipe
    importTOML
    mergeAttrsList
    ;
  inherit (builtins) map;
  mergeTOML = fnames:
    pipe fnames [
      (map importTOML)
      mergeAttrsList
    ];
in {
  programs.nushell = {
    enable = true;
    extraConfig = "$env.config.show_banner = false";
  };
  programs.starship = {
    settings =
      (mergeTOML [
        ./nerd-font-symbols.toml
        ./gruvbox-rainbow.toml
      ])
      // {
        palettes.base16 = with config.lib.stylix.colors.withHashtag; {
          # gruvbox-rainbow colors
          color_time_text = base07;
          color_devenv_text = base07;
          color_language_text = base07;
          color_git_text = base07;
          color_os_username_text = base07;
          color_directory_text = base07;
          color_time = base01;
          color_devenv = base02;
          color_language = blue;
          color_git = cyan;
          color_os_username = orange;
          color_directory = yellow;
          color_success = green;
          color_replace_symbol = magenta;
          color_error = red;
        };
      };
    enable = true;
    enableNushellIntegration = true;
    enableBashIntegration = true;
  };

  home.sessionVariables = {
    STARSHIP_LOG = "error";
  };

  programs.bash = {
    enable = true;
    enableCompletion = true;
    bashrcExtra = ''
      eval "$(starship init bash)"
    '';
  };
}
