vim.keymap.set("i", "jj", "<esc>", { desc = "Switch to normal mode" })
vim.keymap.set("n", "<leader>w", "<cmd>w<cr>", { desc = "Save file" })
vim.keymap.set("n", "<right>", "<cmd>bnext<cr>", { desc = "Next buffer" })
vim.keymap.set("n", "<left>", "<cmd>bprevious<cr>", { desc = "Previous buffer" })
vim.keymap.set("n", "-", "<cmd>e %:h<cr>", { desc = "Go up directory" })
vim.keymap.set("n", "<leader>p", "<cmd>Telescope projects<cr>", { desc = "Select project" })
vim.keymap.set("n", "<leader>o", "m`o<esc>``", { desc = "Empty line below" })
vim.keymap.set("n", "<leader>O", "m`O<esc>``", { desc = "Empty line above" })
vim.keymap.set("n", "<leader>k", "<cmd>noh<cr>", { desc = "No highlight" })
