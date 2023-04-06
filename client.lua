ESX = nil
local PlayerData = {}

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
        PlayerData = ESX.GetPlayerData()
	end
end)


Citizen.CreateThread(function()
    Citizen.Wait(3000)
    for k, v in ipairs(Config.Coords) do
        print(k)
        v.blip = AddBlipForCoord(v.x, v.y, v.z)
        SetBlipColour(v.blip, 1)
        SetBlipSprite(v.blip, 100)
        SetBlipDisplay(v.blip, 4)
        SetBlipScale(v.blip, 0.8)
        SetBlipAsShortRange(v.blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString('Carwash')
        EndTextCommandSetBlipName(v.blip)
    end
    for k, v in ipairs(Config.Coords) do
        print(k)
        local player = GetPlayerPed(-1)
        local megy = false
        Citizen.CreateThread(function()
            while true do
                Citizen.Wait(0)
                local coords = GetEntityCoords(player)
                local distance = GetDistanceBetweenCoords(coords.x, coords.y, coords.z, v.x, v.y, v.z, false)
                if distance <= 10.0 and IsPedInAnyVehicle(player, false) then
                 DrawMarker(1, v.x, v.y, v.z-0.5, 0, 0, 0, 0, 0, 0, 3.0, 3.0, 0.2, 255, 255, 255, 255, false, false, 2.0, false)
               
                 if distance <= 3.0 and IsPedInAnyVehicle(player, false) then
                     ESX.ShowHelpNotification('Nyomj ~INPUT_CONTEXT~-t a jármü mosásához!')
                     
                     if distance <= 7.0 and IsPedInAnyVehicle(player, false) and IsControlJustPressed(0, 51) and megy == false then
                        ESX.TriggerServerCallback('spooky_carwash:checkMoney', function(hasEnoughMoney)
                        if hasEnoughMoney then
                             megy = true
                             local vehicle = GetVehiclePedIsIn(player, false)
                             FreezeEntityPosition(vehicle, true)
                             TriggerServerEvent('spooky_carwash:pay')
     
                             Citizen.Wait(3000)
                             SetVehicleDirtLevel(vehicle, 0)
                             FreezeEntityPosition(vehicle, false)
                             ESX.ShowNotification('Megmostad az autód!')
                             megy = false
                         else
                             ESX.ShowNotification('~r~Nincs elég pénzed')
                         end
     
                     end)
                
                 end
               end
     
            end
        end
    
    end)
end
end)
