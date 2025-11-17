# Edit this configuration file to define what should be installed onbobini
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running `nixos-help`).
{
  pkgs,
  username,
  inputs,
  ...
}:
{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ../../modules/common
    ../../modules/nix
    ../../modules/fonts
    ../../modules/services/tailscale.nix
    ../../modules/services/fwupd.nix
    ../../modules/services/udev.nix
    ../../modules/services/ssh.nix
    ../../modules/overlays
    ../../modules/graphics/amd.nix
    ../../modules/desktops/theming/stylix.nix
    ../../modules/desktops/plasma.nix
  ];

  # Use the systemd-boot EFI boot loader.
  boot = {
    loader = {
      systemd-boot = {
        enable = true;
        edk2-uefi-shell.enable = true;
        # windows."11".efiDeviceHandle = "HD1b";
        configurationLimit = 20;
      };
      efi = {
        canTouchEfiVariables = true;
      };
    };
    # Add support for Windows partitions
    supportedFilesystems = [ "ntfs" ];
  };

  # Enabling latest linux kernel
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # Power management
  powerManagement = {
    enable = true;
    powertop.enable = false;
    cpuFreqGovernor = "ondemand";
  };

  hardware = {
    cpu.amd.updateMicrocode = true;

    graphics = {
      extraPackages = with pkgs; [
        libva-vdpau-driver
      ];
    };
    bluetooth = {
      enable = true;
    };
    steam-hardware.enable = true;
  };

  programs.steam = {
    enable = true;
    gamescopeSession.enable = false;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
    localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
  };

  programs.gamescope = {
    enable = false;
    env = {
      __GLX_VENDOR_LIBRARY_NAME = "amdgpu";
    };
  };

  programs.nix-ld = {
    enable = true;
  };

  services.xserver = {
    enable = false;
    videoDrivers = [ "amdgpu" ];
    # Set the refresh rate for the monitor
    config = ''
      Section "Monitor"
        Identifier "DP-0"
        Option "PreferredMode" "2560x1440_143.98"
        Option "RefreshRate" "143.98"
      EndSection
    '';
    xkb.layout = "pl";
  };
  services.libinput = {
    enable = true;
    mouse = {
      accelProfile = "flat";
    };
    touchpad = { };
  };

  networking = {
    hostName = "bobini";
    networkmanager = {
      enable = true;
      wifi.macAddress = "random";
    };
    firewall = {
      allowedTCPPorts = [
        22
        24070
        25565
      ];
      allowedUDPPorts = [
        22
        24070
      ];
      enable = true;
    };
  };

  # Set your time zone.
  time.timeZone = "Europe/Warsaw";

  i18n = {
    defaultLocale = "pl_PL.UTF-8";
    extraLocaleSettings = {
      LC_ADDRESS = "pl_PL.UTF-8";
      LC_IDENTIFICATION = "pl_PL.UTF-8";
      LC_MEASUREMENT = "pl_PL.UTF-8";
      LC_MONETARY = "pl_PL.UTF-8";
      LC_NAME = "pl_PL.UTF-8";
      LC_NUMERIC = "pl_PL.UTF-8";
      LC_PAPER = "pl_PL.UTF-8";
      LC_TELEPHONE = "pl_PL.UTF-8";
      LC_TIME = "pl_PL.UTF-8";
    };
  };

  services.pulseaudio.enable = false;
  services.pipewire = {
    enable = true;
    alsa = {
      enable = true;
      support32Bit = true;
    };
    pulse.enable = true;
    wireplumber.enable = true;
    # If you want to use JACK applications, uncomment this
    jack.enable = true;
  };

  security.rtkit.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  services.gvfs.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.${username} = {
    createHome = true;
    isNormalUser = true;
    initialPassword = "nix";
    extraGroups = [
      "wheel"
      "storage"
      "networkmanager"
      "libvirtd"
      "docker"
    ];
    packages = with pkgs; [ libz ];
  };

  # Auto-login
  services.displayManager.autoLogin.enable = true;
  services.displayManager.autoLogin.user = "bobini";

  environment.variables = {
    EDITOR = "emacs";
    MANPAGER = "less -FR";
    PULSE_LATENCY_MSEC = "50";
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget

  environment.systemPackages = with pkgs; [
    openrgb-with-all-plugins
    timeshift
    kdePackages.polkit-kde-agent-1
    kdePackages.ksystemlog
    gparted
  ];

  programs.java = { enable = true; package = pkgs.openjdk17; };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  programs.dconf = {
    enable = true;
  };

  services.hardware.openrgb = {
    enable = true;
    motherboard = "amd";
  };

  virtualisation = {
    libvirtd = {
      enable = true;
      qemu = {
        swtpm.enable = true;
      };
    };
    docker = {
      enable = true;
      enableOnBoot = true;
    };
  };

  programs.virt-manager.enable = true;
  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?
}
