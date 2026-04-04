local jdtls = require('jdtls')
local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
local workspace_dir = vim.fn.expand('~/.cache/jdtls/workspace/') .. project_name

-- Ensure workspace directory exists
vim.fn.mkdir(workspace_dir, 'p')

local mason_path = vim.fn.expand('~/.local/share/nvim/mason/packages/jdtls')
local launcher_jar = vim.fn.glob(mason_path .. '/plugins/org.eclipse.equinox.launcher_*.jar')
local config_dir = mason_path .. '/config_linux'
local lombok_jar = mason_path .. '/lombok.jar'

-- Find root directory of the project
local root_dir = jdtls.setup.find_root({'.git', 'mvnw', 'gradlew', 'pom.xml', 'build.gradle'})
if root_dir == "" then
    root_dir = vim.fn.getcwd()
end

-- Capabilities for snippets and additional text edits
local capabilities = vim.lsp.protocol.make_client_capabilities()
if pcall(require, "blink.cmp") then
  capabilities = require("blink.cmp").get_lsp_capabilities(capabilities)
end

-- Required for snippets and smart completions
local extendedClientCapabilities = jdtls.extendedClientCapabilities
extendedClientCapabilities.resolveAdditionalTextEditsSupport = true

local config = {
  cmd = {
    'java',
    '-Declipse.application=org.eclipse.jdt.ls.core.id1',
    '-Dosgi.bundles.defaultStartLevel=4',
    '-Declipse.product=org.eclipse.jdt.ls.core.product',
    '-Dlog.protocol=true',
    '-Dlog.level=ERROR', -- Réduit le niveau de log
    '-Xmx1g',
    '--add-modules=ALL-SYSTEM',
    '--add-opens', 'java.base/java.util=ALL-UNNAMED',
    '--add-opens', 'java.base/java.lang=ALL-UNNAMED',
    '-javaagent:' .. lombok_jar,
    '-jar', launcher_jar,
    '-configuration', config_dir,
    '-data', workspace_dir,
  },
  root_dir = root_dir,
  capabilities = capabilities,
  init_options = {
    extendedClientCapabilities = extendedClientCapabilities,
  },
  settings = {
    java = {
      signatureHelp = { enabled = true },
      contentProvider = { preferred = 'fernflower' },
      completion = {
        favoriteStaticMembers = {
          "org.hamcrest.MatcherAssert.assertThat",
          "org.hamcrest.Matchers.*",
          "org.hamcrest.CoreMatchers.*",
          "org.junit.jupiter.api.Assertions.*",
          "java.util.Objects.requireNonNull",
          "java.util.Objects.requireNonNullElse",
          "org.mockito.Mockito.*",
        },
        importOrder = {
          "java",
          "javax",
          "com",
          "org"
        },
      },
      sources = {
        organizeImports = {
          starThreshold = 9999,
          staticStarThreshold = 9999,
        },
      },
      codeGeneration = {
        toString = {
          template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}",
        },
        useBlocks = true,
      },
    },
  },
}

-- Start jdtls
jdtls.start_or_attach(config)

-- Indentation settings
vim.bo.shiftwidth = 4
vim.bo.tabstop = 4
vim.bo.softtabstop = 4
vim.bo.expandtab = true

-- Keymaps for better experience
vim.keymap.set('n', '<leader>jo', jdtls.organize_imports, { desc = 'Organize Imports', buffer = true })
vim.keymap.set('n', '<leader>jv', jdtls.extract_variable, { desc = 'Extract Variable', buffer = true })
vim.keymap.set('n', '<leader>jc', jdtls.extract_constant, { desc = 'Extract Constant', buffer = true })
