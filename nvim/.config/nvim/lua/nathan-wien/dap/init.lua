local M = {}

M.load = function()
  -- dap
  local dap = require("dap")
  local dapui = require("dapui")
  local dap_python = require("dap-python")

  -- additional methods
  dap.toggle_conditional_breakpoint = function()
    vim.ui.input({ prompt = "Breakpoint condition: " }, function(condition)
      dap.set_breakpoint(condition)
    end)
  end

  -- dapui
  dap.listeners.after.event_initialized["dapui_config"] = function()
    dapui.open()
  end
  dap.listeners.before.event_terminated["dapui_config"] = function()
    dapui.close()
  end
  dap.listeners.before.event_exited["dapui_config"] = function()
    dapui.close()
  end

  -- key-mapping
  vim.keymap.set("n", "<Leader>db", dap.toggle_breakpoint)
  vim.keymap.set("n", "<Leader>dB", dap.toggle_conditional_breakpoint)
  vim.keymap.set("n", "<Leader>dg", dap.continue)
  vim.keymap.set("n", "<Leader>dj", dap.step_into)
  vim.keymap.set("n", "<Leader>dl", dap.step_over)
  vim.keymap.set("n", "<Leader>dk", dap.step_out)
  vim.keymap.set("n", "<Leader>dh", dap.repl.open)
  vim.keymap.set("n", "<Leader>de", dapui.eval)
  vim.keymap.set("n", "<Leader>dC", dapui.close)

  -- dap-python
  vim.api.nvim_create_autocmd("FileType", {
    pattern = "python",
    callback = vim.schedule_wrap(function()
      vim.keymap.set("n", "<Leader>dt", dap_python.test_method, {
        buffer = 0,
      })
    end),
  })
end

return M