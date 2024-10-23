local function toggleNuiFrame(shouldShow)
  SetNuiFocus(shouldShow, shouldShow)
  SendReactMessage('setVisible', shouldShow)
end

RegisterCommand('show-nui', function()
  if IsPauseMenuActive() then return end

  toggleNuiFrame(true)
  debugPrint('Show NUI frame')
end)
RegisterKeyMapping("show-nui", "Open Menu", "KEYBOARD", "M")

RegisterNUICallback('hideFrame', function(_, cb)
  toggleNuiFrame(false)
  debugPrint('Hide NUI frame')
  cb({})
end)

RegisterNUICallback('get-client-data', function(_, cb)
  local banking = lib.callback.await(BANKING.events.BANK_GET_INFO)
  local coords = GetEntityCoords(PlayerPedId())

  local retData <const> = { x = coords.x, y = coords.y, z = coords.z, wallet = banking.wallet, balance = banking.balance }

  cb(retData)
end)
