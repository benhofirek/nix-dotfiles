{
  programs.atuin = {
    enable = true;
    enableZshIntegration = true;

    settings = {
      # Use fuzzy search mode out of the box (feels more like fzf)
      search_mode = "fuzzy";

      # Filter history by the current directory by default,
      # but let you easily toggle to global with Ctrl-R
      filter_mode = "global";

      # Automatically sync history in the background
      auto_sync = false;
      update_check = false;

      # Show inline results or full screen? "auto" is great
      inline_height = 20;

      # Record exit codes so you can search for commands that succeeded/failed
      store_exec_path = true;

      style = "compact";

      show_help = false;

      # Invert UI so the search prompt sits at the top (like fzf)
      invert = false;

      # Show a multi-line preview box for long/wrapped commands
      show_preview = true;

      # Direct execution mode:
      # true  -> Enter executes command directly
      # false -> Enter puts command on prompt to edit before running
      enter_accept = true;

      # tmux = {
      #   # Enable rendering Atuin in a tmux popup
      #   enabled = true;
      #
      #   width = "80%";
      #   height = "80%";
      # };
    };

  };
}
