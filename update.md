# Review what will change
nix flake update

# See the configuration diff
git diff flake.lock

# Test the new system without making it the default boot entry
sudo nixos-rebuild test --flake .#your-hostname

# If everything works, make it permanent
sudo nixos-rebuild switch --flake .#your-hostname
