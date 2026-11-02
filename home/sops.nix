{ inputs, config, ... }:

let
  keyFile = "${config.home.homeDirectory}/.config/sops/age/keys.txt";
in
{
  imports = [
    inputs.sops-nix.homeManagerModules.sops
  ];

  sops = {
    age = {
      inherit keyFile;
      generateKey = false;
    };
    defaultSopsFile = ../secrets/secrets.yaml;
    defaultSopsFormat = "yaml";

    secrets = {
      ssh_key = {
        mode = "0400";
        path = "${config.home.homeDirectory}/.ssh/id_rsa";
      };
      wifi_password.mode = "0400";
      github_oauth_token.mode = "0400";
      
      deepseek_api_key = {
        mode = "0400";
      };
    };

    templates = {
      "gh-hosts.yml" = {
        mode = "0600";
        path = "${config.xdg.configHome}/gh/hosts.yml";
        content = ''
          github.com:
            user: BenediktHofirek
            git_protocol: ssh
            oauth_token: ${config.sops.placeholder.github_oauth_token}
        '';
      };
    };
  };

  home.sessionVariables = {
    SOPS_AGE_KEY_FILE = keyFile;
  };
}
