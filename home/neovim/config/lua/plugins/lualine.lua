local my_lualine_theme = {
  normal = {
    a = { gui = 'bold', bg = 'none' },
    b = { gui = 'bold', bg = 'none' },
    c = { gui = 'bold', bg = 'none' },
  },
  insert = {
    a = { gui = 'bold', bg = 'none' },
    b = { gui = 'bold', bg = 'none' },
    c = { gui = 'bold', bg = 'none' },
  },
  visual = {
    a = { gui = 'bold', bg = 'none' },
    b = { gui = 'bold', bg = 'none' },
    c = { gui = 'bold', bg = 'none' },
  },
  command = {
    a = { gui = 'bold', bg = 'none' },
    b = { gui = 'bold', bg = 'none' },
    c = { gui = 'bold', bg = 'none' },
  },
  replace = {
    a = { gui = 'bold', bg = 'none' },
    b = { gui = 'bold', bg = 'none' },
    c = { gui = 'bold', bg = 'none' },
  },
}

function getconda()
  if vim.bo.filetype ~= 'python' then
    return ''
  end
  if os.getenv 'CONDA_DEFAULT_ENV' == nil then
    return 'System'
  end
  return os.getenv 'CONDA_DEFAULT_ENV'
end

return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  opts = {
    options = {
      icons_enabled = true,
      theme = 'ayu',
      component_separators = '|',
      section_separators = '',
      disabled_filetypes = {},
      always_divide_middle = true,
      globalstatus = true,
    },
    sections = {
      lualine_a = { 'mode' },
      lualine_b = { 'branch', 'diagnostics' },
      lualine_c = {
        { 'filename', file_status = false, path = 1 },
      },
      lualine_x = {
        {
          'diff',
          symbols = { added = ' ', modified = ' ', removed = ' ' },
          diff_color = {
            added = { fg = black },
            modified = { fg = black },
            removed = { fg = black },
          },
        },
      },
      lualine_y = { 
        'filetype', { getconda },
      },
      lualine_z = { '%l:%c', '%p%%/%L' },
    },
    inactive_sections = {
      lualine_a = {},
      lualine_b = {},
      lualine_c = {},
      lualine_x = { 'location' },
      lualine_y = {},
      lualine_z = {},
    },
    tabline = {},
  },
}
