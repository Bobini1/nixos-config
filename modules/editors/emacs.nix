{ pkgs, ... }@inputs:

{
  home.packages = with pkgs; [
    aspell
  ];

  programs.doom-emacs = {
    enable = true;
    doomDir = ./.doom.d;  # or e.g. `./doom.d` for a local configuration
    emacs = pkgs.emacs-unstable;
    extraPackages =
      epkgs: with epkgs; [
        vterm-toggle
        vterm
      ];
  };

  services.emacs = {
    enable = true;
    client.enable = true;
    startWithUserSession = "graphical";
  };
}
