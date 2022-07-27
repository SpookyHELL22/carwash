ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('spooky_carwash:pay')
AddEventHandler('spooky_carwash:pay', function()

	local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

	xPlayer.removeMoney(Config.Price)

	TriggerClientEvent('esx:showNotification', source, 'Ennyit fizettél: ' .. '~g~$' .. Config.Price)

end)

ESX.RegisterServerCallback('spooky_carwash:checkMoney', function(source, cb)


	local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

	if xPlayer.get('money') >= Config.Price then
		cb(true)
	else
		cb(false)
	end


	
end)