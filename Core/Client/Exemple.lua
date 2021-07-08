local mainMenu = Menus.create({
    title = "Menu d'exemple",
    pos = {x = 0, y = 0},
    width = 431,
    maxBtn = 10,
    parent = nil,
})

local subMenu = Menus.create({
    title = "Sousmenu d'exemple",
    pos = {x = 0, y = 0},
    width = 431,
    maxBtn = 10,
    parent = mainMenu,
})

mainMenu:addButton({
    label = "Test button",
    onClick = function()
    end,
    subMenu = subMenu,
})

mainMenu:addList({
    label = "Test list",
    list = {"Test", "Des", "Liste"},
    index = 1,
    onChange = function()
        print("onChange list")
    end,
    onClick = function()
    end,
    subMenu = nil,
})

mainMenu:open()