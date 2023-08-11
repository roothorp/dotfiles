local function open_nvim_tree()
    require("nvim-tree.api").tree.open()
end

require("nvim-tree").setup({
    view = {
        width = 50,
    },
    renderer = {
        group_empty = true,
    }
})

vim.api.nvim_create_autocmd({ "VimEnter" }, { callback = open_nvim_tree })
