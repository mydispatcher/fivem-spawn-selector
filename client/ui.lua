local UIOpen = false

function SendToNUI(data)
    SendNUIMessage(data)
end

function ToggleUI(state)
    UIOpen = state
    SetNuiFocus(state, state)
    SendToNUI({type = 'setVisible', visible = state})
end

RegisterNUICallback('notifyClient', function(data, cb)
    Utils.Notify(data.title or 'Notification', data.message or '', data.type or 'info')
    cb('ok')
end)

RegisterNUICallback('debugLog', function(data, cb)
    if Config.UIDebug then
        print('^3[UI Debug]^7: ' .. (data.message or 'No message'))
    end
    cb('ok')
end)

AddEventHandler('onClientResourceStart', function(resource)
    if resource == GetCurrentResourceName() then
        RegisterKeyMapping('openspawner', 'Open Spawn Selector', 'keyboard', 'E')
    end
end)

RegisterCommand('openspawner', function()
    if not UIOpen then
        TriggerServerEvent('spawn:getAvailableSpawns')
    else
        ToggleUI(false)
    end
end, false)

print('^2[Spawn Selector]^7 UI module loaded!')
