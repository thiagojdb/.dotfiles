local bufnr = vim.api.nvim_get_current_buf()
vim.keymap.set("n", "<leader>f", "<cmd>w<CR><cmd>silent !xmlformat --outfile % %<CR>",
  { buffer = bufnr, remap = false, silent = true, desc = "Format XML file" })
vim.api.nvim_buf_create_user_command(bufnr, "ConvertToWS",
"<cmd>%s?>?\\&gt?g<CR><cmd>%s?<?\\&lt?g<CR>",
{  desc = "Format XML file" })
