local laws = false

local opening = false
local c_red = Color(156, 8, 30, 200)
local closing = false

local function showLaws()
    
    local W, H = ScrW(), ScrH()

    local currentLaws = DarkRP.getLaws()

    local size = table.Count(currentLaws)

    if table.Count(currentLaws) >= 5 then
        size = 5
    end
	if IsValid(laws) and laws != false and laws != true then laws:Remove() end
    laws = vgui.Create("DFrame")

    laws.Think = function()
        currentLaws = DarkRP.getLaws()

        size = table.Count(currentLaws)

        if table.Count(currentLaws) >= 5 then
            size = 5
        end

        if opening == false then
            laws:SetSize(W / 3.75, 10 + (20 * size))
        end
    end

    laws:SetSize(W / 3.75, 10 + (20 * size))
    laws:SetPos(0 - laws:GetWide(), 32)
    laws:SetTitle("")

    laws.Paint = function(self, w, h)
        if gui.IsGameUIVisible() then return end

        draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 200))

        draw.RoundedBox(0, 0, 0, w, 2, c_red)
        draw.SimpleText("Laws OF THE LAND", "Trebuchet18", 2, 9, Color(255, 255, 255), 0, 1)
        draw.RoundedBox(0, 0, 16, w, 2, c_red)

        for k, v in pairs(currentLaws) do
            if k > size then continue end

            draw.SimpleText(k .. ". " .. v, "Trebuchet18", 5, 10 + (k * 17), Color(255, 255, 255), 0, 1)
        end
    end

    laws:ShowCloseButton(false)
    laws:SetDraggable(false)

    opening = true

    laws:MoveTo(2, 32, 0.5, 0, -1, function()
        opening = false
    end)
end

-- local function hideLaws()
--     if input.IsKeyDown(KEY_F1) then
--         if opening or closing then return end

--         if !laws then
--             surface.PlaySound("UI/buttonclick.wav")

--             showLaws()
--         else
--             surface.PlaySound("UI/buttonclick.wav")

--             closing = true

--             laws:MoveTo(0 - laws:GetWide(), 32, 0.5, 0, -1, function()
--                 closing = false

--                 laws:Remove()
--                 laws = false
--             end)
--         end
--     end
-- end
-- hook.Add("Think", "hideLaws", hideLaws)


--[[/////////////////////////////////////
Name: yc_laws_toggle
Function: Network received to hide/show the laws hud
Input: network parameters
Output: /
Data: /
--/////////////////////////////////////]]
net.Receive("yc_laws_toggle", function(len, ply)
	showLaws()
end)