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

    if row then
        deferrals.done()
        return
    end

    local name = GetPlayerName(src)

    local queries = {
        { query = "INSERT INTO `users` VALUES (?, ?, DEFAULT);", values = { steam, name } },
        { query = "INSERT INTO `banking` VALUES(?, ?, ?);",      values = { steam, BANKING.config.defaultBalanceAmount, BANKING.config.defaultWalletAmount } },
    }


    if not MySQL.transaction.await(queries) then
        deferrals.done("Couldn't connect you to the server, please contact an administrator.")
        return
    end

    deferrals.done()
end)
