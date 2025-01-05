return {
    "leath-dub/snipe.nvim",
    lazy = false,
    keys = {
        {
            "<A-s>",
            function()
                require("snipe").open_buffer_menu()
            end,
            desc = "Open Snipe buffer menu",
        },
    },
    opts = {
        ui = {
            position = "center",
            open_win_override = {
                border = "rounded",
            },
            preselect_current = true,
            text_align = "file-first",
        },
    },
}
