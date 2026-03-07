return {
  "mfussenegger/nvim-dap",
  dependencies = {
    "rcarriga/nvim-dap-ui", -- 调试 UI 界面
    "nvim-neotest/nvim-nio", -- 异步依赖
    "williamboman/mason.nvim", -- 包管理器（可选，用于管理其他调试器）
    "jay-babu/mason-nvim-dap.nvim", -- 自动安装调试适配器（可选）
  },
  config = function()
    local dap = require("dap")
    local dapui = require("dapui")

    -- 1. 配置 dap-ui（自动打开/关闭调试界面）
    dapui.setup()
    dap.listeners.after.event_initialized["dapui_config"] = function() dapui.open() end
    dap.listeners.before.event_terminated["dapui_config"] = function() dapui.close() end
    dap.listeners.before.event_exited["dapui_config"] = function() dapui.close() end

    -- 2. 配置 gdb 适配器（核心）
    dap.adapters.gdb = {
      type = "executable",
      command = "gdb", -- 系统 gdb 路径，若不在 PATH 中需写绝对路径（如 "/usr/bin/gdb"）
      args = { "-i", "dap" }, -- 让 gdb 以 DAP 协议模式运行
    }

    -- 3. 配置 C 程序调试参数
    dap.configurations.c = {
      {
        name = "Launch C Program (GDB)", -- 调试配置名称
        type = "gdb", -- 对应上面的适配器名称
        request = "launch", -- 启动模式（attach 为附加到进程）
        program = function() -- 动态输入可执行文件路径
          return vim.fn.input({
            prompt = "Path to executable: ",
            default = vim.fn.getcwd() .. "/",
            filetype = "file"
          })
        end,
        cwd = "${workspaceFolder}", -- 工作目录
        stopOnEntry = false, -- 是否在程序入口处暂停（设为 true 可在 main 函数第一行暂停）
        args = {}, -- 程序启动参数（如需要可改为 vim.fn.input("Args: ") 动态输入）
      },
    }

    -- 4. 调试快捷键映射
    vim.keymap.set("n", "<F5>", function() dap.continue() end, { desc = "Debug: Start/Continue" })
    vim.keymap.set("n", "<F10>", function() dap.step_over() end, { desc = "Debug: Step Over" })
    vim.keymap.set("n", "<F11>", function() dap.step_into() end, { desc = "Debug: Step Into" })
    vim.keymap.set("n", "<F12>", function() dap.step_out() end, { desc = "Debug: Step Out" })
    vim.keymap.set("n", "<leader>db", function() dap.toggle_breakpoint() end, { desc = "Debug: Toggle Breakpoint" })
    vim.keymap.set("n", "<leader>dB", function() dap.set_breakpoint(vim.fn.input("Condition: ")) end, { desc = "Debug: Conditional Breakpoint" })
    vim.keymap.set("n", "<leader>dr", function() dap.repl.open() end, { desc = "Debug: Open REPL" })

    vim.keymap.set("n", "<leader>du", function() require("dapui").toggle() end, { desc = "Debug: Toggle DAP UI" })
    vim.keymap.set("n", "<leader>dv", function() require("dapui").float_element("scopes") end, { desc = "Debug: Float Scopes" })
  end,
}

