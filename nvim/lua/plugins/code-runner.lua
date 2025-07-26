return {
  {
    "CRAG666/code_runner.nvim",
    config = function()
      -- Check if we're in tmux and if pane 1 exists
      local function is_tmux_available()
        local tmux_env = vim.env.TMUX
        if not tmux_env then
          return false
        end
        -- Check if pane 1 exists
        local handle = io.popen("tmux list-panes -F '#{pane_index}' 2>/dev/null | grep -q '^1$' && echo 'yes' || echo 'no'")
        local result = handle:read("*a"):gsub("%s+", "")
        handle:close()
        return result == "yes"
      end

      -- Custom run function for tmux
      local function run_in_tmux()
        local file_path = vim.fn.expand("%:p")
        local file_name = vim.fn.expand("%:t")
        local file_dir = vim.fn.expand("%:p:h")
        local file_name_without_ext = vim.fn.expand("%:t:r")
        local file_ext = vim.fn.expand("%:e")
        
        local commands = {
          go = string.format("tmux send-keys -t 1 'cd %s && go run %s' Enter", file_dir, file_name),
          cpp = string.format("tmux send-keys -t 1 'cd %s && g++ -std=c++17 -I/opt/homebrew/Cellar/gcc/15.1.0/include/c++/15 %s -o %s && ./%s' Enter", file_dir, file_name, file_name_without_ext, file_name_without_ext),
          c = string.format("tmux send-keys -t 1 'cd %s && gcc %s -o %s && ./%s' Enter", file_dir, file_name, file_name_without_ext, file_name_without_ext),
          python = string.format("tmux send-keys -t 1 'cd %s && python3 -u %s' Enter", file_dir, file_name),
          py = string.format("tmux send-keys -t 1 'cd %s && python3 -u %s' Enter", file_dir, file_name),
          javascript = string.format("tmux send-keys -t 1 'cd %s && node %s' Enter", file_dir, file_name),
          js = string.format("tmux send-keys -t 1 'cd %s && node %s' Enter", file_dir, file_name),
          java = string.format("tmux send-keys -t 1 'cd %s && javac %s && java %s' Enter", file_dir, file_name, file_name_without_ext),
          rust = string.format("tmux send-keys -t 1 'cd %s && rustc %s && ./%s' Enter", file_dir, file_name, file_name_without_ext),
          rs = string.format("tmux send-keys -t 1 'cd %s && rustc %s && ./%s' Enter", file_dir, file_name, file_name_without_ext),
        }
        
        local cmd = commands[file_ext]
        if cmd then
          vim.fn.system(cmd)
        else
          print("Unsupported file type: " .. file_ext)
        end
      end

      local use_tmux = is_tmux_available()
      
      if not use_tmux then
        -- Only setup code_runner for non-tmux environments
        require("code_runner").setup({
          filetype = {
            go = {
              "cd $dir &&",
              "go run $fileName"
            },
            cpp = {
              "cd $dir &&",
              "g++ -std=c++17 -I/opt/homebrew/Cellar/gcc/15.1.0/include/c++/15 $fileName -o $fileNameWithoutExt &&",
              "./$fileNameWithoutExt"
            },
            c = {
              "cd $dir &&",
              "gcc $fileName -o $fileNameWithoutExt &&",
              "./$fileNameWithoutExt"
            },
            python = "python3 -u",
            javascript = "node",
            java = {
              "cd $dir &&",
              "javac $fileName &&",
              "java $fileNameWithoutExt"
            },
            rust = {
              "cd $dir &&",
              "rustc $fileName &&",
              "./$fileNameWithoutExt"
            },
          },
          mode = "term",
          focus = true,
          startinsert = false,
          term = {
            position = "bot",
            size = 12,
          },
        })
      end
      
      -- Create custom command and keybinding
      vim.api.nvim_create_user_command('SmartRunCode', function()
        if use_tmux then
          run_in_tmux()
        else
          vim.cmd('RunCode')
        end
      end, {})
    end,
    keys = {
      {
        "<S-r>",
        ":SmartRunCode<CR>",
        desc = "Run Code",
        mode = "n",
      },
      {
        "<leader>rf",
        ":RunFile<CR>",
        desc = "Run File",
        mode = "n",
      },
      {
        "<leader>rp",
        ":RunProject<CR>",
        desc = "Run Project",
        mode = "n",
      },
      {
        "<leader>rc",
        ":RunClose<CR>",
        desc = "Close Runner",
        mode = "n",
      },
    },
  },
}
