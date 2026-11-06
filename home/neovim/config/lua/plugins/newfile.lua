return {
  "adibhanna/nvim-newfile.nvim",
  dependencies = {
    "MunifTanjim/nui.nvim"
  },
  config = function()
    require("nvim-newfile").setup({
      -- Optional configuration
    })
  end,
}
