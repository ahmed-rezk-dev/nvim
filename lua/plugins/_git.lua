local M = {}

M.neogitSetup = function()
    local neogit = require "neogit"
    neogit.setup {
        disable_signs = false,
        disable_hint = false,
        disable_context_highlighting = false,
        disable_commit_confirmation = false,
        -- Neogit refreshes its internal state after specific events, which can be expensive depending on the repository size.
        -- Disabling `auto_refresh` will make it so you have to manually refresh the status after you open it.
        auto_refresh = true,
        disable_builtin_notifications = false,
        use_magit_keybindings = false,
        commit_popup = {
            kind = "split",
        },
        -- Change the default way of opening neogit
        kind = "tab",
        -- customize displayed signs
        signs = {
            -- { CLOSED, OPENED }
            section = { ">", "v" },
            item = { ">", "v" },
            hunk = { "", "" },
        },
        integrations = {
            -- Neogit only provides inline diffs. If you want a more traditional way to look at diffs, you can use `sindrets/diffview.nvim`.
            -- The diffview integration enables the diff popup, which is a wrapper around `sindrets/diffview.nvim`.
            --
            -- Requires you to have `sindrets/diffview.nvim` installed.
            -- use {
            --   'TimUntersberger/neogit',
            --   requires = {
            --     'nvim-lua/plenary.nvim',
            --     'sindrets/diffview.nvim'
            --   }
            -- }
            --
            diffview = true,
        },
        -- Setting any section to `false` will make the section not render at all
        sections = {
            untracked = {
                folded = false,
            },
            unstaged = {
                folded = false,
            },
            staged = {
                folded = false,
            },
            stashes = {
                folded = true,
            },
            unpulled = {
                folded = true,
            },
            unmerged = {
                folded = false,
            },
            recent = {
                folded = true,
            },
        },
        -- override/add mappings
        mappings = {
            -- modify status buffer mappings
            status = {
                -- Adds a mapping with "B" as key that does the "BranchPopup" command
                ["B"] = "BranchPopup",
            },
        },
    }
end

