{
  config,
  pkgs,
  username,
  ...
}:
{
  programs.firefox = {
    enable = true;
    package = pkgs.wrapFirefox pkgs.floorp-bin-unwrapped {
      extraPolicies = {
        DisableTelemetry = true;
        DisableFirefoxStudies = false;
        DontCheckDefaultBrowser = false;
        EnableTrackingProtection = {
          Value = true;
          Locked = true;
          Fingerprinting = true;
        };
        DisablePocket = true;
        DisableFirefoxAccount = false;
        DisableAccounts = false;
      };
    };
  };
}
