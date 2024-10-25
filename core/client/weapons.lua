local AMMUNITIONS <const> = {
    { x = 811.960, y = -2147.843, z = 29.5290 },
}

CreateThread(function()
    for _, item in pairs(AMMUNITIONS) do
        item.blip = AddBlipForCoord(item.x, item.y, item.z)
        SetBlipSprite(item.blip, 110)
        SetBlipAsShortRange(item.blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString("Ammu-Nation")
        EndTextCommandSetBlipName(item.blip)
    end

    -- Trying to avoid looping with SetHudComponentSize. Comment/Remove to display
    SetHudComponentSize(14, 0, 0) -- Reticule

    SetWeaponsNoAutoreload(true)
    SetWeaponsNoAutoswap(true)
end)



AddEventHandler("playerSpawned", function()
    local weapons = lib.callback.await(WEAPON.events.GET_INFO)

    if not weapons then return end

    local ped = PlayerPedId()

    for _, value in pairs(weapons) do
        GiveWeaponToPed(ped, value, 9999, false, false)
    end

    -- SetPedComponentVariation(ped, 9, 2, 0, 0)
    -- SetPedArmour(ped, 100)
end)
