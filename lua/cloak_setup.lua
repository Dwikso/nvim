local ok, cloak = pcall(require, "cloak")

if ok then
    cloak.setup({
        enabled = true,
        cloak_character = "*",
        patterns = { { file_pattern = ".env*", cloak_pattern = "=.+" } },
    })
end
