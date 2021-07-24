RegisterServerEvent("Ffw:InitPlayer")
AddEventHandler("Ffw:InitPlayer", function()
    local src = source
    local data = {}
    local identifier = nil
    for k,v in ipairs(GetPlayerIdentifiers(src)) do
		if string.match(v, 'license:') then
			identifier = string.sub(v, 9)
			break
		end
	end
    data.identifier = identifier
    MySQL.Async.fetchAll('SELECT * FROM players WHERE identifier = @identifier', {
		['@identifier'] = identifier
	}, function(result)
        if result[1] then
            local res = result[1]
            data.group = res.group
            data.vip = res.vip
            data.coords = json.decode(res.coords)
            
            data.account = json.decode(res.account)
            if res.jobName then data.jobName = res.jobName end
            if res.jobGrade then data.jobGrade = res.jobGrade end
            if res.inventory then
                data.inventory = json.decode(res.inventory)
            end
            local myData = Player.new(src, data)
            PlyData[src] = myData
            TriggerClientEvent("Ffw:InitPlayer", src, PlyData[src], ItemsAdded)
        else
            MySQL.Async.execute('INSERT INTO players (identifier, account) VALUES (@identifier, @account)', {
                ['@identifier'] = identifier,
                ['@account'] = json.encode(CoreSett.baseAccount)
            }, function()
                data.id = src
                data.group = "user"
                data.vip = false
                data.jobName = "unemployed"
                data.jobGrade = 0
                data.account = CoreSett.baseAccount
                data.inventory = {}
                data.coords = nil
                local myData = Player.new(src, data)
                PlyData[src] = myData
                TriggerClientEvent("Ffw:InitPlayer", src, PlyData[src], ItemsAdded)
            end)
        end
    end)
end)

RegisterNetEvent('Ffw:SavePlayerCoords')
AddEventHandler('Ffw:SavePlayerCoords', function(pos, heading)
    local myPlayer = Players(source)
    myPlayer:saveCoords({x = pos.x, y = pos.y, z = pos.z, h = heading})
end)

AddEventHandler('playerDropped', function()
    local myPlayer = Players(source)
    if CoreSett.useOneSync then
        local xCoords = myPlayer:getCoords()
        myPlayer:saveCoords(xCoords)
    end
end)