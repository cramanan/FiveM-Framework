print("Starting core:spawn...")


lib.callback.register(CORE.events.GET_INFO, function()
    local steam = GetPlayerIdentifierByType(source, "steam")
    local row = MySQL.scalar.await([[
        SELECT `model`
        FROM `users`
        WHERE `steamid` = ?
        LIMIT 1;
        ]], { steam })

    return row
end)

AddEventHandler("playerConnecting", function(_, _, deferrals)
    local src = source
    local steam = GetPlayerIdentifierByType(src, "steam")

    deferrals.defer()

    if not steam then
        return deferrals.done("You need to launch steam before entering the server.");
    end

    local row = MySQL.single.await([[
    SELECT *
    FROM `users`
    WHERE `steamid` = ?
    LIMIT 1;
    ]], { steam })

    local name = GetPlayerName(src)

    if row then return deferrals.done() end

    local id = MySQL.insert.await('INSERT INTO `users` VALUES (?, ?, DEFAULT);',
        { steam, name })


    if not id then
        return deferrals.done("Couldn't connect you to the server, please contact an administrator.")
    end

    id = MySQL.insert.await("INSERT INTO `banking` VALUES(?, ?, ?);",
        { steam, BANKING.config.defaultBalanceAmount, BANKING.config.defaultWalletAmount })

    if not id then
        return deferrals.done("Couldn't connect you to the server, please contact an administrator.")
    end

    deferrals.done()
end)
