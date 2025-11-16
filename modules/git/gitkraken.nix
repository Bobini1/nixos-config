{ pkgs, ... }:

{
  home.packages = with pkgs; [
    gitkraken
    gk-cli
  ];
}
