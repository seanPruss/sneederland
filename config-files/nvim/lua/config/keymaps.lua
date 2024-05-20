-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

vim.keymap.set("i", "<C-c>", "<Esc>")

vim.keymap.set("n", "Q", "<nop>")
vim.keymap.set("n", "<leader>r", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = "Replace word" })
vim.keymap.set("n", "<leader>m", "<cmd>!chmod +x %<CR>", { silent = true, desc = "Make executable" })
vim.keymap.set("n", "<leader>[", "A {<CR><CR>}<Esc>kcc", { desc = "Create squirly braces" })
vim.keymap.set("n", "<leader>;", "A:<Esc>o", { desc = "Add colon + new line" })
vim.keymap.set("n", "j", "gjzz")
vim.keymap.set("n", "k", "gkzz")
vim.keymap.set("n", "<CR>", "<CR>zz")
vim.keymap.set("n", "-", "-zz")
vim.keymap.set("n", "G", "Gzz")
vim.keymap.set(
    "n",
    "<leader>i",
    [[i<!DOCTYPE html><CR><html lang="en"><CR><head><CR><meta charset="UTF-8"><CR><meta http-equiv="X-UA-Compatible" content="IE=edge"><CR><meta name="viewport" content="width=device-width, initial-scale=1"><CR><title>Document</title><CR></head><CR><body><CR><CR></body><CR></html><Esc>kkcc]],
    { desc = "HTML boilerplate" }
)
vim.keymap.set("n", "<C-s>", "<nop>")
vim.keymap.set("i", "<Up>", "<nop>")
vim.keymap.set("n", "<Up>", "<nop>")
vim.keymap.set("i", "<Down>", "<nop>")
vim.keymap.set("n", "<Down>", "<nop>")
vim.keymap.set("i", "<Right>", "<nop>")
vim.keymap.set("n", "<Right>", "<nop>")
vim.keymap.set("i", "<Left>", "<nop>")
vim.keymap.set("n", "<Left>", "<nop>")
vim.keymap.set("n", "<C-j>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-k>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>xp", vim.diagnostic.setqflist, { desc = "Populate quickfix list" })
vim.keymap.set("x", "p", [["_dP]])
