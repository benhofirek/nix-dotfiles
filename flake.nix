{
  description = "Ben's nixos setup";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";

    import-tree.url = "github:vic/import-tree";
    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=latest";
    omp.url = "github:can1357/oh-my-pi";

    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    plover-flake = {
      url = "github:openstenoproject/plover-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    matt-pocock-skills = {
      url = "github:mattpocock/skills";
      flake = false;
    };

    ponytail-skills = {
      url = "github:DietrichGebert/ponytail";
      flake = false;
    };

    caveman-skills = {
      url = "github:JuliusBrussee/caveman/";
      flake = false;
    };

  };

  outputs =
    inputs@{ flake-parts, import-tree, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {

      systems = [
        "x86_64-linux"
        # "aarch64-linux"
        # "x86_64-darwin"
        # "aarch64-darwin"
      ];

      flake =
        let
          defaultUsername = "hero";
          defaultSystem = "x86_64-linux";

          lib = inputs.nixpkgs.lib;

          hostDirs = lib.filterAttrs (n: v: v == "directory") (builtins.readDir ./hosts);
          hostNames = lib.attrNames hostDirs;

          metaFor =
            hostname:
            let
              metaPath = ./hosts/${hostname}/meta.nix;
            in
            if builtins.pathExists metaPath then import metaPath else { };
        in
        {
          nixosConfigurations = lib.genAttrs hostNames (
            hostname:
            let
              meta = metaFor hostname;
              system = meta.system or defaultSystem;
              username = meta.username or defaultUsername;
            in
            lib.nixosSystem {
              inherit system;
              specialArgs = { inherit inputs hostname username; };
              modules = [
                (import-tree ./system)
                inputs.nix-flatpak.nixosModules.nix-flatpak
                ./hosts/${hostname}/configuration.nix
              ]
              ++ lib.optional (builtins.pathExists ./hosts/${hostname}/hardware.nix) ./hosts/${hostname}/hardware.nix;
            }
          );

          homeConfigurations = lib.listToAttrs (
            map (
              hostname:
              let
                meta = metaFor hostname;
                system = meta.system or defaultSystem;
                username = meta.username or defaultUsername;
              in
              {
                # Need to include username for nh inference to work properly
                name = "${username}@${hostname}";
                value = inputs.home-manager.lib.homeManagerConfiguration {
                  pkgs = inputs.nixpkgs.legacyPackages.${system};
                  extraSpecialArgs = { inherit inputs hostname username; };
                  modules = [
                    (import-tree ./home)
                    inputs.plover-flake.homeManagerModules.plover
                    inputs.nix-index-database.homeModules.default
                    inputs.omp.homeManagerModules.default
                  ]
                  ++ lib.optional (builtins.pathExists ./hosts/${hostname}/home.nix) ./hosts/${hostname}/home.nix;
                };
              }
            ) hostNames
          );
        };
    };
}
