local r = reaper
print = r.ShowConsoleMsg

dofile(r.GetResourcePath() .. '/Scripts/ReaInspector/UIP_util.lua')
dofile(r.GetResourcePath() .. '/Scripts/ReaInspector/UIP_reaper.lua')
dofile(r.GetResourcePath() .. '/Scripts/ReaInspector/UIP_color.lua')
dofile(r.GetResourcePath() .. '/Scripts/ReaInspector/UIP_ui.lua')

function UITrackBaseControl(ctx, size, track)
    if ImGui.CollapsingHeader(ctx, 'Base Control') then
        local space = size['w_space']
        local w = size['w'] - space

        local volume = r.GetMediaTrackInfo_Value(track, "D_VOL")
        local minInf = (volume == 0)
        if minInf then
            if UIColorBtn(ctx, "-INF", ColorRed, 45, 0) then
                minInf = false
                volume = DB2Vol(0)
                r.SetMediaTrackInfo_Value(track, "D_VOL", volume)
            end
        else
            if UIColorBtn(ctx, "-INF", ColorNormal, 45, 0) then
                minInf = true
                volume = 0
                r.SetMediaTrackInfo_Value(track, "D_VOL", volume)
            end
        end
        ImGui.SameLine(ctx)
        r.ImGui_SetNextItemWidth(ctx, w - 45 - space * 1 )
        local rv, newVol = ImGui.SliderDouble(ctx, '##Volume', Vol2dB(volume), -48.0, 12.0, 'VOL = %.2fdB')
        if rv then
            r.SetMediaTrackInfo_Value(track, "D_VOL", DB2Vol(newVol))
        end

        ImGui.SliderInt(ctx, '##Pan', 0, -100, 100, 'Pan = %.f')
    end
end
