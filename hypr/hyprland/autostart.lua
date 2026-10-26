local notification_daemon = "swaync"
local idle_manager = "hypridle"
hl.on("hyprland.start",function ()
	hl.exec_cmd(notification_daemon) -- notification manager
	hl.exec_cmd("systemctl --user start skwd-walld.service") -- wallpaper manager
	hl.exec_cmd(idle_manager) -- idle manager
	hl.exec_cmd("wl-paste --type text --watch cliphist store") -- clipboard store text
	hl.exec_cmd("wl-paste --type image --watch cliphist store") -- clipboard store images
	hl.exec_cmd("hyprsunset") -- brightness software
	hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP XDG_SESSION_TYPE") -- prevents issues 
	hl.exec_cmd("systemctl --user start hyprpolkitagent") -- authentication agent
	hl.exec_cmd("xsettingsd") -- no recuerdo porque lo puse, creo que era para algo de gdk o qt
	hl.exec_cmd("swayosd-server") -- visual changes on locks caps and brightess and volume.
	hl.exec_cmd("hyprpm reload -n")
	hl.exec_cmd("quickshell")
end)
