Config = Config or {}

-- Spawn Locations Configuration
Config.SpawnLocations = {
    {
        id = 1,
        name = 'Police Station',
        description = 'LSPD Downtown Precinct',
        coords = vector3(425.4, -979.5, 29.4),
        heading = 180.0,
        jobs = {'police'},
        allowedRanks = {1, 2, 3, 4, 5},
    },
    {
        id = 2,
        name = 'Fire Station',
        description = 'SAFD Downtown Station',
        coords = vector3(212.8, -934.0, 24.1),
        heading = 70.0,
        jobs = {'firefighter'},
        allowedRanks = {1, 2, 3, 4},
    },
    {
        id = 3,
        name = 'Pillbox Hospital',
        description = 'Pillbox Medical Center',
        coords = vector3(309.5, -599.9, 43.3),
        heading = 340.0,
        jobs = {'medic', 'doctor'},
        allowedRanks = {1, 2, 3},
    },
    {
        id = 4,
        name = 'City Hall',
        description = 'Government Building',
        coords = vector3(-565.3, -931.5, 29.3),
        heading = 0.0,
        jobs = {'government'},
        allowedRanks = {1, 2, 3, 4},
    },
    {
        id = 5,
        name = 'Airport',
        description = 'Los Santos International Airport',
        coords = vector3(-1033.8, -2732.6, 20.2),
        heading = 270.0,
        jobs = {'taxi', 'pilot'},
        allowedRanks = {1, 2, 3},
    },
}

-- General Settings
Config.EnableSpawner = true
Config.EnableDatabase = true
Config.SpawnAnimation = true
Config.AnimationDuration = 5000

-- UI Settings
Config.UIScale = 1.0
Config.UIDebug = false

-- Job System Integration
Config.UseJobSystem = true
Config.DefaultSpawnLocation = 1

-- Admin Commands
Config.AdminCommand = 'spawner'
Config.AdminPermission = 'admin'

-- Civilian Spawns
Config.CivilianSpawns = {
    vector3(0.0, 0.0, 71.0),
    vector3(198.0, -882.0, 24.3),
    vector3(-563.0, -931.0, 29.3),
}

-- Logging
Config.EnableLogging = true
Config.LogSpawns = true
