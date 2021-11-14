ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

-- Start of the config.
local command = 'ptwt' -- You can change the command here.
local minjobgrade = 1 -- You can change the minimium job grade allowed to send the messages.
local enablephone = false -- change to true if you want have phone required to send announcements.
-- End of the config.

TriggerEvent('es:addCommand', command, function(source, args, user)
    local xPlayer = ESX.GetPlayerFromId(source)
    local text    = nil -- Don't touch this.
    --
    if (xPlayer.job.name == 'police' and xPlayer.job.grade >= minjobgrade) then
        text = 'Police'
    elseif (xPlayer.job.name == 'ambulance' and xPlayer.job.grade >= minjobgrade) then
        text = 'EMS'
    elseif (xPlayer.job.name == 'mecano' and xPlayer.job.grade >= minjobgrade or xPlayer.job.name == 'mechanic' and xPlayer.job.grade >= minjobgrade) then
        text = 'Mechanic'
    elseif (xPlayer.job.name == 'taxi' and xPlayer.job.grade >= minjobgrade) then
        text = 'Taxi'
    end
    if (enablephone) then
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
