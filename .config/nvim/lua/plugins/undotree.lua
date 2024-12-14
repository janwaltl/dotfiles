local function undootree_config()
	vim.g.undotree_SplitWidth = 60
	vim.g.undotree_SetFocusWhenToggle = 1
end

return {
	-- Undotree
	"mbbill/undotree",
	config = undootree_config,
}
