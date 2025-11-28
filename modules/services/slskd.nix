{ config, ... }:
{
  config.age.secrets.slskd.file = ../../secrets/slskd.age;
  config.services.slskd = {
    enable = true;
    environmentFile = config.age.secrets.slskd.path;
    openFirewall = false;
    domain = null;
    settings = {
        flags.force_share_scan = true;
        shares.directories = [
            "/mnt/buldak/Muzyka"
            "/mnt/buldak/Sows"
            "/mnt/buldak/SowsExclusive"
        ];
        directories.downloads = "/mnt/buldak/Muzyka/complete";
        remote_file_management = true;
    };
  };
}
