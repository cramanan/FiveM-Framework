function Wasted()
    StartScreenEffect("DeathFailOut", 0, false)
    PlaySoundFrontend(-1, "Bed", "WastedSounds", true)
    PlaySoundFrontend(-1, "ScreenFlash", "WastedSounds", true)

    DisplayRadar(false)
    ShakeGameplayCam("DEATH_FAIL_IN_EFFECT_SHAKE", 1.0)

    CreateThread(function()
        local scaleform = RequestScaleformMovie("MP_BIG_MESSAGE_FREEMODE")

        while not HasScaleformMovieLoaded(scaleform) do
            Wait(0)
        end
        PushScaleformMovieFunction(scaleform, "SHOW_SHARD_WASTED_MP_MESSAGE")
        BeginTextComponent("STRING")
        AddTextComponentString("~r~wasted")
        EndTextComponent()
        PopScaleformMovieFunctionVoid()


        Wait(2500)
        PlaySoundFrontend(-1, "TextHit", "WastedSounds", true)
        while IsEntityDead(PlayerPedId()) do
            Wait(0)
            DrawScaleformMovieFullscreen(scaleform, 255, 255, 255, 255, 0)
        end
    end)

    while IsEntityDead(PlayerPedId()) do
        Wait(0)
    end
    DisplayRadar(true)
    StopScreenEffect("DeathFailOut")
end

AddEventHandler("baseevents:onPlayerKilled", Wasted)
AddEventHandler("baseevents:onPlayerDied", Wasted)

RegisterCommand("kill", function() SetEntityHealth(PlayerPedId(), 0) end, false)
RegisterKeyMapping("kill", "Suicide", "KEYBOARD", "K")
