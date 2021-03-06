local M = {}

M.setup = function()
    -- telescope-dap
    require("telescope").load_extension "dap"

    -- nvim-dap-virtual-text. Show virtual text for current frame
    vim.g.dap_virtual_text = true

    -- nvim-dap-ui
    require("dapui").setup {
        icons = { expanded = "▾", collapsed = "▸" },
        mappings = {
            -- Use a table to apply multiple mappings
            expand = { "<CR>", "<2-LeftMouse>" },
            open = "o",
            remove = "d",
            edit = "e",
            repl = "r",
            toggle = "t",
        },
        -- Expand lines larger than the window
        -- Requires >= 0.7
        expand_lines = vim.fn.has "nvim-0.7",
        -- Layouts define sections of the screen to place windows.
        -- The position can be "left", "right", "top" or "bottom".
        -- The size specifies the height/width depending on position. It can be an Int
        -- or a Float. Integer specifies height/width directly (i.e. 20 lines/columns) while
        -- Float value specifies percentage (i.e. 0.3 - 30% of available lines/columns)
        -- Elements are the elements shown in the layout (in order).
        -- Layouts are opened in order so that earlier layouts take priority in window sizing.
        layouts = {
            {
                elements = {
                    -- Elements can be strings or table with id and size keys.
                    { id = "scopes", size = 0.45 },
                    "breakpoints",
                    "stacks",
                    "watches",
                },
                size = 80, -- 40 columns
                position = "right",
            },
            {
                elements = {
                    -- "repl",
                    -- "console",
                },
                size = 0.15, -- 25% of total lines
                position = "bottom",
            },
        },
        floating = {
            max_height = nil, -- These can be integers or a float between 0 and 1.
            max_width = nil, -- Floats will be treated as percentage of your screen.
            border = "single", -- Border style. Can be "single", "double" or "rounded"
            mappings = {
                close = { "q", "<Esc>" },
            },
        },
        windows = { indent = 1 },
        render = {
            max_type_length = nil, -- Can be integer or nil.
        },
    }
    -- local dap_install = require "dap-install"
    -- dap_install.config("chrome", {})

    -- languages
    -- require('dbg.python')
    -- require('dbg.node')
    require "lsp.dap.react"

    -- nvim-dap
    vim.fn.sign_define("DapBreakpoint", { text = "●", texthl = "ErrorMsg", linehl = "", numhl = "" })
    vim.fn.sign_define("DapStopped", { text = "●▶", texthl = "InfoMsg", linehl = "MatchParen", numhl = "" })
    vim.fn.sign_define("DapBreakpointCondition", { text = "C", texthl = "", linehl = "", numhl = "" })
    vim.fn.sign_define("DapBreakpointRejected", { text = "●", texthl = "WarningMsg", linehl = "", numhl = "" })
    vim.fn.sign_define("DapLogPoint", { text = "L", texthl = "", linehl = "", numhl = "" })

    require("nvim-dap-virtual-text").setup {
        enabled = true, -- enable this plugin (the default)
        enabled_commands = true, -- create commands DapVirtualTextEnable, DapVirtualTextDisable, DapVirtualTextToggle, (DapVirtualTextForceRefresh for refreshing when debug adapter did not notify its termination)
        highlight_changed_variables = true, -- highlight changed values with NvimDapVirtualTextChanged, else always NvimDapVirtualText
        highlight_new_as_changed = false, -- highlight new variables in the same way as changed variables (if highlight_changed_variables)
        show_stop_reason = true, -- show stop reason when stopped for exceptions
        commented = false, -- prefix virtual text with comment string
        -- experimental features:
        virt_text_pos = "eol", -- position of virtual text, see `:h nvim_buf_set_extmark()`
        all_frames = false, -- show virtual text for all stack frames not only current. Only works for debugpy on my machine.
        virt_lines = false, -- show virtual lines instead of virtual text (will flicker!)
        -- virt_text_win_col = nil, -- position the virtual text at a fixed window column (starting from the first text column) ,
        -- e.g. 80 to position at column 80, see `:h nvim_buf_set_extmark()`
    }

    local function map(mode, lhs, rhs, opts)
        local options = { noremap = true }
        if opts then
            options = vim.tbl_extend("force", options, opts)
        end
        vim.api.nvim_set_keymap(mode, lhs, rhs, options)
    end

    -- -- key mappings
    -- utils.map('n', '<leader>dct', '<cmd>lua require"dap".continue()<CR>')
    -- utils.map('n', '<leader>dsv', '<cmd>lua require"dap".step_over()<CR>')
    -- utils.map('n', '<leader>dsi', '<cmd>lua require"dap".step_into()<CR>')
    -- utils.map('n', '<leader>dso', '<cmd>lua require"dap".step_out()<CR>')
    -- utils.map('n', '<leader>dtb', '<cmd>lua require"dap".toggle_breakpoint()<CR>')
    --
    -- map("n", "<leader>dsk", '<cmd>lua require"dap.ui.variable".scopes()<CR>')
    -- map("n", "<leader>dhk", '<cmd>lua require"dap.ui.variables".hover()<CR>')
    -- utils.map('v', '<leader>dhv',
    --           '<cmd>lua require"dap.ui.variables".visual_hover()<CR>')
    --
    -- utils.map('n', '<leader>duh', '<cmd>lua require"dap.ui.widgets".hover()<CR>')
    -- utils.map('n', '<leader>duf',
    --           "<cmd>lua local widgets=require'dap.ui.widgets';widgets.centered_float(widgets.scopes)<CR>")
    --
    -- utils.map('n', '<leader>dsbr',
    --           '<cmd>lua require"dap".set_breakpoint(vim.fn.input("Breakpoint condition: "))<CR>')
    -- utils.map('n', '<leader>dsbm',
    --           '<cmd>lua require"dap".set_breakpoint(nil, nil, vim.fn.input("Log point message: "))<CR>')
    -- utils.map('n', '<leader>dro', '<cmd>lua require"dap".repl.open()<CR>')
    -- utils.map('n', '<leader>drl', '<cmd>lua require"dap".repl.run_last()<CR>')
    --
    -- -- telescope-dap
    -- utils.map('n', '<leader>dcc',
    --           '<cmd>lua require"telescope".extensions.dap.commands{}<CR>')
    -- utils.map('n', '<leader>dco',
    --           '<cmd>lua require"telescope".extensions.dap.configurations{}<CR>')
    -- utils.map('n', '<leader>dlb',
    --           '<cmd>lua require"telescope".extensions.dap.list_breakpoints{}<CR>')
    -- utils.map('n', '<leader>dv',
    --           '<cmd>lua require"telescope".extensions.dap.variables{}<CR>')
    -- utils.map('n', '<leader>df',
    --           '<cmd>lua require"telescope".extensions.dap.frames{}<CR>')
    --
    -- -- nvim-dap-ui
    -- utils.map('n', '<leader>dui', '<cmd>lua require"dapui".toggle()<CR>')s
end

return M
