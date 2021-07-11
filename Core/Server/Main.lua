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
    MySQL.Async.fetchAll('SELECT * FROM players WHERE identifier = @identifier', {
		['@identifier'] = identifier
	}, function(result)
        if result[1] then
            data = result[1]
            data.account = json.decode(data.account)
            MySQL.Async.fetchAll('SELECT * FROM players_inv WHERE identifier = @identifier', {
                ['@identifier'] = identifier
            }, function(inventory)
                DataInv = inventory
                local myData = Player.new(src, data, DataInv)
                PlyData[src] = myData
                TriggerClientEvent("Ffw:InitPlayer", src)
            end)
        else
            MySQL.Async.execute('INSERT INTO players (identifier, account) VALUES (@identifier, @account)', {
                ['@identifier'] = identifier,
                ['@account'] = json.encode(CoreSett.baseAccount)
            }, function()
                for _,v in pairs(ItemsList) do
                    MySQL.Async.execute('INSERT INTO players_inv (identifier, item_label, item_name, item_count) VALUES (@identifier, @item_label, @item_name, @item_count)', {
                        ['@identifier'] = identifier,
                        ['@item_label'] = v.item_label,
                        ['@item_name'] = v.item_name,
                        ['@item_count'] = 0
                    }, function()
                    end)
                    MySQL.Async.fetchAll('SELECT * FROM players_inv WHERE identifier = @identifier', {
                        ['@identifier'] = identifier
                    }, function(inventory)
                        data.id = src
                        data.identifier = identifier
                        data.group = "user"
                        data.vip = false
                        data.account = CoreSett.baseAccount
                        DataInv = inventory
                    end)
                end
                Wait(150)
                local myData = Player.new(src, data, DataInv)
                PlyData[src] = myData
                TriggerClientEvent("Ffw:InitPlayer", src)
            end)
        end
    end)
end)

Citizen.CreateThread( function()
    Wait(5000)
    local Player = getData(1)
    print(Player:getAccount("money"))
    Player:addMoney(1500)
    print(Player:getAccount("money"))
end)