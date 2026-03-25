local lsp = {}

function lsp.init()
  local servers = {
    "astro",
    "clangd",
    "cssls",
    "docker_compose_language_service",
    "dockerls",
    -- "eslint",
    "html",
    "jsonls",
    "lua_ls",
    "pyright",
    "svelte",
    "yamlls",
    "vtsls",
  }

  require("mason").setup()
  require("mason-lspconfig").setup({
    automatic_enable = false,
    ensure_installed = {
      "astro",
      "clangd",
      "cssls",
      "docker_compose_language_service",
      "dockerls",
      "html",
      "jsonls",
      "lua_ls",
      "pyright",
      "svelte",
      "yamlls",
      "vtsls",
    },
  })
 
require("blink.cmp").setup({
    keymap = {
      ['<CR>'] = { "accept", "fallback" },
      ['<S-Tab>'] = { 'select_prev', 'fallback' },
      ['<Tab>'] = { 'select_next', 'fallback' },
    },
    completion = {
      documentation = {
        auto_show = true,
        auto_show_delay_ms = 500,
      }
    },
    sources = {
      default = { 'lsp' }
    }
  })

  vim.diagnostic.config({
    float = {
      source = true,
      border = 'rounded'
    }
  })

  -- Config override
  local mason_path = vim.fn.expand("$HOME/.local/share/nvim/mason/packages")
  local vue_plugin_path = mason_path .. "/vue-language-server/node_modules/@vue/typescript-plugin"

  require("lspconfig").vtsls.setup({
    on_attach = function(client, _)
      client.server_capabilities.documentFormattingProvider = false
    end,
    filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact", "vue" },
    settings = {
      vtsls = {
        tsserver = {
          globalPlugins = {
            {
              name = "@vue/typescript-plugin",
              location = vue_plugin_path,
              languages = { "vue" },
              configNamespace = "typescript",
              enableForWorkspaceTypeScriptVersions = true,
            },
          },
        },
      },
      typescript = {
        tsdk = mason_path .. "/vtsls/node_modules/@vtsls/language-server/node_modules/typescript/lib",
      },
    },
  })

  -- Enable everything except vtsls (already handled above)
  local enabled_servers = {}
  for _, server in ipairs(servers) do
    if server ~= "vtsls" and server ~= "volar" then
      table.insert(enabled_servers, server)
    end
  end
  vim.lsp.enable(enabled_servers)
end

return lsp
