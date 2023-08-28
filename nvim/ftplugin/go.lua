local dap = require("dap")

dap.adapters.go = {
  type = 'executable',
  command = '/home/thiago/.local/share/nvim/mason/bin/go-debug-adapter',
}
dap.configurations.go = {
  {
    type = 'go',
    name = 'Debug',
    request = 'launch',
    showLog = false,
    program = "${file}",
    dlvToolPath = vim.fn.exepath('dlv')  -- Adjust to where delve is installed
  },
}
