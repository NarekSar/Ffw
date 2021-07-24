local itemToBuy = {
    Index = 0,
    Label = "Aucun",
    Price = 0,
}

ShopsMenu["ltd"] = function()
    RageUI.Separator('↓ ~g~Prix de vos articles~w~ ↓')
    RageUI.Separator("x"..itemToBuy.Index.." "..itemToBuy.Label.." pour :  ~g~"..itemToBuy.Price.."$")
    RageUI.List('Filtre(s) :', {
        {Name = "Nourriture", Value = "food"},
        {Name = "Boisson", Value = "drink"},
        {Name = "Autre", Value = "other"},
        }, ShopsMenu.crtIndex, nil, {}, true, {
        onListChange = function(Index, Items)
            ShopsMenu.crtIndex = Index
            ShopsMenu.crtType = Items.Value
            itemToBuy = {
                Index = 0,
                Label = "Aucun",
                Price = 0,
            }
        end,
    })
    if ShopsMenu.crtType then
        RageUI.Separator('↓ ~g~Articles Disponibles ~w~↓')
        for _,v in pairs (Data.Items) do
            if not v.index then
                v.index = 1
            end
            if v.inLtd then
                if v.Type == ShopsMenu.crtType then
                    local count = {}
                    for i = 1, v.Limite do
                        count[i] = i
                    end
                    RageUI.List(v.Label, count, v.index, nil, {}, true, {
                        onListChange = function(Index, Items)
                            itemToBuy.Label = v.Label
                            itemToBuy.Index = v.index
                            itemToBuy.Price = v.Price * v.index
                            v.index = Index
                        end,
                    })
                end
            end
        end
    end
end