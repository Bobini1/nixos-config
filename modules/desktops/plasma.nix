{ pkgs, ... }:

{
    services.displayManager.sddm.enable = true;
    services.desktopManager.plasma6.enable = true;
    services.xserver.enable = false;

    services.xserver.xkb = {
        layout = "pl";
        variant = "";
    };
    console.keyMap = "pl2";

    systemd = {
        user.services.polkit-kde-agent-1 = {
            description = "polkit-kde-agent-1";
            wantedBy = [ "graphical-session.target" ];
            wants = [ "graphical-session.target" ];
            after = [ "graphical-session.target" ];
            serviceConfig = {
                Type = "simple";
                ExecStart = "${pkgs.kdePackages.polkit-kde-agent-1}/libexec/polkit-kde-authentication-agent-1";
                Restart = "on-failure";
                RestartSec = 1;
                TimeoutStopSec = 10;
            };
        };
    };
}
