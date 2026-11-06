vim.cmd([[autocmd ColorScheme * hi DiagnosticUnderlineError guifg=red]])
vim.cmd([[autocmd ColorScheme * hi DiagnosticUnderlineWarn NONE]])
vim.cmd([[autocmd ColorScheme * hi DiagnosticUnderlineInfo NONE]])
vim.cmd([[autocmd ColorScheme * hi DiagnosticUnderlineHint NONE]])

vim.cmd([[autocmd ColorScheme * hi FocusedSymbol term=bold ctermfg=green ctermbg=NONE gui=bold guifg=green guibg=NONE]])

-- marks line number
vim.cmd([[autocmd ColorScheme * hi MarkSignNumHL guifg=blue]])
