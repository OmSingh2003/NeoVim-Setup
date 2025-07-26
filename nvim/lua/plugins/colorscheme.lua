return {
  -- Configure LazyVim colorscheme with transparency
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin-mocha", -- Match your Ghostty theme
    },
  },
  
  -- Add catppuccin colorscheme with transparency support
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    opts = {
      flavour = "mocha", -- latte, frappe, macchiato, mocha
      transparent_background = true, -- Enable transparency
      show_end_of_buffer = false, -- Don't show ~ chars after end of buffer
      term_colors = true, -- Enable terminal colors
      integrations = {
        cmp = true,
        nvimtree = true,
        treesitter = true,
        notify = false,
        mini = {
          enabled = true,
          indentscope_color = "",
        },
      },
    },
    config = function(_, opts)
      require("catppuccin").setup(opts)
      
      -- Additional transparency settings
      vim.api.nvim_create_autocmd("ColorScheme", {
        callback = function()
          -- Make background transparent
          vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
          vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
          vim.api.nvim_set_hl(0, "NormalNC", { bg = "none" })
          
          -- Make line numbers background transparent
          vim.api.nvim_set_hl(0, "LineNr", { bg = "none" })
          vim.api.nvim_set_hl(0, "LineNrAbove", { bg = "none" })
          vim.api.nvim_set_hl(0, "LineNrBelow", { bg = "none" })
          
          -- Make sign column transparent
          vim.api.nvim_set_hl(0, "SignColumn", { bg = "none" })
          
          -- Make status line transparent (optional)
          -- vim.api.nvim_set_hl(0, "StatusLine", { bg = "none" })
          -- vim.api.nvim_set_hl(0, "StatusLineNC", { bg = "none" })
        end,
      })
    end,
  },
}
