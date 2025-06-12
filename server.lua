
local restartHours = {0, 6, 12, 18} -- Midnight, 6AM, Noon, 6PM

local function getRestartTimestamp()
    local now = os.time()
    local nowTable = os.date("*t", now)

    for _, hour in ipairs(restartHours) do
        local restartCandidate = os.time({
            year = nowTable.year,
            month = nowTable.month,
            day = nowTable.day,
            hour = hour,
            min = 0,
            sec = 0
        })

        if restartCandidate > now then
            return restartCandidate
        end
    end

    -- If no restart time left today, pick the first one tomorrow
    local nextDay = os.time({
        year = nowTable.year,
        month = nowTable.month,
        day = nowTable.day + 1,
        hour = restartHours[1],
        min = 0,
        sec = 0
    })

    return nextDay
end

RegisterNetEvent("underworld:getRestartTime", function()
    local src = source
    local restartTimestamp = getRestartTimestamp()
    TriggerClientEvent("underworld:setRestartTime", src, restartTimestamp)
end)
