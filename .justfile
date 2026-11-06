#NIX_CONFIG='experimental-features = nix-command flakes' nix shell nixpkgs#git nixpkgs#home-manager nixpkgs#just -c bash -c '[ -d ~/dotfiles ] || git clone https://github.com/YOUR_USER/dotfiles ~/dotfiles; cd ~/dotfiles && home-manager switch --flake .#laptop'

run: build open

open:
    nix run --impure github:nix-community/nixGL#nixGLDefault -- ./result/bin/run-virtualMachine-vm

build: reset
    nix build --log-format internal-json -v .#nixosConfigurations.virtualMachine.config.system.build.vm |& nom --json 

reset:
    rm -f ./*.qcow2

# --- Real machine (laptop) ---

# system only
system:
    sudo nixos-rebuild switch --flake .#laptop

# home-manager only (fast dotfile iteration)
home:
    home-manager switch --flake .#laptop

iso:
    nix build .#nixosConfigurations.iso-installer.config.system.build.isoImage

# both
switch: system home

age_key := env_var('HOME') / ".config/sops/age/keys.txt"

# NEW machine: create this machine's age key (never overwrites an existing one)
sops-keygen:
    #!/usr/bin/env bash
    set -euo pipefail
    key="{{age_key}}"
    if [ -e "$key" ]; then
        echo "Key already exists at $key, not touching it." >&2
    else
        umask 077
        mkdir -p "$(dirname "$key")"
        nix-shell -p age --run "age-keygen -o '$key'"
        chmod 600 "$key"
    fi
    echo
    echo "Public key of this machine:"
    nix-shell -p age --run "age-keygen -y '$key'"

# Any machine: print the public key (safe to copy around)
sops-pubkey:
    nix-shell -p age --run "age-keygen -y '{{age_key}}'"

# OLD machine: re-encrypt secrets after adding the new public key to .sops.yaml
sops-updatekeys:
    nix-shell -p sops --run 'sops updatekeys secrets/secrets.yaml'
