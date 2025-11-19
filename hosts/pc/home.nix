{
  config,
  pkgs,
  username,
  nix-colors,
  inputs,
  plasma-manager,
  rhythmgame,
  ...
}:
{
  imports = [
    nix-colors.homeManagerModules.default
    #../../modules/desktops/theming/gtk.nix # TODO Look for some improvements as GTK4/Libadwaita looks horrible
    ../../modules/browsers
    ../../modules/apps
    ../../modules/apps/gaming
    ../../modules/git
    ../../modules/media
    ../../modules/editors
    ../../modules/shell
    ../../modules/services
  ];
  programs.nushell.enable = true;
  colorScheme = nix-colors.colorSchemes.gruvbox-dark-medium;
  stylix = {
    enable = true;
    targets.firefox.profileNames = [ "default" ];
  };
  #colorScheme = (import ../../modules/desktops/theming/colorschemes/matcha-dark.nix);

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "${username}";
  home.homeDirectory = "/home/${username}";

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "25.05";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  home.packages = with pkgs; [
    nvtopPackages.nvidia
    ffmpeg
    cargo
    bitwarden-desktop
    easyeffects
    wl-clipboard
    openrgb-with-all-plugins
    distrobox
    nicotine-plus
    obs-studio
    lutgen
    strawberry
    (pkgs.jetbrains.plugins.addPlugins pkgs.jetbrains.clion ["github-copilot"])
    gimp
    mattermost-desktop
    rhythmgame.packages.${stdenv.hostPlatform.system}.default
    kdePackages.kirigami-gallery
  ];

  programs.plasma = {
    enable = true;
    configFile.kded5rc = {
      "Module-gtkconfig"."autoload" = false;
    };
    workspace = {
      lookAndFeel = "org.kde.breezedark.desktop";
    };
    powerdevil = {
      AC = {
        autoSuspend = {
          action = "nothing";
        };
        turnOffDisplay = {
          idleTimeout = "never";
        };
        dimDisplay.enable = false;
      };
    };
    kscreenlocker = {
      autoLock = false;
      timeout = 0;
    };
  };

  dconf.settings = {
    "org/virt-manager/virt-manager/connections" = {
      autoconnect = [ "qemu:///system" ];
      uris = [ "qemu:///system" ];
    };
  };

  programs.pandoc = {
    enable = true;
  };

  programs.gpg = {
    enable = true;
  };

  services.gpg-agent = {
    enable = true;
    enableNushellIntegration = true;
  };

  home.sessionVariables = {
    MANPAGER = "sh -c 'col -bx | bat -l man -p'";
    MANROFFOPT = "-c";
  };

  #gtk = {
  #  enable = true;
  #  font = {
  #    name = "JetBrainsMono Nerd Font";
  #    size = 10;
  #  };

  #  #theme = {
  #  #  name = "Gruvbox-Dark-BL-LB";
  #  #  #package = inputs.stable-nixpkgs.legacyPackages."x86_64-linux".gruvbox-gtk-theme;
  #  #  package = (pkgs.gruvbox-gtk-theme.override { colorVariants = [ "dark" ]; });
  #  #};

  #  iconTheme = {
  #    name = "Gruvbox-Plus-Dark";
  #    package = pkgs.gruvbox-plus-icons;
  #  };

  #  gtk3.extraConfig = {
  #    #Settings = ''
  #    #  gtk-application-prefer-dark-theme=1
  #    #'';
  #  };

  #  gtk4.extraConfig = {
  #    #Settings = ''
  #    #  gtk-application-prefer-dark-theme=1
  #    #'';
  #  };
  #};

  #qt = {
  #  enable = false;
  #  platformTheme = "gtk";
  #  style = {
  #    name = "adwaita-dark";
  #    package = pkgs.adwaita-qt;
  #  };
  #};

  #home.sessionVariables.GTK_THEME = "Gruvbox-Plus-Dark";

  programs.yt-dlp = {
    enable = true;
    settings = {
      embed-thumbnail = true;
      embed-subs = true;
      sub-langs = "all";
      downloader = "aria2c";
      downloader-args = "aria2c:'-c -x8 -s8 -k1M'";
    };
  };
}
