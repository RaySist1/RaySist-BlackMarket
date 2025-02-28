local QBCore = exports['qb-core']:GetCoreObject()

-- Callbacks
QBCore.Functions.CreateCallback('RaySist-BlackmarketV2:server:buyItem', function(source, cb, category, itemIndex)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)

    if not Player then return cb(false, Lang:t('error.something_went_wrong')) end

    local items = Config.BlackmarketItems[category]
    if not items or not items[itemIndex + 1] then
        return cb(false, Lang:t('error.something_went_wrong'))
    end

    local item = items[itemIndex + 1]

    -- Check if player has enough money
    if Player.PlayerData.money['cash'] < item.price then
        return cb(false, Lang:t('error.not_enough_money'))
    end

    -- Check if player has enough space in inventory
    local canCarry = Player.Functions.AddItem(item.name, item.amount)
    if not canCarry then
        return cb(false, Lang:t('error.inventory_full'))
    end

    -- Remove money and add item
    Player.Functions.RemoveMoney('cash', item.price)
    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[item.name], 'add')

    cb(true, Lang:t('success.item_purchased', {item = item.label, price = item.price}))
end)
