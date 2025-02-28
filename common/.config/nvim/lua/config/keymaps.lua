-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local set = vim.keymap.set

set("n", "J", "mzJ`z")
set("n", "<C-d>", "<C-d>zz")
set("n", "<C-u>", "<C-u>zz")
set("n", "<C-o>", "<C-o>zz")
set("n", "<C-i>", "<C-i>zz")
set("n", "j", "gjzz")
set("n", "k", "gkzz")
set("n", "<CR>", "<CR>zz")
set("n", "-", "-zz")
set("n", "G", "Gzz")
set("n", "%", "%zz")
set("n", "n", "nzzzv")
set("n", "N", "Nzzzv")

set("i", "<C-c>", "<Esc>")

set("n", "Q", "<nop>")
set("n", "<leader>rw", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gIc<Left><Left><Left><Left>]], { desc = "Replace word" })
set("n", "<leader>m", "<cmd>!chmod +x %<CR>", { silent = true, desc = "Make executable" })
set("n", "<leader>[", "A {<CR><CR>}<Esc>kcc", { desc = "Create squirly braces" })
set("n", "<leader>;", "A:<Esc>o", { desc = "Add colon + new line" })
set(
    "n",
    "<leader>i",
    [[i<!DOCTYPE html><CR><html lang="en"><CR><head><CR><meta charset="UTF-8"><CR><meta http-equiv="X-UA-Compatible" content="IE=edge"><CR><meta name="viewport" content="width=device-width, initial-scale=1"><CR><title>Document</title><CR></head><CR><body><CR><CR></body><CR></html><Esc>kkcc]],
    { desc = "HTML boilerplate" }
)
set("n", "<C-s>", "<nop>")
set({ "n", "v" }, "<leader>y", '"+y', { silent = true, noremap = true })
set({ "n", "v" }, "<leader>Y", '"+Y', { silent = true, noremap = true })
set({ "n", "v" }, "<leader>p", '"+p', { silent = true, noremap = true })
set("n", "<leader><leader>", function()
    local handle = io.popen("git rev-parse --is-inside-work-tree 2>/dev/null")
    local result = handle:read("*a")
    handle:close()
    if result:match("true") then
        Snacks.picker.git_files()
    else
        Snacks.picker.files({ hidden = true })
    end
end)
