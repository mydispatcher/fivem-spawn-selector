local Database = Database or {}

function Database.Initialize()
    if GetResourceState('mysql-async') == 'started' then
        MySQL.Async.execute('CREATE TABLE IF NOT EXISTS player_spawns (
            id INT AUTO_INCREMENT PRIMARY KEY,
            player_id INT NOT NULL,
            spawn_id INT NOT NULL,
            spawn_location VARCHAR(100),
            timestamp DATETIME DEFAULT CURRENT_TIMESTAMP,
            INDEX(player_id)
        )')
    end
end

function Database.SaveSpawn(playerId, spawnId, spawnName)
    if GetResourceState('mysql-async') == 'started' then
        MySQL.Async.execute('INSERT INTO player_spawns (player_id, spawn_id, spawn_location) VALUES (?, ?, ?)',
            {playerId, spawnId, spawnName})
    end
end

function Database.GetSpawnHistory(playerId, limit)
    limit = limit or 10
    if GetResourceState('mysql-async') == 'started' then
        return MySQL.Sync.fetchAll('SELECT * FROM player_spawns WHERE player_id = ? ORDER BY timestamp DESC LIMIT ?',
            {playerId, limit})
    end
    return {}
end

AddEventHandler('database:initialize', function()
    Database.Initialize()
end)

print('^2[Spawn Selector]^7 Database module loaded!')
