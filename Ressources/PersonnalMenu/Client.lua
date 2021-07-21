mainMenu = Menus.create({
    title = "Menu personnel",
    subtitle = "Yan labray",
    parent = nil,
    canClose = true,
})

Citizen.CreateThread( function()
    Wait(2500)
    mainMenu:open()
end)