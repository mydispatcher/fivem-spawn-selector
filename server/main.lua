local activeSpawns = {}
local playerData = {}

AddEventHandler('onServerResourceStart', function(resource)
    if resource == GetCurrentResourceName() then
        Utils.Log('Spawn Selector Started', 'success')
        if Config.EnableDatabase then
            TriggerEvent('database:initialize')
        end
    end
end)

AddEventHandler('playerConnecting', function()
    local playerId = source
    playerData[playerId] = {
        lastSpawn = nil,
        spawnCount = 0,
        createdAt = os.time()
    }
end)

AddEventHandler('playerDropped', function()
    local playerId = source
    playerData[playerId] = nil
end)

RegisterNetEvent('spawn:getAvailableSpawns')
AddEventHandler('spawn:getAvailableSpawns', function()
    local playerId = source
    local availableSpawns = {}
    
    for _, spawn in ipairs(Config.SpawnLocations) do
        if not Config.UseJobSystem then
            table.insert(availableSpawns, spawn)
        else
            table.insert(availableSpawns, spawn)
        end
    end
    
    TriggerClientEvent('spawn:displayAvailableSpawns', playerId, availableSpawns)
end)

RegisterNetEvent('spawn:requestSpawn')
AddEventHandler('spawn:requestSpawn', function(spawnId)
    local playerId = source
    local spawn = nil
    
    for _, s in ipairs(Config.SpawnLocations) do
        if s.id == spawnId then
            spawn = s
            break
        end
    end
    
    if spawn then
        playerData[playerId].lastSpawn = spawnId
        playerData[playerId].spawnCount = playerData[playerId].spawnCount + 1
        
        if Config.LogSpawns then
            Utils.Log(('Player %s spawned at location: %s'):format(playerId, spawn.name), 'info')
        end
        
        TriggerClientEvent('spawn:doSpawn', playerId, spawn)
    else
        Utils.Notify('Error', 'Spawn location not found')
    end
end)

RegisterNetEvent('spawn:getPlayerData')
AddEventHandler('spawn:getPlayerData', function()
    local playerId = source
    TriggerClientEvent('spawn:playerDataReceived', playerId, playerData[playerId])
end)

print('^2[Spawn Selector]^7 Server scripts loaded!')
