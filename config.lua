Config = {}

-- General Settings
Config.Debug = false
Config.UseTarget = true -- Use qb-target interaction (recommended)
Config.InteractKey = 38 -- E key for non-target interaction

-- Blackmarket Ped Settings
Config.BlackmarketPed = {
    model = "g_m_m_armboss_01", -- Ped model
    coords = vector4(971.48, -2156.81, 29.48, 200.93), -- Default location in warehouse interior
    scenario = "WORLD_HUMAN_CLIPBOARD", -- Ped animation
    blip = {
        enabled = false, -- No blip for blackmarket (it's secret!)
        sprite = 500,
        color = 1,
        scale = 0.7,
        label = "Blackmarket"
    }
}

-- Blackmarket Items
Config.BlackmarketItems = {
    weapons = {
        {
            name = "weapon_pistol",
            label = "Pistol",
            price = 999,
            amount = 1,
            info = {},
            type = "item",
            slot = 1,
            image = "weapon_pistol.png"
        },
        {
            name = "weapon_pistol50",
            label = "Pistol50",
            price = 999,
            amount = 1,
            info = {},
            type = "item",
            slot = 1,
            image = "weapon_pistol50.png"
        },
        {
            name = "weapon_pistolxm3",
            label = "Pistol XM3",
            price = 999,
            amount = 1,
            info = {},
            type = "item",
            slot = 1,
            image = "weapon_pistolxm3.png"
        },
        {
            name = "weapon_machinepistol",
            label = "Machine Pistol",
            price = 999,
            amount = 1,
            info = {},
            type = "item",
            slot = 1,
            image = "weapon_machinepistol.png"
        },
        {
            name = "weapon_minismg",
            label = "Mini SMG",
            price = 999,
            amount = 1,
            info = {},
            type = "item",
            slot = 1,
            image = "weapon_minismg.png"
        },
        {
            name = "weapon_compactrifle",
            label = "Compact Rifle",
            price = 999,
            amount = 1,
            info = {},
            type = "item",
            slot = 1,
            image = "weapon_compactrifle.png"
        },
        {
            name = "weapon_assaultrifle",
            label = "Assault Rifle",
            price = 999,
            amount = 1,
            info = {},
            type = "item",
            slot = 1,
            image = "weapon_assaultrifle.png"
        },
    },
    ammo = {
        {
            name = "pistol_ammo",
            label = "Pistol Ammo (x10)",
            price = 500,
            amount = 10,
            info = {},
            type = "item",
            slot = 1,
            image = "pistol_ammo.png"
        },
        {
            name = "smg_ammo",
            label = "SMG Ammo (x10)",
            price = 750,
            amount = 10,
            info = {},
            type = "item",
            slot = 2,
            image = "smg_ammo.png"
        },
        {
            name = "rifle_ammo",
            label = "Rifle Ammo (x10)",
            price = 1000,
            amount = 10,
            info = {},
            type = "item",
            slot = 3,
            image = "rifle_ammo.png"
        },
        {
            name = "shotgun_ammo",
            label = "Shotgun Ammo (x10)",
            price = 1000,
            amount = 10,
            info = {},
            type = "item",
            slot = 3,
            image = "shotgun_ammo.png"
        },
    },
    attachments = {
        {
            name = "pistol_suppressor",
            label = "Pistol Suppressor",
            price = 8000,
            amount = 1,
            info = {},
            type = "item",
            slot = 1,
            image = "pistol_suppressor.png"
        },
        {
            name = "pistol_extendedclip",
            label = "Pistol Extended Mag",
            price = 8000,
            amount = 1,
            info = {},
            type = "item",
            slot = 1,
            image = "pistol_extendedclip.png"
        },
        {
            name = "smg_scope",
            label = "SMG Scope",
            price = 12000,
            amount = 1,
            info = {},
            type = "item",
            slot = 2,
            image = "smg_scope.png"
        },
    },
    misc = {
        {
            name = "armor",
            label = "Body Armor",
            price = 5000,
            amount = 1,
            info = {},
            type = "item",
            slot = 1,
            image = "armor.png"
        },
        {
            name = "lockpick",
            label = "Lockpick",
            price = 1000,
            amount = 1,
            info = {},
            type = "item",
            slot = 2,
            image = "lockpick.png"
        },
        {
            name = "advancedlockpick",
            label = "Advanced Lockpick",
            price = 3500,
            amount = 1,
            info = {},
            type = "item",
            slot = 3,
            image = "advancedlockpick.png"
        },
    }
}
