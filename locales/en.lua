local Translations = {
    error = {
        not_enough_money = "You don't have enough money",
        inventory_full = "Your inventory is full",
        something_went_wrong = "Something went wrong",
    },
    success = {
        item_purchased = "You purchased %{item} for $%{price}",
    },
    info = {
        blackmarket_dealer = "Blackmarket Dealer",
        press_to_open = "Press [E] to access the blackmarket",
        blackmarket = "Open catalog",
    },
    menu = {
        close = "Close",
        weapons = "Weapons",
        ammo = "Ammunition",
        attachments = "Attachments",
        misc = "Miscellaneous",
        buy = "Buy",
        price = "Price: $%{price}",
    }
}

Lang = Lang or Locale:new({
    phrases = Translations,
    warnOnMissing = true
})
