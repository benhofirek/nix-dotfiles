{ username, ... }:

{
  virtualisation.containers.registries.settings = {
    registry = [
      { location = "docker.io"; }
    ];
    unqualified-search-registries = [
      "docker.io"
    ];
  };

  virtualisation.podman = {
    enable = true;

    # Optional: create a `docker` alias so docker CLI commands work
    dockerCompat = true;

    # Required for containers under podman-compose to talk to each other
    defaultNetwork.settings.dns_enabled = true;
  };

  users.users.${username} = {
    extraGroups = [
      "podman"
    ];
  };
}
