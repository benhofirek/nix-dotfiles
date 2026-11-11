return {
  'neovim/nvim-lspconfig',

  dependencies = {
    'hrsh7th/cmp-nvim-lsp',
    {
      'j-hui/fidget.nvim',
      opts = {
        progress = {
          display = { done_icon = '✓' },
          ignore = {
            function(msg)
              return msg.lsp_client.name == 'pylsp'
                and msg.title
                and msg.title:find('lint:', 1, true) ~= nil
            end,
          },
        },
        notification = {
          filter = vim.log.levels.WARN,
          window = { winblend = 0 },
        },
      },
    },
  },

  config = function()
    local capabilities = require('cmp_nvim_lsp').default_capabilities()

    ---------------------------------------------------------------------------
    -- Shared configuration
    ---------------------------------------------------------------------------

    vim.lsp.config('*', {
      capabilities = capabilities,
    })

    vim.diagnostic.config({
      virtual_text = {
        spacing = 4,
        severity = vim.diagnostic.severity.WARN,
      },
      update_in_insert = false,
      signs = {
        severity = vim.diagnostic.severity.WARN,
      },
    })

    ---------------------------------------------------------------------------
    -- Language servers
    ---------------------------------------------------------------------------

    vim.lsp.config('html', {
      filetypes = { 'html', 'twig', 'hbs' },
    })

    vim.lsp.config('emmet_language_server', {})

    -- Go
    vim.lsp.config('gopls', {})
    vim.lsp.config('templ', {})

    -- PHP
    vim.lsp.config('phpactor', {})

    -- Lua
    vim.lsp.config('lua_ls', {
      settings = {
        Lua = {
          runtime = {
            version = 'LuaJIT',
          },
          workspace = {
            checkThirdParty = false,
            library = vim.list_extend(
              { '${3rd}/luv/library' },
              vim.api.nvim_get_runtime_file('', true)
            ),
          },
          completion = {
            callSnippet = 'Replace',
          },
          telemetry = {
            enable = false,
          },
          diagnostics = {
            disable = { 'missing-fields' },
          },
        },
      },
    })

    -- Docker
    vim.lsp.config('dockerls', {})
    vim.lsp.config('docker_compose_language_service', {})

    -- Python
    vim.lsp.config('pylsp', {
      settings = {
        pylsp = {
          plugins = {
            rope_autoimport = { enabled = true },
            pylsp_mypy = { enabled = true },
            pyflakes = { enabled = false },
            pycodestyle = { enabled = false },
            autopep8 = { enabled = false },
            yapf = { enabled = false },
            mccabe = { enabled = false },
            pylsp_black = { enabled = false },
            pylsp_isort = { enabled = false },
          },
        },
      },
    })

    vim.lsp.config('ruff', {
      init_options = {
        settings = {
          -- Ruff's defaults are sufficient; customize if needed.
        },
      },
    })

    -- Rust
    vim.lsp.config('rust_analyzer', {
      settings = {
        ['rust-analyzer'] = {
          cargo = {
            features = 'all',
          },
          check = {
            command = 'clippy',
          },
        },
      },
    })

    -- Terraform
    vim.lsp.config('terraformls', {})

    -- Web / data
    vim.lsp.config('tailwindcss', {})
    vim.lsp.config('jsonls', {})
    vim.lsp.config('sqlls', {})
    vim.lsp.config('yamlls', {})
    vim.lsp.config('bashls', {})
    vim.lsp.config('graphql', {})

    -- TypeScript / Vue
    local vue_language_server_path =
      vim.fn.exepath('vue-language-server')

    -- Nix must expose the Vue plugin's actual package directory.
    -- Override this with the correct Nix store path if needed.
    vim.lsp.config('vtsls', {
      filetypes = {
        'javascript',
        'javascriptreact',
        'typescript',
        'typescriptreact',
        'vue',
      },
    })

    vim.lsp.config('vue_ls', {})

    -- Nix
    vim.lsp.config('nixd', {
      cmd = { 'nixd' },
      settings = {
        nixd = {
          nixpkgs = {
            expr = 'import <nixpkgs> { }',
          },
          formatting = {
            command = { 'nixfmt' },
          },
          options = {
            nixos = {
              expr = '(builtins.getFlake "github:benhofirek/nix-dotfiles").nixosConfigurations.laptop.options',
            },
            home_manager = {
              expr = '(builtins.getFlake "github:benhofirek/nix-dotfiles").nixosConfigurations.laptop.options',
            },
          },
        },
      },
    })

    ---------------------------------------------------------------------------
    -- Custom commands
    ---------------------------------------------------------------------------

    vim.api.nvim_create_user_command('RuffAutofix', function()
      vim.lsp.buf.execute_command({
        command = 'ruff.applyAutofix',
        arguments = {
          { uri = vim.uri_from_bufnr(0) },
        },
      })
    end, {
      desc = 'Ruff: Fix all auto-fixable problems',
    })

    vim.api.nvim_create_user_command('RuffOrganizeImports', function()
      vim.lsp.buf.execute_command({
        command = 'ruff.applyOrganizeImports',
        arguments = {
          { uri = vim.uri_from_bufnr(0) },
        },
      })
    end, {
      desc = 'Ruff: Organize imports',
    })

    ---------------------------------------------------------------------------
    -- Enable servers
    ---------------------------------------------------------------------------

    vim.lsp.enable({
      'html',
      'emmet_language_server',
      'gopls',
      'templ',
      'phpactor',
      'lua_ls',
      'dockerls',
      'docker_compose_language_service',
      'pylsp',
      'ruff',
      'rust_analyzer',
      'terraformls',
      'tailwindcss',
      'jsonls',
      'sqlls',
      'yamlls',
      'bashls',
      'graphql',
      'vtsls',
      'vue_ls',
      'nixd',
      'helm_ls',
    })
  end,
}
