local dapui = require('dapui');

vim.keymap.set("n", "<leader>b", function() require 'dap'.toggle_breakpoint() end,
    { desc = 'Toggle BreakPoint' })
vim.keymap.set("n", "<leader>B", function() require 'dap'.set_breakpoint() end)
vim.keymap.set("n", "<F5>", function() require 'dap'.continue() end)
vim.keymap.set("n", "<F7>", function() require 'dap'.step_into() end,
    { desc = 'DEBUG - Step Into' })
vim.keymap.set("n", "<F8>", function() require 'dap'.step_over() end,
    { desc = 'DEBUG - Step Over' })
vim.keymap.set("n", "<F9>", function() require 'dap'.continue() end,
    { desc = 'DEBUG - Continue' })
vim.keymap.set("v", "<M-m>", function() require("dapui").eval() end)
vim.keymap.set("n", "<M-3>", function()
    dapui.toggle()
end)

local dap = require('dap')

dap.configurations.java = {
  {
    type = 'java';
    request = 'attach';
    name = "Debug (Attach) - Remote";
    hostName = "127.0.0.1";
    port = 5005;
  },
}
