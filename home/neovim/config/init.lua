vim.loader.enable()
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

require 'core.options'
require 'core.keymaps'
-- require 'core.keymaps-steno'
require 'core.colors'
require 'core.steno'

vim.filetype.add({
    extension = {
        steno = "steno",
    },
})

-- setup Lazy with plugins

local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system {
        'git',
        'clone',
        '--filter=blob:none',
        'https://github.com/folke/lazy.nvim.git',
        '--branch=stable',
        lazypath,
    }
end
vim.opt.rtp:prepend(vim.env.LAZY or lazypath)

require('lazy').setup("plugins")
