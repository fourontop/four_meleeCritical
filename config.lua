Config = {}

-- ====================================
-- Emo Knockdown System
-- ====================================

Config.Emo2 = true

Config.EmoDistance = 5.0 -- distance to apply emo damage

-- weapon = damage to subtract when knockdown triggers
Config.Emo = {
    ["WEAPON_BOTTLE"] = 15,
    ["WEAPON_KNIFE"] = 20,
}

-- ====================================
-- Critical Hit Reduction System
-- ====================================

Config.Distance = 5.0 -- distance to check attacker weapon

Config.Critical = {
    {
        weaponname = "WEAPON_POOLCUE",
        percent = 15 -- 25% chance to allow critical hit
    },
    {
        weaponname = "WEAPON_BAT",
        percent = 15
    }
}
