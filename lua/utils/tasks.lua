local M = {}
local overseer = require('overseer')
M.runTypeCheckTasks = function()
    overseer.add_template_hook({ name= 'npm typecheck' }, function(task_defn, util)
      util.add_component(task_defn, { "on_output_quickfix", open = false, set_diagnostics = true,  items_only = true })
      util.add_component(task_defn, { "on_result_notify", infer_status_from_diagnostics = true })
    end)

    overseer.run_template({name = 'npm typecheck', autostart = true}, function(task)
      if task then
        task:add_component({'dependencies', task_names = {
          'npm build',
        }, sequential = false})
        task:start()
      end
    end)
end

return M
