mainMenu = Menus.create({
    title = "Menu d'exemple",
    pos = {x = 0, y = 0},
    width = 431,
    maxBtn = 10,
    parent = nil,
})

mainMenu:addButton({
    label = "Test button",
    onClick = function()
        myPlayer:notify({
            title = "Annonce",
            message = "Ceci est une notif common",
            type = "common", -- error/succes/common
        })
    end,
    subMenu = nil,
})

mainMenu:addList({
    label = "Ntm jt'aime pas",
    list = {
        {label = "Ah oui oui oui", value = "sultan"},
        {label = "KAARIS", value = "panto"},
    },
    index = 1,
    onChange = function(Index, Items)
        
    end,
    onClick = function(Index, Items)

    end,
})

mainMenu:open()
mainMenu.onClose = function()
    print("Ntm")
end
