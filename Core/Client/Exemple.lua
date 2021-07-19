mainMenu = Menus.create({
    title = "Menu d'exemple",
    pos = {x = 0, y = 0},
    width = 431,
    maxBtn = 10,
    parent = nil,
})

mainMenu:addButton({
    label = "Test add",
    onClick = function()
        TriggerServerEvent("Ffw:testFramework")
    end,
    subMenu = nil,
})

mainMenu:addButton({
    label = "Test remove",
    onClick = function()
        TriggerServerEvent("Ffw:testFramework", true)
    end,
    subMenu = nil,
})

mainMenu:open()
