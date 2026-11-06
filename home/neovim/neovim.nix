{ config, ... }:

{
  programs.neovim = {
    enable = true;
    sideloadInitLua = true;
  };

  xdg.configFile.nvim.source = config.lib.file.mkOutOfStoreSymlink ./config;
}
