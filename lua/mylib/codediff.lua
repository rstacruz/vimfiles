-- codediff: VSCode-style diff view plus `:CodeDiffPR` (diff against the PR base)
--
-- `:CodeDiffPR` is defined eagerly in `init.lua` so `nvim +CodeDiffPR` works
-- without waiting for the deferred `later()` queue. This module loads the
-- plugin on first use; `setup()` is safe to call more than once.
--
-- :CodeDiff
-- :CodeDiff history
-- :CodeDiffPR (diff against PR base, or origin/HEAD when there's no PR)
--
-- Keymap:
-- g? - help
-- t - toggle side by side
-- gc - toggle compact mode
-- `-` - stage/unstage
--
-- q - quit
-- [c ]c - next hunk
-- [f ]f - next file
-- <leader>hs - stage hunk
-- <leader>hu - unstage hunk
-- <leader>hr - reject hunk

local M = {}

local loaded = false

-- Run a command in `cwd` and return trimmed stdout, or nil on failure
local function run(cmd, cwd)
	local ok, proc = pcall(vim.system, cmd, { cwd = cwd, text = true })
	if not ok then
		return nil
	end
	local result = proc:wait(10000)
	if result.code ~= 0 then
		return nil
	end
	return vim.trim(result.stdout or "")
end

local function git_root()
	local dir = vim.fs.dirname(vim.api.nvim_buf_get_name(0))
	if dir == "" or vim.fn.isdirectory(dir) == 0 then
		dir = vim.fn.getcwd()
	end
	return run({ "git", "rev-parse", "--show-toplevel" }, dir)
end

local function ref_exists(ref, root)
	return run({ "git", "rev-parse", "--verify", "--quiet", ref }, root) ~= nil
end

-- Prefer the current PR's base branch; fall back to the remote's default branch
local function resolve_pr_base(root)
	local base = run({ "gh", "pr", "view", "--json", "baseRefName", "--jq", ".baseRefName" }, root)
	if base and base ~= "" then
		for _, ref in ipairs({ "origin/" .. base, base }) do
			if ref_exists(ref, root) then
				return ref, false
			end
		end
	end

	local default = run({ "git", "symbolic-ref", "--short", "refs/remotes/origin/HEAD" }, root)
	if default and ref_exists(default, root) then
		return default, true
	end
	for _, ref in ipairs({ "main", "master" }) do
		if ref_exists(ref, root) then
			return ref, true
		end
	end
end

-- :CodeDiffPR uses codediff's triple-dot syntax (merge-base vs working tree)
function M.diff_pr()
	M.setup()

	local root = git_root()
	if not root then
		vim.notify("CodeDiffPR: not in a git repository", vim.log.levels.ERROR)
		return
	end

	local base, fallback = resolve_pr_base(root)
	if not base then
		vim.notify("CodeDiffPR: no base branch found", vim.log.levels.ERROR)
		return
	end
	if fallback then
		vim.notify("CodeDiffPR: no PR found, diffing against " .. base, vim.log.levels.INFO)
	end

	vim.cmd("CodeDiff " .. base .. "...")
end

function M.setup()
	if loaded then
		return
	end
	loaded = true

	MiniDeps.add({ source = "esmuellert/codediff.nvim" })
	require("codediff").setup({
		explorer = {
			view_mode = "tree",
		},
	})

	-- stylua: ignore start
	vim.keymap.set("n", "<leader>gd", "<cmd>CodeDiff<cr>", { desc = "Show diff" })
	vim.keymap.set("n", "<leader>gp", "<cmd>CodeDiffPR<cr>", { desc = "Show diff against PR base" })
	-- stylua: ignore end
end

return M
