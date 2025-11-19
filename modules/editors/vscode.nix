{ pkgs, ... }:
{
  programs.vscode = {
    enable = true;
    package = pkgs.vscode-fhs; # For rust-analyzer etc
    profiles.default = {
      extensions = with pkgs.vscode-extensions; [
        bbenoist.nix
        jnoortheen.nix-ide
        arrterian.nix-env-selector
        kamadorueda.alejandra
        ms-pyright.pyright
        rust-lang.rust-analyzer
        ms-python.black-formatter
        mkhl.direnv
        fill-labs.dependi
        ms-vscode.cmake-tools
        ms-vscode.cpptools
      ] ++ pkgs.nix4vscode.forVscode [
        "theqtcompany.qt-core"
        "theqtcompany.qt-qml"
      ];
      userSettings = {
        github.copilot.nextEditSuggestions.enabled = true;
      };
    };
  };
}
