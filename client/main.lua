local QBCore = exports['qb-core']:GetCoreObject()
local PlayerData = {}
local blackmarketPed = nil

-- Functions
local function LoadModel(model)
    RequestModel(model)
    while not HasModelLoaded(model) do
        Wait(0)
    end
end

local function LoadAnimDict(dict)
    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        Wait(0)
    end
end

local function CreateBlackmarketPed()
    local pedInfo = Config.BlackmarketPed
    LoadModel(pedInfo.model)

    blackmarketPed = CreatePed(4, pedInfo.model, pedInfo.coords.x, pedInfo.coords.y, pedInfo.coords.z - 1.0, pedInfo.coords.w, false, true)

    SetEntityHeading(blackmarketPed, pedInfo.coords.w)
    FreezeEntityPosition(blackmarketPed, true)
    SetEntityInvincible(blackmarketPed, true)
    SetBlockingOfNonTemporaryEvents(blackmarketPed, true)

    if pedInfo.scenario then
        TaskStartScenarioInPlace(blackmarketPed, pedInfo.scenario, 0, true)
    end

    if Config.UseTarget then
        exports['qb-target']:AddTargetEntity(blackmarketPed, {
            options = {
                {
                    type = "client",
                    event = "RaySist-BlackmarketV2:client:openMenu",
                    icon = "fas fa-shopping-bag",
                    label = Lang:t("info.blackmarket"),
                }
            },
            distance = 2.0
        })
    end

    if pedInfo.blip.enabled then
        local blip = AddBlipForCoord(pedInfo.coords.x, pedInfo.coords.y, pedInfo.coords.z)
        SetBlipSprite(blip, pedInfo.blip.sprite)
        SetBlipDisplay(blip, 4)
        SetBlipScale(blip, pedInfo.blip.scale)
        SetBlipColour(blip, pedInfo.blip.color)
        SetBlipAsShortRange(blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(pedInfo.blip.label)
        EndTextCommandSetBlipName(blip)
    end
end

local function OpenBlackmarketMenu()
    SendNUIMessage({
        action = "open",
        items = Config.BlackmarketItems
    })

    SetNuiFocus(true, true)
end

-- Events
RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    PlayerData = QBCore.Functions.GetPlayerData()
    CreateBlackmarketPed()
end)

RegisterNetEvent('QBCore:Client:OnPlayerUnload', function()
    PlayerData = {}
    if DoesEntityExist(blackmarketPed) then
        DeleteEntity(blackmarketPed)
    end
end)

RegisterNetEvent('RaySist-BlackmarketV2:client:openMenu', function()
    OpenBlackmarketMenu()
end)

-- NUI Callbacks
RegisterNUICallback('close', function(_, cb)
    SetNuiFocus(false, false)
    cb('ok')
end)

RegisterNUICallback('buyItem', function(data, cb)
    QBCore.Functions.TriggerCallback('RaySist-BlackmarketV2:server:buyItem', function(success, message)
        cb({
            success = success,
            message = message
        })
    end, data.category, data.itemIndex)
end)

-- Threads
CreateThread(function()
    if not Config.UseTarget then
        while true do
            local sleep = 1000
            local pos = GetEntityCoords(PlayerPedId())
            local pedCoords = Config.BlackmarketPed.coords
            local dist = #(pos - vector3(pedCoords.x, pedCoords.y, pedCoords.z))

            if dist < 5.0 then
                sleep = 0
                DrawMarker(2, pedCoords.x, pedCoords.y, pedCoords.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.2, 210, 50, 9, 255, false, false, false, true, false, false, false)

                if dist < 2.0 then
                    sleep = 0
                    DrawText3Ds(pedCoords.x, pedCoords.y, pedCoords.z + 1.0, Lang:t("info.press_to_open"))

                    if IsControlJustReleased(0, Config.InteractKey) then
                        OpenBlackmarketMenu()
                    end
                end
            end

            Wait(sleep)
        end
    end
end)

-- Helper function for 3D text
function DrawText3Ds(x, y, z, text)
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x, y, z, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 370
    DrawRect(0.0, 0.0+0.0125, 0.017+ factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end

-- Initialize
CreateThread(function()
    if LocalPlayer.state.isLoggedIn then
        PlayerData = QBCore.Functions.GetPlayerData()
        CreateBlackmarketPed()
    end
end)
