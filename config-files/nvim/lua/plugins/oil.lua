return {
    "stevearc/oil.nvim",
    opts = {},
    lazy = false,
    -- Optional dependencies
    dependencies = { "nvim-tree/nvim-web-devicons" },
    keys = {
        {
            "<leader>e",
            function()
                require("oil").toggle_float()
            end,
            desc = "Oil",
        },
    },
    config = function()
        require("oil").setup({
            default_file_explorer = true,
        })
    end,
}
