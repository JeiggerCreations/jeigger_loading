
local restartTime = 0

RegisterNetEvent("underworld:setRestartTime", function(serverTime)
    restartTime = serverTime * 1000
end)

Citizen.CreateThread(function()
    TriggerServerEvent("underworld:getRestartTime")

    while true do
        Citizen.Wait(1000)
        local now = GetGameTimer() + GetNetworkTime()
        local remaining = restartTime - now

        if restartTime > 0 and remaining > 0 then
            local hrs = math.floor(remaining / (1000 * 60 * 60))
            local mins = math.floor((remaining % (1000 * 60 * 60)) / (1000 * 60))
            local secs = math.floor((remaining % (1000 * 60)) / 1000)

            SendNUIMessage({
                type = "restartCountdown",
                hrs = hrs,
                mins = mins,
                secs = secs
            })
        end
    end
end)

-- Still send player count
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000)
        local players = #GetActivePlayers()
        SendNUIMessage({
            type = "playerCount",
            count = players
        })
    end
end)
