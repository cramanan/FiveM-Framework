function Spawn()
    local model = lib.callback.await("framework:core:get_info") or "player_zero"

    if not IsModelValid(model) then model = "player_zero" end

    local spawnPos = vector3(-1156.4609585958594, -3152.3402340234015, 13)
    exports.spawnmanager:spawnPlayer({
        x = spawnPos.x,
        y = spawnPos.y,
        z = spawnPos.z,
        model = model
    })
end

AddEventHandler('onClientMapStart', Spawn)

RegisterKeyMapping("respawn", "Respawn", "KEYBOARD", "R")
RegisterCommand("respawn", function()
    local ped = PlayerPedId()
    if not IsEntityDead(ped) then return end
    Spawn()
end)

CreateThread(function()
    local ped = PlayerId()
    SetPedMaxTimeUnderwater(ped, 50)

    NetworkSetFriendlyFireOption(true)
    SetCanAttackFriendly(ped, true, true)


    while true do
        Wait(1000)

        CancelAllPoliceReports()
        RestorePlayerStamina(ped, 1.0) --infinite stamina
    end
end)

RegisterCommand("tp", function(_, args)
    local x, y, z = tonumber(args[1]), tonumber(args[2]), tonumber(args[3])
    if not x or not y or not z then
        return print("invalid coordinates")
    end

    local ped = PlayerPedId()
    SetEntityCoords(ped, x, y, z, false, false, false, false)
end)