M.diffviewSetup = function()
    local cb = require("diffview.config").diffview_callback
    require("diffview").setup {
        diff_binaries = false, -- Show diffs for binaries
        enhanced_diff_hl = false, -- See ':h diffview-config-enhanced_diff_hl'
        use_icons = true, -- Requires nvim-web-devicons
        icons = { -- Only applies when use_icons is true.
            folder_closed = "",
            folder_open = "",
        },
        signs = {
            fold_closed = "",
            fold_open = "",
        },
        view = {
            -- Configure the layout and behavior of different types of views.
            -- Available layouts: 
            --  'diff1_plain'
            --    |'diff2_horizontal'
            --    |'diff2_vertical'
            --    |'diff3_horizontal'
            --    |'diff3_vertical'
            --    |'diff3_mixed'
            --    |'diff4_mixed'
            -- For more info, see ':h diffview-config-view.x.layout'.
            default = {
              -- Config for changed files, and staged files in diff views.
              layout = "diff2_horizontal",
            },
            merge_tool = {
              -- Config for conflicted files in diff views during a merge or rebase.
              layout = "diff3_horizontal",
              disable_diagnostics = true,   -- Temporarily disable diagnostics for conflict buffers while in the view.
            },
            file_history = {
              -- Config for changed files in file history views.
              layout = "diff2_horizontal",
            },
          },
        file_panel = {
            win_config = {
                position = "right", -- One of 'left', 'right', 'top', 'bottom'
                width = 80, -- Only applies when position is 'left' or 'right'
                height = 10, -- Only applies when position is 'top' or 'bottom'
            },
            listing_style = "tree", -- One of 'list' or 'tree'
            tree_options = { -- Only applies when listing_style is 'tree'
                flatten_dirs = true, -- Flatten dirs that only contain one single dir
                folder_statuses = "only_folded", -- One of 'never', 'only_folded' or 'always'.
            },
        },
        file_history_panel = {
            win_config = {
                position = "bottom",
                width = 35,
                height = 16,
            },
            log_options = {
                  git = {
                    single_file = {
                        max_count = 256, -- Limit the number of commits
                        follow = false, -- Follow renames (only for single file)
                        all = false, -- Include all refs under 'refs/' including HEAD
                        merges = false, -- List only merge commits
                        no_merges = false, -- List no merge commits
                        reverse = false, -- List commits in reverse order
                    },
                    multi_file = {
                        max_count = 256, -- Limit the number of commits
                        follow = false, -- Follow renames (only for single file)
                        all = false, -- Include all refs under 'refs/' including HEAD
                        merges = false, -- List only merge commits
                        no_merges = false, -- List no merge commits
                        reverse = false, -- List commits in reverse order
                    },
                },
            },
        },
        default_args = { -- Default args prepended to the arg-list for the listed commands
            DiffviewOpen = {},
            DiffviewFileHistory = {},
        },
        hooks = {}, -- See ':h diffview-config-hooks'
        key_bindings = {
            disable_defaults = false, -- Disable the default key bindings
            -- The `view` bindings are active in the diff buffers, only when the current
            -- tabpage is a Diffview.
            view = {
                ["<tab>"] = cb "select_next_entry", -- Open the diff for the next file
                ["<s-tab>"] = cb "select_prev_entry", -- Open the diff for the previous file
                ["gf"] = cb "goto_file", -- Open the file in a new split in previous tabpage
                ["<C-w><C-f>"] = cb "goto_file_split", -- Open the file in a new split
                ["<C-w>gf"] = cb "goto_file_tab", -- Open the file in a new tabpage
                ["<leader>e"] = cb "focus_files", -- Bring focus to the files panel
                ["<leader>b"] = cb "toggle_files", -- Toggle the files panel.
            },
            file_panel = {
                ["j"] = cb "next_entry", -- Bring the cursor to the next file entry
                ["<down>"] = cb "next_entry",
                ["k"] = cb "prev_entry", -- Bring the cursor to the previous file entry.
                ["<up>"] = cb "prev_entry",
                ["<cr>"] = cb "select_entry", -- Open the diff for the selected entry.
                ["o"] = cb "select_entry",
                ["<2-LeftMouse>"] = cb "select_entry",
                ["-"] = cb "toggle_stage_entry", -- Stage / unstage the selected entry.
                ["S"] = cb "stage_all", -- Stage all entries.
                ["U"] = cb "unstage_all", -- Unstage all entries.
                ["X"] = cb "restore_entry", -- Restore entry to the state on the left side.
                ["R"] = cb "refresh_files", -- Update stats and entries in the file list.
                ["<tab>"] = cb "select_next_entry",
                ["<s-tab>"] = cb "select_prev_entry",
                ["gf"] = cb "goto_file",
                ["<C-w><C-f>"] = cb "goto_file_split",
                ["<C-w>gf"] = cb "goto_file_tab",
                ["i"] = cb "listing_style", -- Toggle between 'list' and 'tree' views
                ["f"] = cb "toggle_flatten_dirs", -- Flatten empty subdirectories in tree listing style.
                ["<leader>e"] = cb "focus_files",
                ["<leader>b"] = cb "toggle_files",
            },
            file_history_panel = {
                ["g!"] = cb "options", -- Open the option panel
                ["<C-A-d>"] = cb "open_in_diffview", -- Open the entry under the cursor in a diffview
                ["y"] = cb "copy_hash", -- Copy the commit hash of the entry under the cursor
                ["zR"] = cb "open_all_folds",
                ["zM"] = cb "close_all_folds",
                ["j"] = cb "next_entry",
                ["<down>"] = cb "next_entry",
                ["k"] = cb "prev_entry",
                ["<up>"] = cb "prev_entry",
                ["<cr>"] = cb "select_entry",
                ["o"] = cb "select_entry",
                ["<2-LeftMouse>"] = cb "select_entry",
                ["<tab>"] = cb "select_next_entry",
                ["<s-tab>"] = cb "select_prev_entry",
                ["gf"] = cb "goto_file",
                ["<C-w><C-f>"] = cb "goto_file_split",
                ["<C-w>gf"] = cb "goto_file_tab",
                ["<leader>e"] = cb "focus_files",
                ["<leader>b"] = cb "toggle_files",
            },
            option_panel = {
                ["<tab>"] = cb "select",
                ["q"] = cb "close",
            },
        },
    }
end

