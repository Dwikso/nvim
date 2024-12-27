return {
  "2nthony/vitesse.nvim",
  dependencies = {
    "tjdevries/colorbuddy.nvim"
  },
  priority = 1000,
  config = function()
    local vitesse = require("vitesse")
    vitesse.setup({})

    vim.cmd("colorscheme vitesse")
  end
}
