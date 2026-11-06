{ pkgs, ... }:

{
  # Can configure much more here than in home manager
  services.ollama = {
    enable = true;
    package = pkgs.ollama-cuda; # replaces acceleration = "cuda"
    host = "127.0.0.1";
    port = 11434;

    # Pulled automatically once ollama.service has started
    loadModels = [
      "qwen2.5:7b"
      "qwen2.5-coder:7b"
    ];

    syncModels = true;
  };
}