M.gitsignsSetup = function()
    local status_ok, gitsigns = pcall(require, "gitsigns")
    if not status_ok then
        return
    end

    gitsigns.setup({
        signs = {
            add = { hl = "GitSignsAdd", text = "▎", numhl = "GitSignsAddNr", linehl = "GitSignsAddLn" },
            change = { hl = "GitSignsChange", text = "▎", numhl = "GitSignsChangeNr", linehl = "GitSignsChangeLn" },
            delete = { hl = "GitSignsDelete", text = "契", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
            topdelete = { hl = "GitSignsDelete", text = "契", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
            changedelete = {
                hl = "GitSignsChange",
                text = "▎",
                numhl = "GitSignsChangeNr",
                linehl = "GitSignsChangeLn",
            },
        },
        signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
        numhl = false, -- Toggle with `:Gitsigns toggle_numhl`
        linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
        word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
        watch_gitdir = {
            interval = 1000,
            follow_files = true,
        },
        attach_to_untracked = true,
        current_line_blame = true, -- Toggle with `:Gitsigns toggle_current_line_blame`
        current_line_blame_opts = {
            virt_text = true,
            virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
            delay = 1000,
            ignore_whitespace = false,
        },
        current_line_blame_formatter_opts = {
            relative_time = false,
        },
        sign_priority = 6,
        update_debounce = 100,
        status_formatter = nil, -- Use default
        max_file_length = 40000,
        preview_config = {
            -- Options passed to nvim_open_win
            border = "single",
            style = "minimal",
            relative = "cursor",
            row = 0,
            col = 1,
        },
        yadm = {
            enable = false,
        },
    })
end

M.cmpGitSetup = function()
local format = require("cmp_git.format")
local sort = require("cmp_git.sort")

require("cmp_git").setup({
    -- defaults
    filetypes = { "gitcommit", "octo" },
    remotes = { "upstream", "origin" }, -- in order of most to least prioritized
    enableRemoteUrlRewrites = false, -- enable git url rewrites, see https://git-scm.com/docs/git-config#Documentation/git-config.txt-urlltbasegtinsteadOf
    git = {
        commits = {
            limit = 100,
            sort_by = sort.git.commits,
            format = format.git.commits,
        },
    },
    github = {
        issues = {
            fields = { "title", "number", "body", "updatedAt", "state" },
            filter = "all", -- assigned, created, mentioned, subscribed, all, repos
            limit = 100,
            state = "open", -- open, closed, all
            sort_by = sort.github.issues,
            format = format.github.issues,
        },
        mentions = {
            limit = 100,
            sort_by = sort.github.mentions,
            format = format.github.mentions,
        },
        pull_requests = {
            fields = { "title", "number", "body", "updatedAt", "state" },
            limit = 100,
            state = "open", -- open, closed, merged, all
            sort_by = sort.github.pull_requests,
            format = format.github.pull_requests,
        },
    },
    gitlab = {
        issues = {
            limit = 100,
            state = "opened", -- opened, closed, all
            sort_by = sort.gitlab.issues,
            format = format.gitlab.issues,
        },
        mentions = {
            limit = 100,
            sort_by = sort.gitlab.mentions,
            format = format.gitlab.mentions,
        },
        merge_requests = {
            limit = 100,
            state = "opened", -- opened, closed, locked, merged
            sort_by = sort.gitlab.merge_requests,
            format = format.gitlab.merge_requests,
        },
    },
    trigger_actions = {
        {
            debug_name = "git_commits",
            trigger_character = ":",
            action = function(sources, trigger_char, callback, params, git_info)
                return sources.git:get_commits(callback, params, trigger_char)
            end,
        },
        {
            debug_name = "gitlab_issues",
            trigger_character = "#",
            action = function(sources, trigger_char, callback, params, git_info)
                return sources.gitlab:get_issues(callback, git_info, trigger_char)
            end,
        },
        {
            debug_name = "gitlab_mentions",
            trigger_character = "@",
            action = function(sources, trigger_char, callback, params, git_info)
                return sources.gitlab:get_mentions(callback, git_info, trigger_char)
            end,
        },
        {
            debug_name = "gitlab_mrs",
            trigger_character = "!",
            action = function(sources, trigger_char, callback, params, git_info)
                return sources.gitlab:get_merge_requests(callback, git_info, trigger_char)
            end,
        },
        {
            debug_name = "github_issues_and_pr",
            trigger_character = "#",
            action = function(sources, trigger_char, callback, params, git_info)
                return sources.github:get_issues_and_prs(callback, git_info, trigger_char)
            end,
        },
        {
            debug_name = "github_mentions",
            trigger_character = "@",
            action = function(sources, trigger_char, callback, params, git_info)
                return sources.github:get_mentions(callback, git_info, trigger_char)
            end,
        },
    },
  }
)
end


M.gitConflicts = function ()
    require('git-conflict').setup({
        default_mappings = true, -- disable buffer local mapping created by this plugin
        default_commands = true, -- disable commands created by this plugin
        disable_diagnostics = false, -- This will disable the diagnostics in a buffer whilst it is conflicted
        highlights = { -- They must have background color, otherwise the default color will be used
            incoming = 'DiffText',
            current = 'DiffAdd',
        }
    })
    vim.api.nvim_create_autocommand('User', {
        pattern = 'GitConflictDetected',
            callback = function()
            vim.notify('Conflict detected in '..vim.fn.expand('<afile>'))
            vim.keymap.set('n', 'cww', function()
              --[[ engage.conflict_buster() ]]
              --[[ create_buffer_local_mappings() ]]
            end)
        end
    })
end

return M
