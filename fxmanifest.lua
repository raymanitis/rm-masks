fx_version 'cerulean'
game 'gta5'
lua54 'yes'
use_experimental_fxv2_oal "yes"

author 'RM-SCRIPTS'
description 'Masks for peds'
version '1.0.0'

shared_scripts {
    '@ox_lib/init.lua',
    'config.lua',
}

client_scripts {
    'client.lua',
}

client_script 'client.lua'

