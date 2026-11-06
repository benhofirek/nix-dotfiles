{
  programs.pi-coding-agent = {
    enable = true;
  };

  home.file.".pi/agent/settings.json".text = builtins.toJSON {
    "$schema" = "https://pi.dev/schemas/settings.schema.json";
    defaultProvider = "deepseek";
    defaultModel = "deepseek-flash";

    packages = [
      "npm:pi-web-access@0.46.0"
      "npm:pi-subagents@0.84.0"
      "npm:pi-lens@4.4.5"
      "npm:pi-simplify@0.2.3"
      "npm:pi-memory@0.4.2"
      "npm:pi-powerline-footer@0.20.2"
      "npm:billion-context@0.1.211"
    ];
  };

  home.file.".pi/agent/keybindings.json".text = builtins.toJSON {
    "$schema" = "https://pi.dev/schemas/keybindings.schema.json";

    "tui.editor.cursorUp" = [ "up" "ctrl+p" ];
    "tui.editor.cursorDown" = [ "down" "ctrl+n" ];
    "tui.editor.cursorLeft" = [ "left" "ctrl+b" ];
    "tui.editor.cursorRight" = [ "right" "ctrl+f" ];

    "tui.select.up" = [ "up" "ctrl+p" ];
    "tui.select.down" = [ "down" "ctrl+n" ];
  };

  home.file.".pi/agent/models.json".text = builtins.toJSON {
    providers = {
      deepseek = {
        baseUrl = "https://api.deepseek.com/v1";
        api = "openai-completions";
        models = [
          { id = "deepseek-v4.1-flash"; }
        ];
      };
      ollama = {
        baseUrl = "http://localhost:11434/v1";
        api = "openai-completions";
        apiKey = "ollama";
        models = [
          { id = "qwen2.5:7b"; }
        ];
      };
    };
  };

  home.file.".pi/Dockerfile.pi".text = ''
    FROM node:24-bookworm-slim

    RUN apt-get update \
      && apt-get install -y --no-install-recommends bash ca-certificates git ripgrep fd-find \
      && rm -rf /var/lib/apt/lists/*
    RUN npm install -g --ignore-scripts @earendil-works/pi-coding-agent

    WORKDIR /workspace
    ENTRYPOINT ["pi"]
  '';
}
