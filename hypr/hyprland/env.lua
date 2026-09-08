--------------------------------------------------------------------------------
-- XDG Specifications
-- Required for xdg-desktop-portal, clipboard, and screen sharing (PipeWire)
-- to correctly recognize the running session.
--------------------------------------------------------------------------------
hl.env("XDG_CURRENT_DESKTOP", "Hyprland") -- Specifies Hyprland as the current desktop
hl.env("XDG_SESSION_TYPE", "wayland")     -- Informs applications that the session is Wayland
hl.env("XDG_SESSION_DESKTOP", "Hyprland") -- Sets the desktop session name

--------------------------------------------------------------------------------
-- Toolkit Integration
-- Forces native Wayland rendering instead of falling back to XWayland.
--------------------------------------------------------------------------------
hl.env("GDK_BACKEND", "wayland,x11,*")              -- GTK: Prefer Wayland; fallback to X11
hl.env("QT_QPA_PLATFORM", "wayland;xcb")            -- Qt: Prefer Wayland; fallback to XCB (X11)
hl.env("SDL_VIDEODRIVER", "wayland")                -- SDL2: Force Wayland for games and compatible apps
hl.env("CLUTTER_BACKEND", "wayland")                -- Clutter: Force the Wayland backend
hl.env("QT_WAYLAND_DISABLE_WINDOWDECORATION", "1")  -- Qt: Disable double/native window decorations

hl.env("QT_QUICK_CONTROLS_STYLE","org.hyprland.style")
hl.env("QT_QPA_PLATFORMTHEME", "hyprqt6engine")

--------------------------------------------------------------------------------
-- NVIDIA Specific Configuration
-- Prevents black screens, rendering glitches, and enables GPU drivers.
--------------------------------------------------------------------------------
hl.env("GBM_BACKEND", "nvidia-drm")        -- Use NVIDIA's GBM memory allocator
hl.env("LIBVA_DRIVER_NAME", "nvidia")      -- Specify NVIDIA driver for VA-API hardware acceleration
hl.env("__GLX_VENDOR_LIBRARY_NAME", "nvidia") -- Ensure the use of NVIDIA's OpenGL/GLX library

--------------------------------------------------------------------------------
-- Electron Apps & Hardware Video Acceleration
--------------------------------------------------------------------------------
-- Allows Electron apps (VS Code, Discord, Spotify) to auto-detect Wayland
hl.env("ELECTRON_OZONE_PLATFORM_HINT", "auto")

-- Set direct backend for libva-nvidia-driver (improves browser hardware video decoding)
hl.env("NVD_BACKEND", "direct")

--------------------------------------------------------------------------------
--- PERSONALIZATION
--------------------------------------------------------------------------------
hl.env("XCURSOR_THEME", "gloomi")
hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_THEME", "gloomi") -- Si tu tema tiene formato hyprcursor
hl.env("HYPRCURSOR_SIZE", "24")
