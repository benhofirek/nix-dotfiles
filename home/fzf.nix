{
  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
    enableBashIntegration = true;

    # Let Ctrl+R to be handled by atuin
    historyWidget.command = "";

    defaultOptions = [
      "--height 40%"
      "--layout=reverse"
      "--border"
    ];

    # Use fd for the Ctrl+T file picker.
    fileWidget.command = "fd --type f --hidden --follow --exclude .git --exclude node_modules --exclude .direnv --exclude result";

    # Use fd for the Alt+C directory picker.
    changeDirWidget.command = "fd --type d --hidden --follow --exclude .git --exclude node_modules --exclude .direnv --exclude result";
  };
}
