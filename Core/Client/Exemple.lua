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
    list = {
        {label = "Jte nique", value = "test"},
        {label = "test", value = "test"},
        {label = "ntm", value = "test"},
    },
    index = 1,
    onChange = function(Index, Items)
        print(Index, json.encode(Items))
    end,
    onClick = function(Index, Items)
        print(Index, json.encode(Items))
    end,
    subMenu = nil,
})

mainMenu:open()