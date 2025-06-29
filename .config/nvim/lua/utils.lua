local M = {}

--Keyremap function with extra common options
function M.kmap(mode, lhs, rhs, opts)
	local options = { noremap = true, silent = true }
	if opts then
		options = vim.tbl_extend("force", options, opts)
	end
	vim.keymap.set(mode, lhs, rhs, options)
end

local function script_path()
	return debug.getinfo(2, "S").source:sub(2)
end

M._log_path = '/tmp/nvimdebug.log'

function M.log(...)
	if not M._fh then
		M._fh = io.open(M._log_path, 'a')
	end
	local buf = {}
	for i = 1, select('#', ...) do
		local v = select(i, ...)
		table.insert(buf, vim.inspect(v))
	end
	M._fh:write(
		os.date('%Y:%m:%d %H.%M.%S')
		.. ' '
		.. script_path()
		.. '\n'
		.. table.concat(buf, '\n')
		.. '\n\n'
	)
	M._fh:flush()
end

return M
