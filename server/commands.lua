TriggerEvent('chat:addSuggestion', '/' .. Config.AdminCommand, 'Open spawn selector', {
    { name = 'action', help = 'Action: open, list, tp' },
    { name = 'args', help = 'Additional arguments' }
})

RegisterCommand(Config.AdminCommand, function(source, args, rawCommand)
    local playerId = source
    
    if not Utils.IsAdmin(playerId) then
        TriggerClientEvent('chat:addMessage', playerId, {
            color = {255, 0, 0},
            multiline = true,
            args = {'ERROR', 'You do not have permission to use this command.'}
        })
        return
    end
    
    local action = args[1] or 'open'
    
    if action == 'open' then
        TriggerClientEvent('spawn:openUI', playerId)
    elseif action == 'list' then
        TriggerClientEvent('chat:addMessage', playerId, {
            color = {0, 255, 0},
            multiline = true,
            args = {'SPAWNER', 'Available spawn locations:'}
        })
        for _, spawn in ipairs(Config.SpawnLocations) do
            TriggerClientEvent('chat:addMessage', playerId, {
                color = {255, 255, 0},
                multiline = true,
                args = {'', ('ID: %d | %s - %s'):format(spawn.id, spawn.name, spawn.description)}
            })
        end
    elseif action == 'tp' then
        local spawnId = tonumber(args[2])
        if spawnId then
            TriggerEvent('spawn:requestSpawn', spawnId)
        end
    end
end, false)

print('^2[Spawn Selector]^7 Commands registered!')
