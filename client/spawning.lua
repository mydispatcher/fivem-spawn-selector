local isSpawning = false

RegisterNetEvent('spawning:startSpawn')
AddEventHandler('spawning:startSpawn', function(spawn)
    if isSpawning then return end
    
    isSpawning = true
    
    local playerPed = PlayerPedId()
    local spawnCoords = spawn.coords
    local spawnHeading = spawn.heading or 0.0
    
    if Config.SpawnAnimation then
        DoSpawnAnimation(playerPed)
    end
    
    Wait(Config.AnimationDuration or 5000)
    
    local model = GetHashKey('a_m_m_business_1')
    RequestModel(model)
    while not HasModelLoaded(model) do
        Wait(10)
    end
    
    SetEntityCoords(playerPed, spawnCoords.x, spawnCoords.y, spawnCoords.z, false, false, false, false)
    SetEntityHeading(playerPed, spawnHeading)
    
    isSpawning = false
    
    Utils.Notify('Spawn', 'You have spawned at ' .. spawn.name, 'success')
end)

function DoSpawnAnimation(ped)
    if Utils.LoadAnimDict('combat@damage@rb_writhe') then
        TaskPlayAnim(ped, 'combat@damage@rb_writhe', 'rb_writhe_loop', 8.0, -8.0, -1, 1, 0, false, false, false)
    end
end

RegisterCommand('cancelspawn', function()
    if isSpawning then
        isSpawning = false
        ClearPedTasks(PlayerPedId())
        Utils.Notify('Spawn', 'Spawn cancelled', 'info')
    end
end, false)

print('^2[Spawn Selector]^7 Spawning module loaded!')
