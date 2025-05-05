return {
  "nvim-tree/nvim-web-devicons",
  config = function()
    require("nvim-web-devicons").setup({
      -- Using default settings is generally fine
      default = true,
      -- You can add specific overrides here if needed later
      -- override = {},
    })
  end,
}
