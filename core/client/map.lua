CreateThread(function()
    local blips = {}

    while true do
        Wait(100)
        for _, player in pairs(GetActivePlayers()) do
            if player ~= PlayerId() and NetworkIsPlayerActive(player) then
                local playerPed = GetPlayerPed(player)
                RemoveBlip(blips[player])
                local new_blip = AddBlipForEntity(playerPed)
                SetBlipNameToPlayerName(new_blip, player)
                SetBlipColour(new_blip, 0)
                SetBlipCategory(new_blip, 0)
                SetBlipScale(new_blip, 0.85)
                blips[player] = new_blip
            end
        end
    end
end)
