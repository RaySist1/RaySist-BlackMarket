fx_version 'cerulean'
game 'gta5'

author 'RaySist'
description 'BlackmarketV2 - A modern blackmarket script for QBCore'
version '1.0.0'

shared_scripts {
    '@qb-core/shared/locale.lua',
    'locales/en.lua',
    'config.lua'
}

client_scripts {
    'client/main.lua',
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server/main.lua'
}

ui_page 'html/index.html'

files {
    'html/index.html',
    'html/styles.css',
    'html/script.js',
    'html/assets/*.png'
}

lua54 'yes'
