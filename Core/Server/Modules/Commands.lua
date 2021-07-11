Commands = {}

function Commands.create(commandName, restric, handler)
    if restric then
        return
    end
    RegisterCommand(commandName, function(source, args, rawCommand)
        handler(source)
    end, false)
end

Commands.create("getCoords", nil, function(source)
    local src = source
    local coords = GetEntityCoords(GetPlayerPed(src))
    local head = GetEntityHeading(GetPlayerPed(src))
    local res = vector4(coords.x, coords.y, coords.z, head)
    print(res)
end)