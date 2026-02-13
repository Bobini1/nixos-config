{
  pkgs,
  inputs,
  ...
}: {
  home.packages = with inputs.nix-jetbrains-plugins.lib; [
    (buildIdeWithPlugins pkgs "clion" ["com.github.copilot"])
  ];
}
