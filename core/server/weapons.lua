print("Starting core:weapon...")

lib.callback.register(WEAPON.events.GET_INFO, function()
    local steam = GetPlayerIdentifierByType(source, "steam")
    local weapons = MySQL.query.await([[
    SELECT `weapon`
    FROM `weapons_record`
    WHERE `steamid` = ?
    ]], { steam })

    if not weapons then return nil end

    local retData = {}

    for key, value in ipairs(weapons) do
        if value.weapon then retData[key] = value.weapon end
    end

    return retData
end)
