function Spawn()
    local spawnInfo = lib.callback.await(CORE.events.GET_INFO)

    if type(spawnInfo) ~= "table" then spawnInfo = {} end

    spawnInfo.model = spawnInfo.model or "player_zero"
    spawnInfo.x = spawnInfo.x or 364.21
    spawnInfo.y = spawnInfo.y or -587.48
    spawnInfo.z = spawnInfo.z or 28


    if not IsModelValid(spawnInfo.model) then spawnInfo.model = "player_zero" end

    exports.spawnmanager:spawnPlayer(spawnInfo)
end

AddEventHandler('onClientMapStart', Spawn)

RegisterKeyMapping("respawn", "Respawn", "KEYBOARD", "R")
RegisterCommand("respawn", function()
    if not IsEntityDead(PlayerPedId()) then return end
    Spawn()
end, false)

CreateThread(function()
    local ped = PlayerId()
    SetPedMaxTimeUnderwater(ped, 50)

    NetworkSetFriendlyFireOption(true)
    SetCanAttackFriendly(ped, true, true)
    SetHudComponentSize(1, 0, 0)  -- Disable Wanted stars
    SetHudComponentSize(20, 0, 0) -- Disable WEAPON_WHEEL_STATS
    SetHudComponentSize(13, 0, 0) -- Disable Cash change

    while true do
        Wait(1000)

        CancelAllPoliceReports()
        RestorePlayerStamina(ped, 1.0) --infinite stamina
    end
end)

RegisterCommand("tp", function(_, args)
    local x, y, z = tonumber(args[1]), tonumber(args[2]), tonumber(args[3])
    if not x or not y or not z then return print("Invalid coords") end
    local ped = PlayerPedId()
    SetEntityCoords(ped, x, y, z, true, false, false, false)
end)

RegisterCommand("spawnpoint", function(_, args)
    local ped = PlayerPedId()
    TriggerServerEvent("core:server:spawn:spawnpoint", GetEntityCoords(ped))
end)

AddEventHandler("playerSpawned", function()
    local playerPed = PlayerPedId()
    SetPedDefaultComponentVariation(playerPed)
end)
