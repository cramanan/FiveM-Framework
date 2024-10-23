-- Shows a notification on the player's screen
function ShowNotification(text)
    SetNotificationTextEntry("STRING")
    AddTextComponentSubstringPlayerName(text)
    DrawNotification(false, false)
end

RegisterCommand('car', function(_, args)
    local vehicleName = args[1]
    if not vehicleName then
        ShowNotification("Please enter a vehicle name")
        return
    end

    if not IsModelInCdimage(vehicleName) or not IsModelAVehicle(vehicleName) then
        ShowNotification(vehicleName .. " is not a vehicle")
        return
    end

    RequestModel(vehicleName)

    while not HasModelLoaded(vehicleName) do
        Wait(10)
    end

    local player = PlayerPedId()
    local pos = GetEntityCoords(player)
    local heading = GetEntityHeading(player)
    local vehicle = CreateVehicle(vehicleName, pos.x, pos.y, pos.z, heading, true, false)

    SetVehicleRadioEnabled(vehicle, false)
    SetPedIntoVehicle(player, vehicle, -1)
    SetModelAsNoLongerNeeded(vehicle)
end, false)
