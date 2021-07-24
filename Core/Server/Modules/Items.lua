Items = {}
ItemsAdded = {}

Citizen.CreateThread( function()
    MySQL.Async.fetchAll('SELECT * FROM items', {
    }, function(result)
        for _,v in pairs(result) do
            if not Items[v.name] then
                ItemsAdded[v.name] = {}
                ItemsAdded[v.name].Name = v.name
                ItemsAdded[v.name].Label = v.label
                ItemsAdded[v.name].Type = v.type
                ItemsAdded[v.name].Limite = v.limite
                ItemsAdded[v.name].inLtd = v.inLtd or false
                ItemsAdded[v.name].Price = v.price or nil
                print(string.format("L'item %s à était initialisé avec succés", v.label))
            end
        end
    end)
end)

function Items.register(params)
    if not ItemsAdded[params.Name] then
        ItemsAdded[params.Name] = {}
        ItemsAdded[params.Name].Name = params.Name
        ItemsAdded[params.Name].Label = params.Label
        ItemsAdded[params.Name].Type = params.Type
        ItemsAdded[params.Name].Limite = params.Limite
        ItemsAdded[params.Name].inLtd = params.inLtd or false
        ItemsAdded[params.Name].Price = params.Price or nil
        if params.usage then
            ItemsAdded[params.Name].usage = params.usage
        end
        print(string.format("L'item %s à était créer avec succés", params.Label))
    end
end

function Items.usable(name, handler)
    if handler then
        ItemsAdded[name].usage = handler
    end
end

function Items.use(name)
    if ItemsAdded[name].usage then
        ItemsAdded[name].usage()
    end
end