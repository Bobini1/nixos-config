{
  inputs,
  pkgs,
  lib,
  config,
  ...
}:
{
  imports = [
    ./atuin.nix
    ./bat.nix
    ./btop.nix
    ./cava.nix
    ./direnv.nix
    ./eza.nix
    ./fastfetch.nix
    ./shell.nix
    ./zoxide.nix
  ];

  home.packages = with pkgs; [
      dust
      duf
      zip
      unzip
      unrar
      p7zip
      wget
      ripgrep
  ];
}
