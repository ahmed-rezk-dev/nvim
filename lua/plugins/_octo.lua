local M = {}

M.setup = function()
    require "octo".setup({
        github_hostname = "github.com";
    })
end

return M
