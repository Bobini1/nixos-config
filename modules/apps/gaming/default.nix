{ pkgs, inputs, ... }:
{
  home.packages = with pkgs; [
    protonup-ng
    steam-run
    protontricks
    wineWowPackages.stable
    winetricks
    bottles
    prismlauncher
  ];
}
