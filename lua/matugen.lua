local M = {}

function M.setup()
    -- On tente de charger le thème spécifique défini par le script global_themes.sh
    local theme_status, theme = pcall(require, "matugen_theme")
    
    if theme_status and theme and theme.name and theme.name ~= "" then
        vim.opt.termguicolors = true
        
        -- Tentative d'application du colorscheme (ex: gruvbox, rose-pine, horizon)
        local ok, _ = pcall(vim.cmd, "colorscheme " .. theme.name)
        if ok then 
            -- Si le thème a son propre lualine theme, on pourrait l'activer ici
            -- Mais pour l'instant on laisse lualine en "auto"
            return 
        end
        -- Si le colorscheme échoue (plugin non installé), on continue vers le fallback Matugen
    end

    -- Fallback : Thème généré manuellement à partir des couleurs Matugen
    local status, colors = pcall(require, "matugen_colors")
    if not status then
        -- Dernier recours : Gruvbox par défaut si rien d'autre ne marche
        pcall(vim.cmd, "colorscheme gruvbox")
        return
    end

    vim.opt.termguicolors = true
    vim.g.colors_name = "matugen"

    local hl = vim.api.nvim_set_hl

    -- Highlights de base (Material You fallback)
    hl(0, "Normal", { fg = colors.base05, bg = colors.base00 })
    hl(0, "CursorLine", { bg = colors.base01 })
    hl(0, "StatusLine", { fg = colors.base04, bg = colors.base02 })
    hl(0, "Comment", { fg = colors.base03, italic = true })
    hl(0, "String", { fg = colors.base0B })
    hl(0, "Function", { fg = colors.base0D })
    hl(0, "Keyword", { fg = colors.base0E })
    hl(0, "Variable", { fg = colors.base08 })
    hl(0, "Type", { fg = colors.base0A })
    hl(0, "Search", { fg = colors.base01, bg = colors.base0A })
    hl(0, "Visual", { bg = colors.base02 })
    hl(0, "LineNr", { fg = colors.base03 })
    hl(0, "CursorLineNr", { fg = colors.base0A })
    hl(0, "Delimiter", { fg = colors.base0C })
    
    -- Neo-tree integration
    hl(0, "NeoTreeNormal", { fg = colors.base05, bg = colors.base00 })
    hl(0, "NeoTreeDirectoryName", { fg = colors.base0D })
    hl(0, "NeoTreeFileName", { fg = colors.base05 })
end

return M
