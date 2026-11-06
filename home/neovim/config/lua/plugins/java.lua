-- TODO: setup complete java IDE with ui for implementations etc and new file creation with namespaces
return {
  'nvim-java/nvim-java',
  dependencies = {
    {
      'neovim/nvim-lspconfig',
      opts = {
        servers = {
          jdtls = {
            settings = {
              java = {
                configuration = {
                  runtimes = {
                    {
                      name = 'JavaSE-21',
                      path = os.getenv 'HOME' .. '/.sdkman/candidates/java/21.0.2-open',
                    },
                    {
                      name = 'JavaSE-23',
                      path = os.getenv 'HOME' .. '/.sdkman/candidates/java/23.0.1-open',
                    },
                    {
                      name = 'JavaSE-25',
                      path = os.getenv 'HOME' .. '/.sdkman/candidates/java/25-open',
                    },
                  },
                },
                inlayHints = {
                  parameterNames = {
                    enabled = 'all',
                    exclusions = { 'this' },
                  },
                },
              },
            },
          },
        },
        setup = {
          jdtls = function()
            require('java').setup {
              jdk = {
                auto_install = false,
              },
              root_markers = {
                'settings.gradle',
                'settings.gradle.kts',
                'pom.xml',
                'build.gradle',
                'mvnw',
                'gradlew',
                'build.gradle',
                'build.gradle.kts',
              },
            }
          end,
        },
      },
    },
  },
}
