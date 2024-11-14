local options = {
	-- Example
	autoindent = true,
	cursorcolumn = false, -- 列強調(日本語と相性が悪いかもしれない)
	softtabstop = 4,
	--undodir = vim.fn.expand('~/ghq/github.com/went5/.neovim/undo'),

}
local conda_prefix = os.getenv("CONDA_PREFIX")
if not isempty(conda_prefix) then
	vim.g.python_host_prog = conda_prefix .. "/bin/python"
	vim.g.python3_host_prog = conda_prefix .. "/bin/python"
else
	vim.g.python_host_prog = "~/AppData/Roaming/pypoetry/venv/Scripts/python.exe"
	vim.g.python3_host_prog = "~/AppData/Roaming/pypoetry/venv/Scripts/python.exe"
end

if global.is_windows then
    -- custom
    local root_path = vim.fn.expand('~/ghq/github.com/went5/.neovim/')
    vim.g.sqlite_clib_path = root_path .. 'sqlite3.dll'
end

return options
