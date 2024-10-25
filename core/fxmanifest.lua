fx_version "cerulean"
game "gta5"
lua54 "yes"

author "ClaWz"


client_script "client/**/*.lua"

server_script "server/**/*.lua"

shared_script {
    "shared.lua",
    "@ox_lib/init.lua",
    "@oxmysql/lib/MySQL.lua",
}
