local mainMenu = Menus.create({
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

mainMenu:open()
mainMenu.onClose = function()
    print("Ntm")
end