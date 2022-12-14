local M = {}

function M.setup()
    require('yabs'):setup({
      languages = { -- List of languages in vim's `filetype` format
        typescript = {
          tasks = {
            run = {
              command = 'make', -- The command to run (% and other
              -- wildcards will be automatically
              -- expanded)
              type = 'typescript',  -- The type of command (can be `vim`, `lua`, or
              -- `shell`, default `shell`)
            },
          },
        },
      },
    tasks = { -- Same values as `language.tasks`, but global
        build = {
            command = 'echo building project...',
            output = 'consolation',
        },
        run = {
            command = 'npm run typecheck',
            output = 'quickfix',
        },
    },
      opts = { -- Same values as `language.opts`
        output_types = {
          quickfix = {
            open_on_run = 'always',
          },
        },
      },
    })
    local yabs = require('yabs')

    -- runs the task `build` for the current language, falling back to a global
    -- task with that name if it is not found for the current language
    yabs:run_task('build')

    -- runs the task that is specified as the default (see configuration section
    -- above), or the first one if not specified
    yabs:run_default_task()

    -- Run command `echo hello, world` directly. Output is specified by the second
    -- argument (same possible values as `output` option for tasks above), and
    -- additional arguments are defined with the third argument (same as
    -- `task.opts` above)
    yabs.run_command('echo hello, world', 'quickfix', { open_on_run = 'always' })
end

return M
