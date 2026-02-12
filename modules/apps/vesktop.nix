{
  config,
  pkgs,
  ...
}: {
  # Vesktop
  programs.vesktop.enable = true;
  # And Discord too, just in case
  programs.discord.enable = true;
}
