vim.g.barbar_auto_setup = false -- disable auto-setup

require'barbar'.setup({

    -- Enable/disable animations
    animation = true,

    -- Enable/disable current/total tabpages indicator (top right corner)
    tabpages = true,

    -- Enables/disable clickable tabs
    --  - left-click: go to buffer
    --  - middle-click: delete buffer
    clickable = true,

    icons = {
        filetype = {
            enabled = true
        }
    }

})
