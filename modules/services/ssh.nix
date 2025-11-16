{ username, ... }:

{
  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false;
      LoginGraceTime = 0;
    };
  };

  users.users.${username}.openssh.authorizedKeys.keys = [
    # TODO
  ];
}
