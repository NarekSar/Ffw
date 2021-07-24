adminSys = {
    onMenu = false,
    nexMenu = nil,
}

adminSys.mainMenu = RageUI.CreateMenu("Administration", " ")
adminSys.mainMenu.Closed = function()
    adminSys.onMenu = false
end
adminSys.creatorMenu = RageUI.CreateMenu(" ", " ")

Keys.register("F5", "openAdminMain", "Menu administration", function()
    TriggerServerEvent("Ffw:openAdminMain")
end)

RegisterNetEvent("Ffw:openAdminMain")
AddEventHandler("Ffw:openAdminMain", function()
    adminSys.open()
end)

function adminSys.open()
    adminSys.onMenu = true
    RageUI.Visible(adminSys.mainMenu, true)
    
    while adminSys.onMenu do
        Wait(0)

        RageUI.IsVisible(adminSys.mainMenu, function()
            RageUI.Button("Création d'items", "Permet de créer un item, pour le rendre utilisable, remontez l'information aux deveveloppeurs", {RightLabel = ">>>"}, true, {
                onSelected = function(Index, Items)
                    adminSys.nexMenu = "item"
                    adminSys.creatorMenu.Title = "Item builder"
                end,
            }, adminSys.creatorMenu)
        end)

        RageUI.IsVisible(adminSys.creatorMenu, function()
            adminSys[adminSys.nexMenu]()
        end)
    end
end