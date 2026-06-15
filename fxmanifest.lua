fx_version 'cerulean'
game 'gta5'

author 'Your Name'
description 'Custom FiveM Spawn Selector'
version '1.0.0'

ui_page 'web/index.html'

shared_scripts {
    'shared/config.lua',
    'shared/utils.lua'
}

server_scripts {
    'server/main.lua',
    'server/database.lua',
    'server/commands.lua'
}

client_scripts {
    'client/main.lua',
    'client/ui.lua',
    'client/spawning.lua'
}

files {
    'web/index.html',
    'web/style.css',
    'web/script.js'
}

dependencies {
    '/server:5104',
    '/onesync'
}
