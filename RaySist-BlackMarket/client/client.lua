local QBCore = exports['qb-core']:GetCoreObject()

local PlayerLoaded = false
local PlayerJob = {}
local npcID = nil

function FloatNotify(PedEnt, entry)
	local uniqueNess = math.random(1,100000)
	Citizen.CreateThread(function()
		local timeInMs = 250
		while true do
			local pedCoords = GetEntityCoords(PedEnt)
			local x2,y2,z2 = table.unpack(pedCoords)
			local finalCoords = vector3(x2,y2,z2+0.9)
			AddTextEntry("RaySist_drugsale:Text"..uniqueNess, entry)
			Wait(1)
			timeInMs = timeInMs-1
			SetFloatingHelpTextWorldPosition(1, finalCoords)
			SetFloatingHelpTextStyle(1, 1, 74, -1, 3, 0)
			BeginTextCommandDisplayHelp("RaySist_drugsale:Text"..uniqueNess)
			EndTextCommandDisplayHelp(2, false, false, -1)
			if timeInMs <= 0 then
				break
			end
		end
	end)
end
function reformatInt(v)
    local s = string.format("%d", math.floor(v))
    local pos = string.len(s) % 3
    if pos == 0 then pos = 3 end
    return string.sub(s, 1, pos)
    .. string.gsub(string.sub(s, pos+1), "(...)", ".%1")
end

AddEventHandler('onResourceStop', function(resourceName)
    if (GetCurrentResourceName() ~= resourceName) then
      return
    end
    exports['qb-target']:RemoveTargetEntity(npcID, Config.Locale[Config.Lang].WhatsInBox)
    DeleteEntity(npcID)
end)

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
	PlayerLoaded = true
end)

CreateThread(function()
    Wait(100)
    local hash = GetHashKey(Config.PedModel)
	RequestModel(hash) while not HasModelLoaded(hash) do  Wait(1) end
    local PedCoords = Config.PedCoords
	local ped = CreatePed(2, hash, PedCoords.x, PedCoords.y, PedCoords.z - 1, PedCoords.w, false, true)
	npcID = ped
	Citizen.Wait(1000)
	SetEntityHeading(ped, PedCoords.w)
	FreezeEntityPosition(ped, true)
	SetEntityInvincible(ped, true)
	SetBlockingOfNonTemporaryEvents(ped, true)
    TaskStartScenarioInPlace(ped,"WORLD_HUMAN_BUM_STANDING",0, false)
    exports['qb-target']:AddTargetEntity(npcID, { 
        options = { 
        { 
            num = 1, 
            type = "client", 
            event = "RaySist_blackMarket:client:1",
            icon = 'fas fa-example', 
            label = Config.Locale[Config.Lang].WhatsInBox, 
            npcPed = ped
        }
        },
        distance = 2.5, 
    })
    Wait(500)
    TriggerServerEvent("RaySist_blackMarket:server:requestConf")
end)


local isConfigLoaded = false

RegisterNetEvent("RaySist_blackMarket:client:Config", function(conf)
    isConfigLoaded = true
    Config.Items = conf
end)

RegisterNetEvent('RaySist_blackMarket:client:1', function()
    local MenuOptions = {}
        if isConfigLoaded then
            for k,v in pairs(Config.Items) do
                print(k)
                local itemData = QBCore.Shared.Items[k:lower()]
                if itemData == nil then
                    itemData = QBCore.Shared.Weapons[k:lower()]
                end
                if v.amount > 0 then
                    table.insert(MenuOptions,{
                        title = itemData.label, 
                        description = v.amount..Config.Locale[Config.Lang].StockPrice..reformatInt(v.price),
                        icon = 'check',
                        event = 'RaySist_blackMarket:client:2',
                        arrow = true,
                            args = {
                                itemData = itemData,
                                itemName = k,
                                itemConf = v
                            }
                        })
                else
                    table.insert(MenuOptions,{
                        title = itemData.label,
                        description = Config.Locale[Config.Lang].OutOfStock,
                        icon = 'xmark',
                        disabled = true
                    })
                end
            end
            FloatNotify(npcID,Config.Locale[Config.Lang].Greetings)
            lib.registerContext({
                id = 'BM_MENU',
                title = Config.Locale[Config.Lang].NPCName,
                options = MenuOptions
            })
            lib.showContext('BM_MENU')
        end
end)
local wepEnt = nil
RegisterNetEvent('RaySist_blackMarket:client:2', function(data)
    local price = data.itemConf.price
    local itemLabel = data.itemData.label
    local alert = lib.alertDialog({
        header = npcID, Config.Locale[Config.Lang].WonnaTrade,
        content = itemLabel..Config.Locale[Config.Lang].Is..reformatInt(price)..Config.Locale[Config.Lang].Currency,
        centered = true,
        cancel = true
    })
            
    if alert ~= "cancel" then
        FloatNotify(npcID,Config.Locale[Config.Lang].FindItForYou)
        ClearPedTasks(npcID)
        Wait(1000)
        SetEntityHeading(npcID,Config.LookH)
        FreezeEntityPosition(npcID, false)
        TaskStartScenarioInPlace(npcID,"PROP_HUMAN_BUM_BIN",0, false)
        Wait(5000)
        ClearPedTasks(npcID)
        Wait(3000)
        TaskTurnPedToFaceEntity(npcID,PlayerPedId(),-1)
        Wait(2000)
        ClearPedTasks(npcID)
        Wait(500)
        FreezeEntityPosition(npcID, true)
        TriggerServerEvent("RaySist_blackMarket:server:try",data.itemName)
    else
        FloatNotify(npcID,Config.Locale[Config.Lang].RejectedBuy)
    end
end)

RegisterNetEvent('RaySist_blackMarket:client:3', function()
    FloatNotify(npcID,Config.Locale[Config.Lang].Greetings1)
    Wait(1000)
    TaskStartScenarioInPlace(ped,"WORLD_HUMAN_BUM_STANDING",0, false)
end)
