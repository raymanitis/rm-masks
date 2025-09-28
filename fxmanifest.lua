fx_version 'cerulean'
game 'gta5'
lua54 'yes'

author 'RM-SCRIPTS'
description 'Masks for peds'
version '1.0.0'

shared_script '@ox_lib/init.lua'
server_script {
    'server.lua'
}

client_script {
    'client.lua'
}

files {
    'config.lua'
}