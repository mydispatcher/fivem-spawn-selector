Utils = Utils or {}

function Utils.GetDistance(coords1, coords2)
    return #(coords1 - coords2)
end

function Utils.Notify(title, message, type)
    type = type or 'info'
    TriggerEvent('chat:addMessage', {
        color = {255, 0, 0},
        multiline = true,
        args = {title, message}
    })
end

function Utils.HasJob(jobName)
    if GetResourceState('es_extended') == 'started' then
        local xPlayer = ESX.GetPlayerFromId(source)
        return xPlayer.job.name == jobName
    end
    return false
end

function Utils.IsAdmin(playerId)
    return IsPlayerAceAllowed(playerId, 'command')
end

function Utils.Log(message, type)
    type = type or 'info'
    print(('^[%s] %s^7'):format(type:upper(), message))
end

function Utils.GetPlayerCoords()
    return GetEntityCoords(PlayerPedId())
end

function Utils.LoadAnimDict(dict)
    RequestAnimDict(dict)
    local timeout = 0
    while not HasAnimDictLoaded(dict) and timeout < 100 do
        Wait(10)
        timeout = timeout + 1
    end
    return HasAnimDictLoaded(dict)
end
