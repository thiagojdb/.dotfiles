local builtin = require('telescope.builtin');

vim.keymap.set("n", "<leader>ps", function()
  builtin.grep_string({ search = vim.fn.input("Grep For > ") })
end)

vim.keymap.set("n", "<Leader>pa", function()
  builtin.find_files()
end)

vim.keymap.set("n", "<Leader>pf", function()
  builtin.find_files({
    prompt_title = 'Find in Project/Module',
    hidden = false
  })
end)

vim.keymap.set("n", "<leader>pw", function()
  builtin.grep_string { search = vim.fn.expand("<cword>") }
end)

vim.keymap.set("n", "<leader>pb", function()
  builtin.buffers()
end)


vim.keymap.set("n", "<leader>fo", function()
  builtin.oldfildes()
end)


vim.keymap.set("n", "<leader>vh", function()
  builtin.help_tags()
end)

vim.keymap.set("n", "<leader>vrc", function()
  builtin.git_files({
    prompt_title = "< VimRC >",
    cwd = '~/.config/nvim',
    hidden = true,
  })
end)
