local isUIOpen = false
local currentSpawn = nil
local playerJob = nil

AddEventHandler('onClientResourceStart', function(resource)
    if resource == GetCurrentResourceName() then
        Utils.Log('Spawn Selector Client Started', 'success')
        TriggerServerEvent('spawn:getPlayerData')
        TriggerServerEvent('spawn:getAvailableSpawns')
    end
end)

RegisterNetEvent('spawn:openUI')
AddEventHandler('spawn:openUI', function()
    TriggerServerEvent('spawn:getAvailableSpawns')
end)

RegisterNetEvent('spawn:displayAvailableSpawns')
AddEventHandler('spawn:displayAvailableSpawns', function(spawns)
    SendNUIMessage({
        type = 'openSpawner',
        spawns = spawns
    })
    isUIOpen = true
    SetNuiFocus(true, true)
end)

RegisterNetEvent('spawn:playerDataReceived')
AddEventHandler('spawn:playerDataReceived', function(data)
    SendNUIMessage({
        type = 'playerData',
        data = data
    })
end)

RegisterNUICallback('closeUI', function(data, cb)
    isUIOpen = false
    SetNuiFocus(false, false)
    cb('ok')
end)

RegisterNUICallback('spawnPlayer', function(data, cb)
    local spawnId = data.spawnId
    
    if spawnId then
        TriggerServerEvent('spawn:requestSpawn', spawnId)
        isUIOpen = false
        SetNuiFocus(false, false)
    end
    
    cb('ok')
end)

RegisterNetEvent('spawn:doSpawn')
AddEventHandler('spawn:doSpawn', function(spawn)
    TriggerEvent('spawning:startSpawn', spawn)
end)

function IsSpawnerOpen()
    return isUIOpen
end

print('^2[Spawn Selector]^7 Client main loaded!')
