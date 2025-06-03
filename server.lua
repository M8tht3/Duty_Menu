RegisterServerEvent('duty:requestAccess')
AddEventHandler('duty:requestAccess', function()
    local src = source
    if IsPlayerAceAllowed(src, 'leo.access') then
        TriggerClientEvent('duty:openMenu', src)
    else
        TriggerClientEvent('duty:noPermission', src)
    end
end)

RegisterServerEvent('duty:validateDepartment')
AddEventHandler('duty:validateDepartment', function(deptPerm, name, callsign)
    local src = source
    if IsPlayerAceAllowed(src, deptPerm) then
        TriggerClientEvent('duty:confirmed', src, deptPerm, name, callsign)
    else
        TriggerClientEvent('duty:noPermission', src)
    end
end)
