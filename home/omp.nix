{
  # 1. Enable oh-my-pi
  programs.omp = {
    enable = true;
    settings = {
      defaultModel = "deepseek/deepseek-v4-flash";

      startup = {
        quiet = true;
        autoUpdate = false;
      };

      agent = {
        maxRetries = 3;
        temperature = 0.2;
        contextWindowMargin = 1000; # Reserved token margin for system instructions/tools
      };

      tools = {
        autoApproveReadOnly = true;
        confirmShellCommands = true;
      };
    };
  };
}
