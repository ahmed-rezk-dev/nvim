local helper = require "utils.helper"
local Job = require("plenary.job")
local log = require("utils.log")

local M = {}



function M.make()

-- set content
  local lines = {""}
  local winnr = vim.fn.win_getid()
  local bufnr = vim.api.nvim_win_get_buf(winnr)


  local makeprg = vim.api.nvim_buf_get_option(bufnr, "makeprg")
  if not makeprg then return end

  local cmd = vim.fn.expandcmd(makeprg)

  local function on_event(job_id, data, event)
    if event == "stdout" or event == "stderr" then

      if next(data) ~= nil then
        vim.list_extend(lines, data)
      end
    end


    local result = {}
    for i = 1, #lines do
        if(lines[i]  and lines[i] ~= '') then
            result[#result + 1] = lines[i]
            --[[ result[i] = (lines[i]):gsub(string.char(27) .. '[[0-9;]*m', "") ]]
        end
    end
    --[[ print(vim.inspect(result)) ]]
    print(vim.diagnostic.toqflist(lines))
--[[ { "src/app/pages/pages.context.tsx(7,2): error TS2724: '\"src/core/utils/loading\"' has no exported member named 'Lloaded'. Did you mean 'Loaded'?" } ]]
    --[[ vim.diagnostic.setqflist({}, ' ', {title = "eslint -- errors", lines = result, efm = "%f: line %l\\, col %c\\, %m,%-G%.%#"}) ]]
--[[ vim.diagnostic.setqflist({},' ',{ title = 'eslint', item = { {bufnr = 1, lnum = 2, col = 7, end_lnum ='xx',end_col ='xx', text = 'your message', type ='E'} }}) ]]
    --[[ if next(lines) ~= nil then ]]
    --[[     if event == "exit" then ]]
    --[[       vim.diagnostic.setqflist({}, " ", { ]]
    --[[         title = cmd, ]]
    --[[         lines = result, ]]
    --[[         efm = vim.api.nvim_buf_get_option(bufnr, "errorformat") ]]
    --[[       }) ]]
    --[[       vim.api.nvim_command("doautocmd QuickFixCmdPost") ]]
    --[[     end ]]
    --[[ end ]]

  end

  local job_id =
    vim.fn.jobstart(
    cmd,
    {
      on_stderr = on_event,
      on_stdout = on_event,
      on_exit = on_event,
      stdout_buffered = true,
      stderr_buffered = true,
    }
  )
end

M.localMake = function ()
    local function setqf(err, data)
      vim.schedule_wrap(function()
        if err then
          print('ERROR: ', err)
        end
        if data then

          vim.fn.setqflist({{filename = "foo.lua", lnum = 1, text = vim.inspect(data)}})
          print(vim.inspect(data))
        end
      end)

    end

    Job:new({
        command = "npm",
        args = { "start" },
        cwd = vim.loop.cwd(),
        on_stdout = setqf,
        on_stderr = setqf,
    }):start()
end


return M
