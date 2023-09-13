### QBCore BlackMarket Script

You need this [OX_LIB](https://github.com/overextended/ox_lib) QB-CORE & QB-TARGET

[Showcase](https://youtu.be/aav7QIiSBHQ?feature=shared)

### Make it gang only
add this to config.lua `NoGang = "You need to be in a gang!",`

add this to client/client.lua Line 88 `if QBCore.Functions.GetPlayerData().gang.name ~= "none" then`

and this on line 127 `FloatNotify(npcID,Config.Locale[Config.Lang].NoGang)`****

For support join my discord https://discord.gg/J3ve7vmHgh
