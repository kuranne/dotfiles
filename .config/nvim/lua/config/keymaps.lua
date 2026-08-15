-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local keymap = vim.keymap

-- Run 
local function run_in_split()
    local file_path = vim.fn.expand('%:p')
    local cmd = "run " .. file_path

    vim.cmd("botright 12split | terminal " .. cmd)
    vim.cmd("startinsert")
end

keymap.set('n', '<leader>r', run_in_split)
