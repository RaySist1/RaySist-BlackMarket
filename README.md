# RaySist-BlackMarket
QBCore BlackMarket Script

#features
OX_LIB
https://github.com/overextended/ox_lib
QB-CORE & QB-TARGET

#showcase
https://youtu.be/aav7QIiSBHQ?feature=shared

#info
Make it gang only

add this to config.lua
NoGang = "You need to be in a gang!",

add this to client/client.lua
Line 88
if QBCore.Functions.GetPlayerData().gang.name ~= "none" then
and this on line 127
FloatNotify(npcID,Config.Locale[Config.Lang].NoGang)
