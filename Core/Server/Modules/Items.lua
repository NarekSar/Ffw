Items = {}

function Items.register(params)
    if not Items[params.name] then
        Items[params.name] = {}
        Items[params.name].name = params.name
        Items[params.name].label = params.label
        Items[params.name].inLtd = params.inLtd or false
        Items[params.name].ltdPrice = params.ltdPrice or nil
        Items[params.name].weight = params.weight or 0.01
        if params.usage then
            Items[params.name].usage = params.usage
        end
    end
end

Items.register({
    name = "ntm",
    label = "Ntm",
    weight = 0.1,
    inLtd = false,
    ltdPrice = 30,
    usage = function()
        print(" Ntm ")
    end,
})

function Items.use(name)
    if Items[name].usage then
        Items[name].usage()
    end
end