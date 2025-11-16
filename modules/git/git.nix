{ e-mail, ... }:

{
  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "Tomasz Kalisiak";
        email = "${e-mail}";
      };
      init.defaultBranch = "master";
      rebase = {
        autoSquash = true;
        autoStash = true;
      };
      rerere = {
        autoupdate = true;
        enabled = true;
      };
      push.autoSetupRemote = true;
    };
    ignores = [
      ".direnv/"
      "result"
    ];
  };
}
