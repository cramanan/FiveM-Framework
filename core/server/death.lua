print("Starting core:death...")

RegisterNetEvent("baseevents:onPlayerDied")
AddEventHandler("baseevents:onPlayerDied", function()
    TriggerClientEvent("core:client:onPlayerDied", -1, string.format("~bold~%s~bold~ died", GetPlayerName(source)))
end)
