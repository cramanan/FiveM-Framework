print("Starting core:spawn...")

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
    WHERE `steam_id` = ?
    LIMIT 1;
    ]], { steam })

    if row then
        deferrals.done()
        return
    end

    local name = GetPlayerName(src)

    local queries = {
        { query = "INSERT INTO `users` VALUES (?, ?);",                   values = { steam, name } },
        { query = "INSERT INTO `banking` VALUES(?, ?, ?);",               values = { steam, BANKING.config.defaultBalanceAmount, BANKING.config.defaultWalletAmount } },
        { query = "INSERT INTO `spawn_record` VALUES(?, ?, ?, ?, ?, ?);", values = { steam, "player_zero", 364.21, -587.48, 28, 0 } }
    }


    if not MySQL.transaction.await(queries) then
        deferrals.done("Couldn't connect you to the server, please contact an administrator.")
        return
    end

    deferrals.done()
end)

lib.callback.register(CORE.events.GET_INFO, function()
    local steam = GetPlayerIdentifierByType(source, "steam")
    local row = MySQL.single.await([[
        SELECT *
        FROM `spawn_record`
        WHERE `steam_id` = ?
        LIMIT 1;
        ]], { steam })

    return row
end)

RegisterNetEvent("core:server:spawn:spawnpoint", function(data)
    if not data or not data.x or not data.y or not data.z then return end
    local src = source
    local steam = GetPlayerIdentifierByType(src, "steam")

    MySQL.update.await([[
    UPDATE `spawn_record`
    SET x = ?, y = ?, z = ?, heading = ?
    WHERE steam_id = ?
    ]], {
        data.x, data.y, data.z, data.heading, steam
    })
end)
