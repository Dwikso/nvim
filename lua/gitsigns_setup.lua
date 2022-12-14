local ok, gitsigns = pcall(require, "gitsigns")

if not ok then
    do
        return
    end
end

gitsigns.setup({
    signs = {
        add = { hl = "GitSignsAdd", text = "", numhl = "GitSignsAddNr", linehl = "GitSignsAddLn" },
        change = { hl = "GitSignsChange", text = "ﰣ", numhl = "GitSignsChangeNr", linehl = "GitSignsChangeLn" },
        delete = { hl = "GitSignsDelete", text = "", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
        topdelete = { hl = "GitSignsDelete", text = "", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
        changedelete = { hl = "GitSignsChange", text = "ﰣ", numhl = "GitSignsChangeNr", linehl = "GitSignsChangeLn" },
    },
})
