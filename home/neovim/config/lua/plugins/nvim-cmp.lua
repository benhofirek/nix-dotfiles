return { 
    'hrsh7th/nvim-cmp',
    config = function()
        local cmp = require("cmp")
        local luasnip = require("luasnip")

        cmp.setup({
            snippet = {
                -- REQUIRED - you must specify a snippet engine
                expand = function(args)
                    -- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
                    require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
                    -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
                    -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
                end,
            },
            window = {
                completion = cmp.config.window.bordered(),
                documentation = cmp.config.window.bordered(),
            },
            mapping = cmp.mapping.preset.insert({
                ['<C-b>'] = cmp.mapping.scroll_docs(-4),
                ['<C-f>'] = cmp.mapping.scroll_docs(4),
                ['<C-Space>'] = cmp.mapping.complete(),
                ['<C-e>'] = cmp.mapping.abort(),
                ['<CR>'] = cmp.mapping.confirm {
                  behavior = cmp.ConfirmBehavior.Insert,
                  select = true,
                },
                ['<Tab>'] = cmp.mapping(function(fallback)
                  if cmp.visible() then
                    cmp.select_next_item()
                  elseif luasnip.expand_or_jumpable() then
                    luasnip.expand_or_jump()
                  else
                    fallback()
                  end
                end, { 'i', 's' }),
            }),
            sources = cmp.config.sources({
                { name = 'nvim_lsp' },
                -- { name = 'nvim_lsp_signature_help' },
                -- { name = 'vsnip' }, -- For vsnip users.
                { name = 'luasnip' }, -- For luasnip users.
                -- { name = 'ultisnips' }, -- For ultisnips users.
                -- { name = 'snippy' }, -- For snippy users.
                { name = 'render-markdown' },
            }, {
                { name = 'buffer' },
                { name = 'path' }
            }),
            completion = {
                completeopt = 'menu,menuone,noinsert',
            },
            experimental = {
                ghost_text = true,
            },
        })

        cmp.event:on("confirm_done", function()
          -- local filetype = vim.fn.expand('%:e')
          --
          -- if filetype == 'cs' then
          --   local util = vim.lsp.util
          --   local params = util.make_range_params()
          --   local results = vim.lsp.buf_request_sync(0, 'textDocument/codeAction', params, 1000)
          --
          --   -- Process results from all LSP servers
          --   for client_id, response in pairs(results or {}) do
          --     local actions = response.result
          --
          --
          --     local action = actions[1]
          --     if action.title:sub(1, 5) == "using" then
          --         local save_cursor = vim.api.nvim_win_get_cursor(0)
          --         vim.api.nvim_buf_set_lines(0, 0, 0, false, {action.title})
          --         vim.api.nvim_win_set_cursor(0, {save_cursor[1] + 1, save_cursor[2]})
          --     end
          --   end
          -- end
        end)

        -- Set configuration for specific filetype.
        cmp.setup.filetype('gitcommit', {
            sources = cmp.config.sources({
                { name = 'git' }, -- You can specify the `git` source if [you were installed it](https://github.com/petertriho/cmp-git).
            }, {
                    { name = 'buffer' },
                })
        })

        -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
        cmp.setup.cmdline({ '/', '?' }, {
            mapping = cmp.mapping.preset.cmdline({

            }),
            sources = {
                { name = 'buffer' }
            }
        })

        -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
        cmp.setup.cmdline(':', {
            mapping = cmp.mapping.preset.cmdline(),
            sources = cmp.config.sources({
                { name = 'path' }
            }, {
                { name = 'cmdline' }
            }),
            completion = {
                completeopt = 'menu,menuone,noselect',
            },
        })

        -- Setup up vim-dadbod
        cmp.setup.filetype({ "sql" }, {
          sources = {
            { name = "vim-dadbod-completion" },
            { name = "buffer" },
          },
        })

    end
}
