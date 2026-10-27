local keys = {}
-- INFO:
-- Plugin specific keymaps are under their respective file in plugins/*

function keys.init()
  -- No arrow key allowed
  -- Remove macro key since I don't use it
  vim.keymap.set("n", "q", "<nop>", { silent = true })
  -- Clear search with <esc>
  vim.keymap.set({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Escape and clear hlsearch", silent = true })
  -- Save
  vim.keymap.set("n", "<C-S>", "<CMD>w<CR>", { silent = true, desc = "Save file" })
  -- Window cursor movement
  vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Go to left window", silent = true })
  vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Go to lower window", silent = true })
  vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Go to upper window", silent = true })
  vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Go to right window", silent = true })
  -- Resize window
  vim.keymap.set("n", "<S-Up>", "<CMD>resize +2<CR>", { desc = "Increase window height", silent = true })
  vim.keymap.set("n", "<S-Down>", "<CMD>resize -2<CR>", { desc = "Decrease window height", silent = true })
  vim.keymap.set("n", "<S-Left>", "<CMD>vertical resize -2<CR>", { desc = "Decrease window width", silent = true })
  vim.keymap.set("n", "<S-Right>", "<CMD>vertical resize +2<CR>", { desc = "Increase window width", silent = true })
  -- Others
  vim.keymap.set("n", "<leader>wd", "<C-W>c", { desc = "Delete window", silent = true })
  vim.keymap.set("n", "<leader>wy", "<C-W>s", { desc = "Split window below", silent = true })
  vim.keymap.set("n", "<leader>wx", "<C-W>v", { desc = "Split window right", silent = true })
  -- Tab
  vim.keymap.set("n", "<leader>tt", "<CMD>tabnew<CR>", { desc = "New Tab", silent = true })
  vim.keymap.set("n", "<leader>td", "<CMD>tabclose<CR>", { desc = "Close Tab", silent = true })
  vim.keymap.set("n", "<leader>tn", "<CMD>tabnext<CR>", { desc = "Next tab", silent = true })
  vim.keymap.set("n", "<leader>tp", "<CMD>tabprev<CR>", { desc = "Prev tab", silent = true })

  vim.keymap.set("n", "<S-h>", "<cmd>bprev<cr>", { desc = "Prev buffer", silent = true })
  vim.keymap.set("n", "<S-l>", "<cmd>bnext<cr>", { desc = "Next buffer", silent = true })
  --
  -- Move lines
  vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move line up", silent = true })
  vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move line down", silent = true })

  -- Lsp related keymaps
  vim.keymap.set("n", "ge", vim.diagnostic.open_float, { desc = "Open diagnostic popup" })
  vim.keymap.set("n", "[d",
    function()
      vim.diagnostic.jump({ count = -1, float = true })
    end,
    { desc = "Go to previous diagnostic" }
  )
  vim.keymap.set("n", "]d",
    function()
      vim.diagnostic.jump({ count = 1, float = true })
    end,
    { desc = "Go to next diagnostic" }
  )
  vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { desc = "Go to declaration" })
  vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })
  vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Hover" })
  vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { desc = "Go to implementation" })
  vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename" })
  vim.keymap.set("n", "<leader>wl",
    function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, { desc = "List workspace folders" }
  )
  vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, { desc = "Go to type definition" })
  vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { desc = "Code action" })
  vim.keymap.set("n", "gr", vim.lsp.buf.references, { desc = "Check references" })

  -- Plugins stuff
  vim.keymap.set("n", "<leader>e", "<cmd>Neotree toggle reveal position=float<cr>", { desc = "Toggle explorer" })
  vim.keymap.set("n", "<leader>gg", "<cmd>LazyGit<cr>", { desc = "Open LazyGit" })
  vim.keymap.set("n", "<leader>i", "<cmd>Sleuth<cr>", { desc = "Fix indentiation" })

  -- File picker
  local pick = require("mini.pick")

  vim.keymap.set("n", "<leader>ff",
    function()
      return pick.builtin.files({})
    end,
    { desc = "Pick file" }
  )
  vim.keymap.set("n", "<leader>fb",
    function()
      pick.builtin.buffers({})
    end,
    { desc = "Pick buffer" }
  )
  vim.keymap.set("n", "<leader>fg",
    function()
      pick.builtin.grep_live({})
    end,
    { desc = "Pick live grep" }
  )

  -- Terminal
  vim.keymap.set("n", "<leader>t", require('FTerm').toggle, { desc = "Open terminal" })

  -- Flash (jump)
  vim.keymap.set({ "n", "x", "o" }, "gs", function() require("flash").jump() end, { desc = "Flash jump" })
  vim.keymap.set({ "n", "x", "o" }, "gS", function() require("flash").treesitter() end, { desc = "Flash treesitter select" })

  -- Trouble / Todo
  vim.keymap.set("n", "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", { desc = "Diagnostics (project)" })
  vim.keymap.set("n", "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", { desc = "Diagnostics (buffer)" })
  vim.keymap.set("n", "<leader>xs", "<cmd>Trouble symbols toggle focus=false<cr>", { desc = "Symbols" })
  vim.keymap.set("n", "<leader>xr", "<cmd>Trouble lsp toggle focus=false win.position=right<cr>", { desc = "LSP references/definitions" })
  vim.keymap.set("n", "<leader>xt", "<cmd>Trouble todo toggle<cr>", { desc = "Todo list" })
  vim.keymap.set("n", "]t", function() require("todo-comments").jump_next() end, { desc = "Next todo comment" })
  vim.keymap.set("n", "[t", function() require("todo-comments").jump_prev() end, { desc = "Previous todo comment" })

  -- Git (diffview)
  vim.keymap.set("n", "<leader>gd", "<cmd>DiffviewOpen<cr>", { desc = "Diffview open" })
  vim.keymap.set("n", "<leader>gh", "<cmd>DiffviewFileHistory %<cr>", { desc = "File history" })
  vim.keymap.set("n", "<leader>gq", "<cmd>DiffviewClose<cr>", { desc = "Diffview close" })

  -- Oil
  vim.keymap.set("n", "-", "<cmd>Oil<cr>", { desc = "Open parent directory (Oil)" })

  -- Search and replace
  vim.keymap.set("n", "<leader>sr", function() require("grug-far").open() end, { desc = "Search and replace" })

  -- Harpoon
  local harpoon = require("harpoon")
  vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end, { desc = "Harpoon add file" })
  vim.keymap.set("n", "<leader>h", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, { desc = "Harpoon menu" })
  for i = 1, 4 do
    vim.keymap.set("n", "<leader>" .. i, function() harpoon:list():select(i) end, { desc = "Harpoon file " .. i })
  end

  -- Debugger
  local dap = require("dap")
  vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "Toggle breakpoint" })
  vim.keymap.set("n", "<leader>dc", dap.continue, { desc = "Start / continue" })
  vim.keymap.set("n", "<leader>do", dap.step_over, { desc = "Step over" })
  vim.keymap.set("n", "<leader>di", dap.step_into, { desc = "Step into" })
  vim.keymap.set("n", "<leader>dO", dap.step_out, { desc = "Step out" })
  vim.keymap.set("n", "<leader>dq", dap.terminate, { desc = "Stop debugging" })
  vim.keymap.set("n", "<leader>du", function() require("dapui").toggle() end, { desc = "Toggle debugger UI" })
end

return keys
