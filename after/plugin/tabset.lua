require("tabset").setup({
    defaults = {
        tabwidth = 4,
        expandtab = true
    },
    languages = {
        {
            filetypes = {"javascript", "typescript"},
            config = {
                tabwidth = 2
            }
        }
    }
})
