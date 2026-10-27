local opts = {}

function opts.init()
  vim.opt.autoread = true -- Read a file when it was changed outside of nvim
  vim.opt.autowrite = true -- Automatically write file when it was changed
  vim.opt.encoding = "UTF-8" -- Default encoding
  vim.opt.number = true -- Number in front of each line
  vim.opt.relativenumber = false -- Relative number in front of each line
  vim.opt.mouse = "a" -- Enabled in all mode
  vim.opt.list = true -- Show space, line breaks, spaces, tabs...
  vim.opt.listchars:append("eol:↴") -- Set the sign for the EOL
  vim.opt.signcolumn = "yes"
  vim.opt.wrap = false -- Long lines are not wrapped
  vim.opt.completeopt = { "menu", "menuone", "noselect", "preview" }
  vim.opt.splitbelow = true -- Cursor go on the left window when split
  vim.opt.splitright = true -- Cursor go on the right windows when split
  vim.opt.confirm = true -- Confirm before closing an unsaved buffer
  vim.opt.cursorline = true -- Highlight current line
  vim.opt.expandtab = true -- Use spaces instead of tabs
  vim.opt.smartindent = true -- Insert indents automatically
  vim.opt.mousescroll = "ver:3,hor:0" -- Disable horizontal mouse scrolling
  vim.opt.winborder = "rounded" -- Make all popup window rounded
  vim.opt.background = "dark" -- Theme
  vim.opt.timeout = true -- Used for whichkey
  vim.opt.timeoutlen = 300 -- Used for whichkey
  vim.opt.ignorecase = true -- Case insensitive search
  vim.opt.clipboard = "unnamedplus" -- Permet d'utiliser le presse-papier système
  -- Nombre d'espaces qu'une tabulation représente
  vim.opt.tabstop = 2

  -- Nombre d'espaces utilisés pour chaque étape d'indentation
  vim.opt.shiftwidth = 2

  -- Transforme les tabulations en espaces
  vim.opt.expandtab = true

  -- Rend le comportement de la touche Tab plus intelligent
  vim.opt.softtabstop = 2
  vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
  vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
end

return opts
