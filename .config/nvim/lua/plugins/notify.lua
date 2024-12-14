local function notify_config()
	notify = require("notify")

	notify.setup({ stages = 'no_animation' })
end
return {
	"rcarriga/nvim-notify",
	config = notify_config,
}
