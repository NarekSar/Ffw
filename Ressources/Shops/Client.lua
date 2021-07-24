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
