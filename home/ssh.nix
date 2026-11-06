{ pkgs, ... }:

{
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;

    settings = {
      "*" = {
        ForwardAgent = false;
        AddKeysToAgent = "no";
        Compression = false;
        ServerAliveInterval = 0;
        ServerAliveCountMax = 3;
        HashKnownHosts = false;
        UserKnownHostsFile = "~/.ssh/known_hosts";
        ControlMaster = "no";
        ControlPath = "~/.ssh/master-%r@%n:%p";
        ControlPersist = "no";
      };

      "github.com" = {
        Host = "github.com";
        Hostname = "ssh.github.com";
        User = "git";
        Port = 443;
        IdentityFile = "~/.ssh/id_rsa";
        IdentitiesOnly = true;
      };

    };
  };

  services.ssh-agent.enable = true;

  home.file.".ssh/id_rsa.pub".source = ../keys/id_rsa.pub;
}
