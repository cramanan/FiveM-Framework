print("Starting core:banking...")


lib.callback.register(BANKING.events.GET_INFO, function()
    local steam = GetPlayerIdentifierByType(source, "steam")
    local row = MySQL.single.await([[
    SELECT `balance`, `wallet`
    FROM `banking`
    WHERE `steamid` = ? LIMIT 1
    ]], { steam })

    return row
end)
