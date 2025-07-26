return {
  -- Add LSP servers for C++ and Go
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        -- C++ Language Server
        clangd = {
          cmd = {
            "clangd",
            "--background-index",
            "--clang-tidy",
            "--header-insertion=iwyu",
            "--completion-style=detailed",
            "--function-arg-placeholders",
            "--fallback-style=llvm",
          },
          init_options = {
            usePlaceholders = true,
            completeUnimported = true,
            clangdFileStatus = true,
          },
          filetypes = { "c", "cpp", "objc", "objcpp", "cuda", "proto" },
        },
        -- Go Language Server
        gopls = {
          cmd = { "gopls" },
          filetypes = { "go", "gomod", "gowork", "gotmpl" },
          root_dir = function(fname)
            return require("lspconfig.util").root_pattern("go.work", "go.mod", ".git")(fname)
          end,
          settings = {
            gopls = {
              completeUnimported = true,
              usePlaceholders = true,
              analyses = {
                unusedparams = true,
              },
            },
          },
        },
      },
      -- Ensure servers are set up automatically
      setup = {
        clangd = function(_, opts)
          require("lspconfig").clangd.setup(opts)
        end,
        gopls = function(_, opts)
          require("lspconfig").gopls.setup(opts)
        end,
      },
    },
  },
}
