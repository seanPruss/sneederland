return {
    "LunarVim/bigfile.nvim",
    event = "BufReadPre",
    opts = {
        filesize = 2,
    },
    {
        "APZelos/blamer.nvim",
        event = "BufReadPre",
    },
    {
        "mbbill/undotree",
        keys = {
            { "<leader>ct", "<cmd>UndotreeToggle<CR>", desc = "UndoTree" },
        },
    },
    {
        "theprimeagen/vim-be-good",
        keys = {
            { "<leader>v", "<cmd>VimBeGood<CR>", desc = "Launch VimBeGood" },
        },
    },
}
