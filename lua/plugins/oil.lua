-- helper function to parse output
local function parse_output(proc)
	local result = proc:wait()
	local ret = {}
	if result.code == 0 then
		for line in vim.gsplit(result.stdout, "\n", { plain = true, trimempty = true }) do
			-- Remove trailing slash
			line = line:gsub("/$", "")
			ret[line] = true
		end
	end
	return ret
end

-- build git status cache
local function new_git_status()
	return setmetatable({}, {
		__index = function(self, key)
			local ignore_proc = vim.system(
				{ "git", "ls-files", "--ignored", "--exclude-standard", "--others", "--directory" },
				{
					cwd = key,
					text = true,
				}
			)
			local tracked_proc = vim.system({ "git", "ls-tree", "HEAD", "--name-only" }, {
				cwd = key,
				text = true,
			})
			local ret = {
				ignored = parse_output(ignore_proc),
				tracked = parse_output(tracked_proc),
			}

			rawset(self, key, ret)
			return ret
		end,
	})
end
local git_status = new_git_status()

-- Clear git status cache on refresh
-- local refresh = require("oil.actions").refresh
-- local orig_refresh = refresh.callback
-- refresh.callback = function(...)
-- 	git_status = new_git_status()
-- 	orig_refresh(...)
-- end

function _G.get_oil_winbar()
	local dir = require("oil").get_current_dir()
	if dir then
		return vim.fn.fnamemodify(dir, ":~")
	else
		-- If there is no current directory (e.g. over ssh), just show the buffer name
		return vim.api.nvim_buf_get_name(0)
	end
end
-- Function to detect if this is the last listed buffer
local function is_last_buffer()
	local buffers = vim.fn.getbufinfo({ buflisted = 1 }) -- Get all listed buffers
	return #buffers == 1
end

local detail = false
return {
	-- {
	-- 	"refractalize/oil-git-status.nvim",
	-- 	config = true,
	-- },
	{
		"stevearc/oil.nvim",
		---@module 'oil'
		dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if prefer nvim-web-devicons
		config = function()
			local oil = require("oil")
			oil.setup({
				default_file_explorer = true,
				skip_confirm_for_simple_edits = false,
				keymaps = {
					["q"] = {
						desc = "Close oil",
						callback = function()
							if not is_last_buffer() then
								oil.close()
							end
						end,
					},
					["gd"] = {
						desc = "Toggle file detail view",
						callback = function()
							detail = not detail
							if detail then
								oil.set_columns({ "icon", "permissions", "size", "mtime" })
							else
								oil.set_columns({ "icon" })
							end
						end,
					},
				},
				view_options = {
					is_hidden_file = function(name, bufnr)
						local dir = require("oil").get_current_dir(bufnr)
						local is_dotfile = vim.startswith(name, ".") and name ~= ".."
						-- if no local directory (e.g. for ssh connections), just hide dotfiles
						if not dir then
							return is_dotfile
						end
						-- dotfiles are considered hidden unless tracked
						if is_dotfile then
							return not git_status[dir].tracked[name]
						else
							-- Check if file is gitignored
							return git_status[dir].ignored[name]
						end
					end,
				},
				float = {
					padding = 2,
					-- win_options = {
					-- 	winbar = "%!v:lua.get_oil_winbar()",
					-- },
				},
				win_options = {
					signcolumn = "no",
				},
			})
			vim.keymap.set("n", "<leader>n", ":Oil --float<CR>", {})
		end,
	},
}
