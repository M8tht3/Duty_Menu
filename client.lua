local isOnDuty = false

RegisterCommand('duty', function()
    if isOnDuty then
        lib.notify({
            id = 'duty_error',
            title = 'Already On Duty',
            description = 'You are already on duty. Use /clockoff or /clockout to finish.',
            showDuration = false,
            position = 'top',
            style = {
                backgroundColor = '#141517',
                color = '#C1C2C5',
                ['.description'] = {
                    color = '#909296'
                }
            },
            icon = 'ban',
            iconColor = '#FF5555'
        })
        return
    end
    TriggerServerEvent('duty:requestAccess')
end)

RegisterNetEvent('duty:openMenu', function()
    local deptInput = lib.inputDialog('Department Selection', {
        {
            type = 'select',
            label = 'Department',
            options = {
                { label = 'LSPD', value = 'lspd.duty' },
                { label = 'LAPD', value = 'lapd.duty' },
                { label = 'Department of Homeland Security', value = 'dhs.duty' },
                { label = 'SAHP', value = 'sahp.duty' }
            },
            required = true,
            description = 'Choose your department'
        }
    })

    if not deptInput then
        lib.notify({
            title = 'Duty System',
            description = 'You must select a department!',
            type = 'error'
        })
        return
    end

    local selectedPerm = deptInput[1]

    local infoInput = lib.inputDialog('Enter Duty Info', {
        { type = 'input', label = 'Your Name', placeholder = 'e.g. Jack B.', required = true },
        { type = 'input', label = 'Callsign', placeholder = 'e.g. 1A-01', required = true }
    })

    if not infoInput or infoInput[1] == '' or infoInput[2] == '' then
        lib.notify({
            title = 'Duty System',
            description = 'You must fill in both name and callsign!',
            type = 'error'
        })
        return
    end

    local name = infoInput[1]
    local callsign = infoInput[2]

    TriggerServerEvent('duty:validateDepartment', selectedPerm, name, callsign)
end)

RegisterNetEvent('duty:noPermission', function()
    lib.notify({
        title = 'Permission Denied',
        description = 'You don’t have permission to go on duty with that department!',
        type = 'error'
    })
end)

RegisterNetEvent('duty:confirmed', function(department, name, callsign)
    isOnDuty = true
    lib.notify({
        id = 'duty_success',
        title = 'On Duty',
        description = ('You are now on duty with **%s** as %s (%s).'):format(department:upper(), name, callsign),
        showDuration = false,
        position = 'top',
        style = {
            backgroundColor = '#141517',
            color = '#C1C2C5',
            ['.description'] = {
                color = '#90EE90'
            }
        },
        icon = 'shield-check',
        iconColor = '#00FF00'
    })
end)

RegisterCommand('clockoff', function()
    if not isOnDuty then
        lib.notify({
            id = 'clockoff_error',
            title = 'Not On Duty',
            description = 'You are not currently on duty.',
            showDuration = false,
            position = 'top',
            style = {
                backgroundColor = '#141517',
                color = '#C1C2C5',
                ['.description'] = {
                    color = '#909296'
                }
            },
            icon = 'ban',
            iconColor = '#FF5555'
        })
        return
    end

    isOnDuty = false
    lib.notify({
        id = 'clockoff_done',
        title = 'Clocked Off',
        description = 'You are now off duty.',
        showDuration = false,
        position = 'top',
        style = {
            backgroundColor = '#141517',
            color = '#C1C2C5',
            ['.description'] = {
                color = '#00CED1'
            }
        },
        icon = 'alarm-clock-off',
        iconColor = '#00CED1'
    })
end)

RegisterCommand('clockout', function()
    if not isOnDuty then
        lib.notify({
            id = 'clockout_error',
            title = 'Not On Duty',
            description = 'You are not currently on duty.',
            showDuration = false,
            position = 'top',
            style = {
                backgroundColor = '#141517',
                color = '#C1C2C5',
                ['.description'] = {
                    color = '#909296'
                }
            },
            icon = 'ban',
            iconColor = '#FF5555'
        })
        return
    end

    isOnDuty = false
    lib.notify({
        id = 'clockout_done',
        title = 'Clocked Out',
        description = 'You are now off duty.',
        showDuration = false,
        position = 'top',
        style = {
            backgroundColor = '#141517',
            color = '#C1C2C5',
            ['.description'] = {
                color = '#00CED1'
            }
        },
        icon = 'log-out',
        iconColor = '#00CED1'
    })
end)
