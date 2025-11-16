{ pkgs, ... }:
{
  fonts = {
    fontDir.enable = true;
    enableDefaultPackages = true;
    packages = with pkgs; [
      nerd-fonts.iosevka
      nerd-fonts.jetbrains-mono
      noto-fonts-color-emoji
      ipafont # Japanese
      kochi-substitute # Japanese
      baekmuk-ttf # Korean
    ];
  };
}
