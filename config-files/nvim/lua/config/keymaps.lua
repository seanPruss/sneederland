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
set("i", "<Up>", "<nop>")
set("n", "<Up>", "<nop>")
set("i", "<Down>", "<nop>")
set("n", "<Down>", "<nop>")
set("i", "<Right>", "<nop>")
set("n", "<Right>", "<nop>")
set("i", "<Left>", "<nop>")
set("n", "<Left>", "<nop>")
set("n", "<C-j>", "<cmd>cnext<CR>zz")
set("n", "<C-k>", "<cmd>cprev<CR>zz")
set("n", "<leader>xp", vim.diagnostic.setqflist, { desc = "Populate quickfix list" })
set("n", "<leader>p", "p", { silent = true, noremap = true, desc = "Paste from default register" })
set("v", "<leader>p", "p", { silent = true, noremap = true, desc = "Paste from default register" })
set("n", "y", '"+y', { silent = true, noremap = true })
set("v", "y", '"+y', { silent = true, noremap = true })
set("n", "p", '"+p', { silent = true, noremap = true })
set("v", "p", '"+p', { silent = true, noremap = true })
