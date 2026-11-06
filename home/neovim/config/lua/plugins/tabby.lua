return {
  'nanozuki/tabby.nvim',
  dependencies = 'nvim-tree/nvim-web-devicons',
  init = function() 
    vim.opt.sessionoptions = 'curdir,folds,globals,help,tabpages,terminal,winsize'
    -- always display tab line
    vim.o.showtabline = 2
  end,
  config = function()
function tab_name(tab) 
   return string.gsub(tab,"%[..%]","") 
end


function tab_modified(tab)
    wins = require("tabby.module.api").get_tab_wins(tab)
    for i, x in pairs(wins) do
        if vim.bo[vim.api.nvim_win_get_buf(x)].modified then
            return ""
        end
    end
    return ""
end

function lsp_diag(buf) 
    diagnostics = vim.diagnostic.get(buf)
    local count = {0, 0, 0, 0}
    
    for _, diagnostic in ipairs(diagnostics) do
        count[diagnostic.severity] = count[diagnostic.severity] + 1
    end
    if count[1] > 0 then
        return vim.bo[buf].modified and "" or ""
    elseif count[2] > 0 then 
        return vim.bo[buf].modified and "" or ""
    end
    return vim.bo[buf].modified and "" or ""
end 
    
local TabLine = { style='bold' }
local theme = {
    fill = TabLine,
    head = TabLine,
    current_tab = { style='underline' },
    inactive_tab = TabLine,
    tab = TabLine,
    win = TabLine,
    tail = TabLine,
}
require('tabby.tabline').set(function(line)
    return {
        line.tabs().foreach(function(tab)
            local hl = tab.is_current() and theme.current_tab or theme.inactive_tab
            return {
                tab.number(),
                tab_name(tab.name()),
                tab_modified(tab.id),
                line.sep(' ', hl, theme.fill),
                hl = hl,
                margin = ' ',
            }
        end),
        hl = theme.fill,
    }
end)
  end,
}
