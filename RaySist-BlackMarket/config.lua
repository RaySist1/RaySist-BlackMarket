Config = {}
Config.Locale = {}

-- restockTimer is hours. 1 = 1 hour 
Config.Items = {
    ["WEAPON_COMBATPISTOL"] = {amount = 8, price = 5499, restockTimer = 1},
    ["WEAPON_COMPACTRIFLE"] = {amount = 8, price = 9999, restockTimer = 1},
}
Config.Lang = "EN"

Config.PedModel = "g_m_y_lost_01"
Config.PedCoords = vector4(1092.07, -2226.28, 31.3, 326.43)
Config.SoundCoords = vector3(-172.92, 6144.49, 42.64)
Config.CrateModel = "gr_prop_gr_crate_pistol_02a"
Config.CratePos = vector3(1091.38, -2223.54, 30.3)
Config.LookH = 207.34


Config.Locale["DK"] = {
    Boughta = "Du har købt en ",
    For = " for ",
    Currency = " DKK",
    NotEnoughSpace = "Du har ikke plads...",
    NotEnoughCash = "Du har ikke nok kontanter...",
    Busy = "En af gangen...",


    WhatsInBox = "Hva har du?",
    StockPrice = " på lager.\n\n Pris: ",
    OutOfStock = "Jeg har ikke flere lige nu..",
    Greetings = "Se her",
    Greetings1 = "Ses",
    NPCName = "Kresten Pikhår",
    WonnaTrade = "Vil du handle?",
    Is = " koster ",
    FindItForYou = "Jeg fisker den lige op.",
    RejectedBuy = "Smut med dig, Københavner!",
}

Config.Locale["EN"] = {
    Boughta = "You have bought a ",
    For = " for ",
    Currency = " $",
    NotEnoughSpace = "You don't have enough space...",
    NotEnoughCash = "You need some money...",
    Busy = "Chill, one at a time...",


    WhatsInBox = "What you got?",
    StockPrice = " in storage.\n\n Price: ",
    OutOfStock = "Im out of stock..",
    Greetings = "Take a look",
    Greetings1 = "See ya",
    NPCName = "P. Enis",
    WonnaTrade = "Wanna buy some?",
    Is = " is ",
    FindItForYou = "I'll get it for you.",
    RejectedBuy = "Well well well!",
}

