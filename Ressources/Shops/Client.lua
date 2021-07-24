Citizen.CreateThread( function()
    Wait(500)
    local Shopz = {}
    for _,v in pairs (ShopsPos) do
        Shopz[_] = Zones.create({
            ped = Peds.create("mp_m_shopkeep_01", v.pos, false),
            blip = Blips.create(v.Blip),
            marker = Markers.create({type = 2, radius = 15.0, pos = vector3(v.pos.x, v.pos.y, v.pos.z + 1.18), width = 0.3, height = 0.3, colour = {r = 0, g = 245, b = 245, a = 185}, blowUp = true, faceCam = true, inversed = true}),
            pos = v.pos,
            radius = 2.0,
            inputText = "Appuyer sur E pour discuter.",
            methode = function()
                Keys.onPress("e", function()
                    ShopsMenu.open(v.menuType)
                end)
            end,
        })
    end
end)

ShopsMenu = {
    onMenu = true,
    crtType = "food",
    crtIndex = 1,

    Title = {
        ["ltd"] = "Supèrette",
    },
}

ShopsMenu.main = RageUI.CreateMenu(" ", " ")

function ShopsMenu.open(type)
    ShopsMenu.onMenu = true
    ShopsMenu.main.Title = ShopsMenu.Title[type]
    RageUI.Visible(ShopsMenu.main, true)

    while ShopsMenu.onMenu do
        Wait(0)

        RageUI.IsVisible(ShopsMenu.main, function()
            ShopsMenu[type]()
        end)
    end
end

LTDItem = {
    {name = 'bread', label = 'Pain', price = 50, type = 'food'},
    {name = 'water', label = 'Bouteille d\'eau', price = 50, type = 'drink'},
    {name = 'parapluie', label = 'Parapluie', price = 50, type = 'other'}
}

function OpenMenuLtd()
    local menu = RageUI.CreateMenu("Superette", "Bienvenue dans notre magasin")

    RageUI.Visible(menu, not RageUI.Visible(menu))

    local Action = {
        'Nourritures',
        'Boissons',
        'Autres',
    }

    local Count = {}
    local IndexItem = {}

    local IndexList = 1

    for i = 1, 20 do
        Count[i] = i
    end

    for k,v in pairs(LTDItem) do 
        IndexItem[v.name] = 1
    end

    local itemName = nil
    local item = nil
    local price = nil

    while menu do
        Wait(0)
        RageUI.IsVisible(menu, function()
            RageUI.Separator('↓ ~g~Prix de vos articles~w~ ↓')
            RageUI.Separator('x'..(IndexItem[itemName] or 0) .. ' '..(item or 'Aucun') .. ' pour :  ~g~'.. (price or '0$'))
            RageUI.List('Filtre(s) :', Action, IndexList, nil, {}, true, {
                onListChange = function(Index, Item)
                    IndexList = Index;
                end,
            })
            RageUI.Separator('↓ ~g~Articles Disponibles ~w~↓')
            for k,v in pairs(LTDItem) do
                if IndexList == 1 then
                    if v.type == 'food' then
                        RageUI.List(v.label, Count, IndexItem[v.name], nil, {}, true, {
                            onListChange = function(Index, Item)
                                IndexItem[v.name] = Index;
                                itemName = v.name
                                item = v.label
                                price = v.price*Index..'$'
                            end,
                            onSelected = function()
                                
                            end
                        })
                    end
                elseif IndexList == 2 then
                    if v.type == 'drink' then
                        RageUI.List(v.label, Count, IndexItem[v.name], nil, {}, true, {
                            onListChange = function(Index, Item)
                                IndexItem[v.name] = Index;
                                itemName = v.name
                                item = v.label
                                price = v.price*Index..'$'
                            end,
                            onSelected = function()
                                
                            end
                        })
                    end
                elseif IndexList == 3 then
                    if v.type == 'other' then
                        RageUI.List(v.label, Count, IndexItem[v.name], nil, {}, true, {
                            onListChange = function(Index, Item)
                                IndexItem[v.name] = Index;
                                itemName = v.name
                                item = v.label
                                price = v.price*Index..'$'
                            end,
                            onSelected = function()
                                
                            end
                        })
                    end
                end
            end
        end)
    
        if not RageUI.Visible(menu) then
            menu = RMenu:DeleteType('menu', true)
        end
    end
end