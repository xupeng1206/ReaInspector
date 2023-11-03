local r = reaper
print = r.ShowConsoleMsg
dofile(r.GetResourcePath() .. '/Scripts/ReaInspector/UIP_color.lua')
dofile(r.GetResourcePath() .. '/Scripts/ReaInspector/UIP_reaper.lua')


function UIReadOnlyColorBtn(ctx, text, color, w)
    ImGui.PushStyleColor(ctx, ImGui.Col_Button(), color)
    ImGui.PushStyleColor(ctx, ImGui.Col_ButtonHovered(), color)
    ImGui.PushStyleColor(ctx, ImGui.Col_ButtonActive(), color)
    ImGui.Button(ctx, text, w)
    ImGui.PopStyleColor(ctx, 3)
end

function UIColorBtn(ctx, text, color, ww, hh)
    ImGui.PushStyleColor(ctx, ImGui.Col_Button(), color)
    ImGui.PushStyleColor(ctx, ImGui.Col_ButtonHovered(), ColorBtnHover)
    ImGui.PushStyleColor(ctx, ImGui.Col_ButtonActive(), ColorBlue)
    local ret = ImGui.Button(ctx, text, ww, hh)
    ImGui.PopStyleColor(ctx, 3)
    return ret
end
