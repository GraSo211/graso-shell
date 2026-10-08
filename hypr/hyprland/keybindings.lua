
-----------------------
-------VARIABLES-------
-----------------------
local mainMod = "SUPER" -- Sets "Windows" key as main modifier
local browser = "zen-browser"
local code = "code"
local fileManager = "dolphin"
local terminal = "kitty"
local launcher = "pkill rofi || rofi -show run"
local lockscreen = "hyprlock"
local logoutMenu = "pkill wlogout || wlogout"


----------------------
--------APPS----------
----------------------
hl.bind(mainMod .. " + W", hl.dsp.exec_cmd(browser)) -- browser
hl.bind(mainMod .. " + D", hl.dsp.exec_cmd("discord")) -- discord
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(fileManager)) -- file explorer
hl.bind(mainMod .. " + R", hl.dsp.exec_cmd(code)) -- vscode
hl.bind(mainMod .. " + Return", hl.dsp.exec_cmd(terminal)) -- terminal 
hl.bind(mainMod .. " + SUPER_L", hl.dsp.exec_cmd(launcher), { release = true  }) -- apps launcher
hl.bind(mainMod .. " + Tab", hl.dsp.exec_cmd("skwd-wall-v2 toggle"))
hl.bind(mainMod .. " + Q", hl.dsp.window.close()) -- close windows
hl.bind("ALT" .. " + Tab", function() hl.plugin.overview.toggle("all") end) -- use pluggin hyprspace to navigate workspaces

-- Screen Print
hl.bind("Print", hl.dsp.exec_cmd('grim - | wl-copy')) -- Screen Print
hl.bind("SUPER" .. "+ SHIFT + " .. "S", hl.dsp.exec_cmd('grim -g "$(slurp)" - | tee >(wl-copy) | satty --filename - --auto-copy --copy-command wl-copy')) -- Print region screen 

-- Screen Recorder
hl.bind(mainMod .. "+ SHIFT + " .. "R", hl.dsp.exec_cmd([[pkill -SIGINT -f "^gpu-screen-recorder" || gpu-screen-recorder -w $(hyprctl monitors -j | jq -r '.[] | select(.focused) | .name') -f 60 -a default_output -o /mnt/general/recorders/record_region_d"$(date "+%d-%m-%y_h%H-%M-%S")".mp4]])) -- Record focus screen
hl.bind("ALT" .. "+ SHIFT + " .. "R", hl.dsp.exec_cmd([[pkill -SIGINT -f "^gpu-screen-recorder" || gpu-screen-recorder -w "$(slurp -f '%wx%h+%x+%y')" -f 60 -a default_output -o /mnt/general/recorders/record_region_d"$(date "+%d-%m-%y_h%H-%M-%S")".mp4]])) -- Record region screen


hl.bind(mainMod .. " + L", hl.dsp.exec_cmd(lockscreen)) -- lockscreen
hl.bind(mainMod .. " + X", hl.dsp.exec_cmd(logoutMenu)) -- logout menu


----------------------
-------WINDOWS--------
----------------------
hl.bind(mainMod .. " + F", hl.dsp.window.float({ action = "toggle" })) -- float to tiling | tiling to float
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo()) -- original window size
hl.bind(mainMod .. " + J", hl.dsp.layout("togglesplit")) -- dwindle only, change horizontal to vertical | vertical to horizontal
hl.bind(mainMod .. " + S",         hl.dsp.workspace.toggle_special("magic")) -- magic workspace 
hl.bind(mainMod .. " + ALT + S", hl.dsp.window.move({ workspace = "special:magic" })) -- send windows to magic workspace

-- Move windows on workspaces using keyboard
for i = 1, 10 do
	hl.bind(mainMod .. " + SHIFT +" .. (i % 10), hl.dsp.window.move({ workspace = i}) )
end

-- Move windows on workspaces using mouse wheel
hl.bind(mainMod .. " + SHIFT + mouse_up", hl.dsp.window.move({ workspace = "+1" }))
hl.bind(mainMod .. " + SHIFT + mouse_down", hl.dsp.window.move({ workspace = "-1" }))

-----------------------
--------FOCUS----------
-----------------------
-- Move focus with mainMod + arrow keys
hl.bind(mainMod .. " + left",  hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up",    hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down",  hl.dsp.focus({ direction = "down" }))

----------------------
------WORKSPACES------
----------------------

--- Change workspace using normal keys
for i = 1, 10 do
    hl.bind("SUPER + " .. (i % 10), hl.dsp.focus({ workspace = i }),{description = "Workspace: Focus " .. i })
end

-- Change workspace using raw keycodes (for some display keyboard)
for i = 1, 10 do
    local numberkey = { 10, 11, 12, 13, 14, 15, 16, 17, 18, 19 }
    hl.bind("SUPER + code:" .. numberkey[i], hl.dsp.focus({ workspace = i }))
end

-- Change workspace using keypad numbers
for i = 1, 10 do
    local numpadkey = { 87, 88, 89, 83, 84, 85, 79, 80, 81, 90 }
    hl.bind("SUPER + code:" .. numpadkey[i], hl.dsp.focus({ workspace = i }))
end


-- Change workspace with mouse wheel
for i = 1, 4 do
    local key = { "SUPER + mouse_up", "SUPER + mouse_down" }
    local keycombos = { key[1], key[2], "CTRL + " .. key[1], "CTRL + " .. key[2] }
    local prefix = { "+", "-", "r+", "r-" }
    hl.bind(keycombos[i], hl.dsp.focus({ workspace = prefix[i] .. "1" }))
end

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })


----------------------
----SOUND-CONTROL-----
----------------------
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("swayosd-client --output-volume raise"), { locked = true, repeating = true }) -- VOLUME UP
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("swayosd-client --output-volume lower"),      { locked = true, repeating = true }) -- VOLOME DOWN
hl.bind("XF86AudioMute",        hl.dsp.exec_cmd("swayosd-client --output-volume mute-toggle"),     { locked = true, repeating = true }) -- MUTE AUDIO
hl.bind("XF86AudioMicMute",     hl.dsp.exec_cmd("swayosd-client --input-volume mute-toggle"),   { locked = true, repeating = true }) -- MUTE MIC

hl.bind("XF86AudioNext",  hl.dsp.exec_cmd("playerctl next"),       { locked = true }) -- NEXT SOUND
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true }) -- STOP SOUND
hl.bind("XF86AudioPlay",  hl.dsp.exec_cmd("playerctl play-pause"), { locked = true }) -- PLAY SOUND
hl.bind("XF86AudioPrev",  hl.dsp.exec_cmd("playerctl previous"),   { locked = true }) -- PREVIOUS SOUND

----------------------
--BRIGHTNESS-CONTROL--
----------------------
hl.bind("XF86MonBrightnessUp",   hl.dsp.exec_cmd("swayosd-client --brightness raise"))
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("swayosd-client --brightness lower"))
