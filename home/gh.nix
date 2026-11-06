{
  programs.gh = {
    enable = true;
    settings = {
      editor = "nvim";
      git_protocol = "ssh";
    };
    gitCredentialHelper = {
      enable = true;
    };
    # Not possible to use sops placeholder here, hosts.yaml
    # have to be created by sops template
  };
}
