function Wasted()
    StartScreenEffect("DeathFailOut", 0, false)
    PlaySoundFrontend(-1, "Bed", "WastedSounds", true)
    PlaySoundFrontend(-1, "ScreenFlash", "WastedSounds", true)

    DisplayRadar(false)
    ShakeGameplayCam("DEATH_FAIL_IN_EFFECT_SHAKE", 1.0)

    CreateThread(function()
        local scaleform = RequestScaleformMovie("MP_BIG_MESSAGE_FREEMODE")


        while not HasScaleformMovieLoaded(scaleform) do Wait(0) end

        BeginScaleformMovieMethod(scaleform, "SHOW_SHARD_WASTED_MP_MESSAGE") -- The function you want to call from the AS file
        PushScaleformMovieMethodParameterString("~r~Wasted")                 -- big text
        EndScaleformMovieMethod()                                            -- Finish off the scaleform, it returns no data, so doesn't need "EndScaleformMovieMethodReturn"

        Wait(2000)
        PlaySoundFrontend(-1, "TextHit", "WastedSounds", true)
        while IsEntityDead(PlayerPedId()) do
            Wait(0)
            DrawScaleformMovieFullscreen(scaleform, 255, 255, 255, 255, 0)
        end
    end)


    CreateThread(function()
        -- Request the buttons GFX to be loaded
        -- Note: RequestScaleformMovieInstance prevents the buttons being stretched on wide-screen
        local ButtonsHandle = RequestScaleformMovieInstance('INSTRUCTIONAL_BUTTONS')

        -- Wait for the buttons GFX to be fully loaded
        while not HasScaleformMovieLoaded(ButtonsHandle) do
            Wait(0)
        end

        -- Clear previous buttons
        CallScaleformMovieMethod(ButtonsHandle, 'CLEAR_ALL')

        -- ENABLE mouse buttons
        CallScaleformMovieMethodWithNumber(ButtonsHandle, 'TOGGLE_MOUSE_BUTTONS', 1, 0, 0, 0, 0)

        -- Begin setting a button slot
        BeginScaleformMovieMethod(ButtonsHandle, 'SET_DATA_SLOT')

        -- Position of the button
        ScaleformMovieMethodAddParamInt(0)

        -- Add the Enter keyboard icon
        ScaleformMovieMethodAddParamPlayerNameString('~INPUT_8544B5A7~') -- respawn command

        -- Add the text before icon
        ScaleformMovieMethodAddParamPlayerNameString('Respawn')

        -- Note: Adding last 2 SET_DATA_SLOT parameters while TOGGLE_MOUSE_BUTTONS
        -- is disabled can cause buttons to bug out

        -- Whether or not this button can be clicked by the mouse
        ScaleformMovieMethodAddParamBool(true)

        -- Which control will be triggered when this button is clicked by the mouse (INPUT_FRONTEND_ACCEPT in this case)
        ScaleformMovieMethodAddParamInt(201)

        -- End the function
        EndScaleformMovieMethod()

        -- Sets buttons ready to be drawn
        CallScaleformMovieMethod(ButtonsHandle, 'DRAW_INSTRUCTIONAL_BUTTONS')

        -- Display instructional buttons while enter hasn't been pressed
        while IsEntityDead(PlayerPedId()) do
            Wait(0)
            -- Draw the instructional buttons this frame
            DrawScaleformMovieFullscreen(ButtonsHandle, 255, 255, 255, 255, 1)
        end

        -- Disable mouse buttons so they don't bug out for other scripts
        CallScaleformMovieMethod(ButtonsHandle, 'TOGGLE_MOUSE_BUTTONS', 0)

        -- Unload the scaleform movie after enter has been pressed
        SetScaleformMovieAsNoLongerNeeded(ButtonsHandle)
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
