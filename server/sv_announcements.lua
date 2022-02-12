local ESX = exports["es_extended"]:getSharedObject()

if not ESX then
	SetTimeout(3000, function() print('[^3WARNING^7] Unable to start '..GetCurrentResourceName()..' - server ESX object not found') end)
else
    -- Start of the config.
	local Config = {
		Command = 'ptwt', -- You can change the command here.
		MinJobGrade = 1, -- You can change the minimium job grade allowed to send the messages.
		EnablePhone = false -- change to true if you want have phone required to send announcements.
	}
    -- End of the config.
	RegisterCommand(Config.Command, function(source, args, rawCommand)
		local xPlayer = ESX.GetPlayerFromId(source)
		local text    = nil
		if (xPlayer.job.name == 'police' and xPlayer.job.grade >= Config.MinJobGrade) then
			text = 'Police'
		elseif (xPlayer.job.name == 'ambulance' and xPlayer.job.grade >= Config.MinJobGrade) then
			text = 'EMS'
		elseif (xPlayer.job.name == 'mecano' and xPlayer.job.grade >= Config.MinJobGrade or xPlayer.job.name == 'mechanic' and xPlayer.job.grade >= Config.MinJobGrade) then
			text = 'Mechanic'
		elseif (xPlayer.job.name == 'taxi' and xPlayer.job.grade >= Config.MinJobGrade) then
			text = 'Taxi'
		end
		if (Config.EnablePhone) then
			if (xPlayer.getInventoryItem('phone').count >= 1) then
				if (text) then
					TriggerClientEvent('chat:addMessage', -1, {
						template = '<div style="padding: 0.5vw; margin: 0.5vw; background: -webkit-linear-gradient(right, transparent 15%, rgba(5, 5, 5, 0.4) 85%); border-radius: 7px;"><i class="fa fa-user"></i> {0}:  {1}</div>',
						args = {"["..text.."]", table.concat(args, " ")}
					})
				end
			end
		else
			if (text) then
				TriggerClientEvent('chat:addMessage', -1, {
					template = '<div style="padding: 0.5vw; margin: 0.5vw; background: -webkit-linear-gradient(right, transparent 15%, rgba(5, 5, 5, 0.4) 85%); border-radius: 7px;"><i class="fa fa-user"></i> {0}:  {1}</div>',
					args = {"["..text.."]", table.concat(args, " ")}
				})
			end
		end
	end)
end
