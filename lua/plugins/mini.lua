-- ~/.config/nvim/lua/plugins/mini.lua

return {
  "echasnovski/mini.nvim",
  version = false, -- Optionally pin to a specific version or commit
  config = function()
    -- You MUST setup the modules you want to use.
    -- Add setup calls for other mini modules here if/when you use them.

    -- Setup mini.icons
    require("mini.icons").setup()
    -- You can add options inside setup {} if needed later,
    -- but the default is often fine to start. Refer to :h mini.icons
  end,
}
