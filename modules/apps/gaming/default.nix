{
  pkgs,
  inputs,
  ...
}: {
  home.packages = with pkgs; [
    protonup-ng
    steam-run
    protontricks
    wineWow64Packages.stable
    winetricks
    bottles
    prismlauncher
  ];
}
