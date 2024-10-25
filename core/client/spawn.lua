function Spawn()
    local model = lib.callback.await(CORE.events.GET_INFO) or "player_zero"

    if not IsModelValid(model) then model = "player_zero" end

    local spawnPos = vector3(364.21, -587.48, 28)
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
