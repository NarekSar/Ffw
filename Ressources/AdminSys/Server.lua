RegisterServerEvent("Ffw:openAdminMain")
AddEventHandler("Ffw:openAdminMain", function()
    local myPlayer = Players(source)
    if myPlayer.group ~= "user" then
        myPlayer:triggerClient("Ffw:openAdminMain")
    end
end)

RegisterServerEvent("Ffw:saveNewItem")
AddEventHandler("Ffw:saveNewItem", function(item)
    local myPlayer = Players(source)
    if myPlayer.group ~= "user" then
        local canSave = false
        if not item.inLtd then
            item.Price = nil
        end
        MySQL.Async.fetchScalar('SELECT label FROM items WHERE name = @name', {
            ['@name'] = item.Name
        }, function(result)
            if result then
                canSave = false
                print(string.format("L'item %s existe déjà", item.Label))
            else
                saveNewItem(myPlayer.id, item)
            end
        end)
    end
end)

function saveNewItem(source, item)
    local myPlayer = Players(source)
    MySQL.Async.execute('INSERT INTO items (label, name, limite, inLtd, price, type) VALUES (@label, @name, @limite, @inLtd, @price, @type)', {
        ['@label'] = item.Label,
        ['@name'] = item.Name,
        ['@type'] = item.Type,
        ['@limite'] = item.Limite,
        ['@inLtd'] = item.inLtd,
        ['@price'] = item.Price
    }, function()
        myPlayer:triggerClient("Ffw:resetItemBuilder")
        Items.register(item)
    end)
end
