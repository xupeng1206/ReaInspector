local r = reaper
print = r.ShowConsoleMsg
dofile(r.GetResourcePath() .. '/Scripts/Inspector/UIP_util.lua')
dofile(r.GetResourcePath() .. '/Scripts/Inspector/UIP_reaper.lua')
dofile(r.GetResourcePath() .. '/Scripts/Inspector/UIP_color.lua')

dofile(r.GetResourcePath() .. '/Scripts/Inspector/UIP_track_base_control.lua')


local ctx = ImGui.CreateContext('ReaInspector', ImGui.ConfigFlags_DockingEnable())
local G_FONT = ImGui.CreateFont('sans-serif', 15)
ImGui.Attach(ctx, G_FONT)

local FLT_MIN, FLT_MAX = ImGui.NumericLimits_Float()
local ABOUT_IMG

-- content outside padding
local w_padding = 10
local h_padding = 5
-- content w h
local w
local h
-- default space
local w_space = 4
local h_space = 4


local MainSize = {}

local function refreshWindowSize()
    w, h = ImGui.GetWindowSize(ctx)
    w, h = w - w_padding * 2, h - 25
    MainSize["w"] = w
    MainSize["h"] = h
    MainSize["w_padding"] = w_padding
    MainSize["h_padding"] = h_padding
    MainSize["w_space"] = w_space
    MainSize["h_space"] = h_space
end

local function uiMain()
    if ImGui.BeginTabBar(ctx, 'Inspector', ImGui.TabBarFlags_None()) then
        if ImGui.BeginTabItem(ctx, ' Main ') then
            local selected_track_count = r.CountSelectedTracks(0)
            if selected_track_count > 0 then
                local track = r.GetSelectedTrack(0, 0)
                UITrackBaseControl(ctx, MainSize, track)
            end
            ImGui.EndTabItem(ctx)
        end
        if ImGui.BeginTabItem(ctx, 'Wait') then
            -- tab 2
            ImGui.EndTabItem(ctx)
        end
        ImGui.EndTabBar(ctx)
    end
end

local function loop()
    ImGui.PushFont(ctx, G_FONT)
    ImGui.SetNextWindowSize(ctx, 800, 800, ImGui.Cond_FirstUseEver())
    ImGui.PushStyleVar(ctx, ImGui.StyleVar_WindowPadding(), w_padding, h_padding)
    ImGui.PushStyleVar(ctx, ImGui.StyleVar_WindowBorderSize(), 0)
    ImGui.PushStyleColor(ctx, ImGui.Col_WindowBg(), MainBgColor)

    local window_flags = ImGui.WindowFlags_None()
    --   window_flags = window_flags | ImGui.WindowFlags_NoScrollbar()
    --   window_flags = window_flags | ImGui.WindowFlags_NoNav()
    --   window_flags = window_flags | ImGui.WindowFlags_NoDocking()

    local visible, open = ImGui.Begin(ctx, 'ReaInspector', true, window_flags)
    if visible then
        refreshWindowSize()
        uiMain()
        ImGui.End(ctx)
    end
    ImGui.PopFont(ctx)

    if open then
        r.defer(loop)
    end
    ImGui.PopStyleVar(ctx, 2)
    ImGui.PopStyleColor(ctx, 1)
end

local function init()
end

local function startUi()
    init()
    loop()
end

r.defer(startUi)
