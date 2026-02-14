local QBCore = exports['qb-core']:GetCoreObject()

-- ====================================
-- MAIN THREAD
-- ====================================

CreateThread(function()
    while true do
        Wait(0) -- frame-based (important for crit accuracy)

        local ped = PlayerPedId()
        local closestPlayer, closestDistance = QBCore.Functions.GetClosestPlayer()

        -- ====================================
        -- CRITICAL SYSTEM
        -- ====================================

        local allowCritical = true

        if closestPlayer ~= -1 and closestDistance <= Config.Distance then
            local attackerPed = GetPlayerPed(closestPlayer)
            local attackerWeapon = GetSelectedPedWeapon(attackerPed)

            for _, v in pairs(Config.Critical) do
                if attackerWeapon == GetHashKey(v.weaponname) then
                    local rnd = math.random(1, 100)

                    if rnd > v.percent then
                        allowCritical = false
                    end

                    break
                end
            end
        end

        SetPedSuffersCriticalHits(ped, allowCritical)

        -- ====================================
        -- EMO DAMAGE SYSTEM
        -- ====================================

        if Config.Emo2 then
            if GetPedConfigFlag(ped, 70, false) or GetPedConfigFlag(ped, 69, false) then

                if closestPlayer ~= -1 and closestDistance <= Config.EmoDistance then
                    local attackerPed = GetPlayerPed(closestPlayer)
                    local attackerWeapon = GetSelectedPedWeapon(attackerPed)

                    for weaponName, damage in pairs(Config.Emo) do
                        if attackerWeapon == GetHashKey(weaponName) then

                            -- Apply damage
                            SetEntityHealth(ped, GetEntityHealth(ped) - damage)

                            -- Force ragdoll
                            ClearPedTasksImmediately(ped)
                            SetPedToRagdoll(ped, 3000, 3000, 0, 0, 0, 0)

                            -- Reset flags
                            SetPedConfigFlag(ped, 70, false)
                            SetPedConfigFlag(ped, 69, false)

                            break
                        end
                    end
                end
            end
        end
    end
end)
