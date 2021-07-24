local newItem = {
    Label = "",
    Name = "",
    Limite = "",
    inLtd = false,
    Price = "",
    Type = "",
    typeIndex = 1,
}

RegisterNetEvent("Ffw:resetItemBuilder")
AddEventHandler("Ffw:resetItemBuilder", function()
    newItem = {
        Label = "",
        Name = "",
        Limite = "",
        inLtd = false,
        Price = "",
        Type = "",
        typeIndex = 1,
    }
    myPlayer:notify("L'objet à bien était créer.")
end)

adminSys["item"] = function()
    RageUI.Separator("Caractéristique de l'objet")
    RageUI.Button("Label de l'objet", "Nom visible dans l'inventaire", {RightLabel = newItem.Label}, true, {
        onSelected = function(Index, Items)
            local newLabel = Keys.input(30, "30 caractères maximum !")
            if newLabel ~= nil then
                newItem.Label = newLabel
            else
                myPlayer:notify("Veuillez entré un label pour l'objet.")
            end
        end,
    })
    RageUI.Button("Nom de l'objet", "Nom de l'item en base de donnée", {RightLabel = newItem.Name}, true, {
        onSelected = function(Index, Items)
            local newName = Keys.input(30, "30 caractères maximum (EN MINUSCULE) !")
            if newName ~= nil then
                newItem.Name = newName
            else
                myPlayer:notify("Veuillez entré un nom pour l'objet.")
            end
        end,
    })
    RageUI.List("Type de l'objet", {
        {Name = "Nourriture", Value = "food"},
        {Name = "Boisson", Value = "drink"},
        {Name = "Autre", Value = "other"},
    }, newItem.typeIndex, "Définie le type d'item", {}, true, {
        onListChange = function(Index, Items)
            newItem.typeIndex = Index
            newItem.Type = Items.Value
        end,
    })
    RageUI.Button("Limite de l'objet", "Limite de l'objet dans l'inventaire", {RightLabel = newItem.Limite}, true, {
        onSelected = function(Index, Items)
            local newPound = Keys.input(30, "30 caractères maximum !")
            if tonumber(newPound) ~= nil then
                newItem.Limite = tonumber(newPound)
            else
                myPlayer:notify("Veuillez entré une limite dans l'inventaire pour l'objet.")
            end
        end,
    })
    RageUI.Separator("Facultatif")
    RageUI.Checkbox("En vente dans les supèrettes", "Définie si l'objet est vendu en supèrette ou non", newItem.inLtd, {}, {
        onChecked = function(Index, Items)
            newItem.inLtd = true
        end,
        onUnChecked = function(Index, Items)
            newItem.inLtd = false
            newItem.Price = ""
        end,
    })
    if newItem.inLtd then
        RageUI.Button("Prix de l'objet", "Définie le prix de l'objet dans les supèrettes", {RightLabel = "~g~"..newItem.Price.." $"}, true, {
            onSelected = function(Index, Items)
                local newPrice = Keys.input(5, "5 caractères maximum !")
                if tonumber(newPrice) ~= nil then
                    newItem.Price = tonumber(newPrice)
                else
                    myPlayer:notify("Veuillez entré un prix pour l'objet.")
                end
            end,
        })
    end
    if newItem.Label ~= "" and newItem.Name ~= "" and newItem.Pound ~= "" and newItem.type ~= "" then
        RageUI.Button("Enregistrer l'objet", "Enregistre l'objet en base de donnée", {RightLabel = ">>>"}, true, {
            onSelected = function(Index, Items)
                if not newItem.inLtd then
                    if newItem.Price then
                        TriggerServerEvent("Ffw:saveNewItem", newItem)
                    else
                        myPlayer:notify("Veuillez entré un prix pour l'objet.")
                    end
                else
                    TriggerServerEvent("Ffw:saveNewItem", newItem)
                end
            end,
        })
    end
end