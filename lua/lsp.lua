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
      "jdtls",
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
      default = { 'lsp', 'path', 'snippets', 'buffer' }
    },
    -- Use native Neovim 0.11+ snippets
    snippets = {
      preset = 'default'
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

  -- Using the new Neovim 0.11+ / nvim-lspconfig approach
  local vtsls_config = {
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
  }

  local capabilities = vim.lsp.protocol.make_client_capabilities()
  if pcall(require, "blink.cmp") then
    capabilities = require("blink.cmp").get_lsp_capabilities(capabilities)
  end

  -- Use native vim.lsp.config if available
  if vim.lsp.config then
    vim.lsp.config("*", {
      capabilities = capabilities,
    })
    vim.lsp.config("vtsls", vtsls_config)
    vim.lsp.enable("vtsls")

    -- Enable other servers using the new API
    for _, server in ipairs(servers) do
      if server ~= "vtsls" and server ~= "volar" then
        vim.lsp.enable(server)
      end
    end
  else
    -- Fallback for older versions (unlikely for 0.12)
    local lspconfig = require("lspconfig")
    lspconfig.vtsls.setup(vtsls_config)
    for _, server in ipairs(servers) do
      if server ~= "vtsls" and server ~= "volar" then
        lspconfig[server].setup({})
      end
    end
  end
end

return lsp
