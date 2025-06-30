local diag_signs = {
	[vim.diagnostic.severity.ERROR] = "E",
	[vim.diagnostic.severity.WARN] = "W",
	[vim.diagnostic.severity.INFO] = "I",
	[vim.diagnostic.severity.HINT] = "H",
}
local function diag_format_short(diagnostic)
	return string.format(
		"%s %s",
		diagnostic.source,
		diagnostic.code or ""
	)
end
local function diag_format_detail(diagnostic)
	return string.format(
		"%s[%s]:%s %s",
		diagnostic.source,
		diag_signs[diagnostic.severity],
		diagnostic.code or "",
		diagnostic.message
	)
end

vim.diagnostic.config({
	virtual_lines = {
		current_line = true,
		format = diag_format_detail
	},
	virtual_text = { format = diag_format_short },
	underline = true,
	severity_sort = true
})

return {}
