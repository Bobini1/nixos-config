{pkgs, ...}: {
  programs.vscode = {
    enable = true;
    package = pkgs.vscode;
    profiles.default = {
      extensions = with pkgs.vscode-extensions;
        [
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
        ]
        ++ pkgs.nix4vscode.forVscode [
          "theqtcompany.qt-core"
          "theqtcompany.qt-qml"
          "flix.flix"
        ];
      userSettings = {
        "github.copilot.nextEditSuggestions.enabled" = true;
        "qt-core.additionalQtPaths" = [
          {
            name = "Qt-6.10.0-linux-g++_from_PATH";
            path = "${pkgs.kdePackages.qtbase}/bin/qtpaths";
          }
        ];
      };
    };
  };
}
