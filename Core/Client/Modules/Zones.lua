Zones = {}
Zones.__index = Zones
ZonesAdded = {}

function Zones.create(params)
    local self = {}
    
    self.pos = params.pos or nil
    self.blip = params.blip or nil
    self.ped = params.ped or nil
    self.marker = params.marker or nil
    self.methode = params.methode or nil
    self.radius = params.radius or 1.5

    table.insert(ZonesAdded, self)
    return setmetatable(self, Zones)
end

local ShopPed = Peds.create("csb_abigail", {x = 27.98, y = -1031.78, z = 28.79, w = 0.0}, false)
Shop = Zones.create({
    ped = ShopPed,
    blip = Blips.create({label = "Test", sprite = 1, colour = 3, scale = 0.7,}),
    pos = ShopPed.pos,
    methode = function()
        print("test Fct")
    end,
})
test = Zones.create({
    ped = ShopPed,
    blip = Blips.create({label = "Test", sprite = 1, colour = 3, scale = 0.7,}),
    pos = ShopPed.pos,
    methode = function()
        print("test Fct")
    end,
})
azd = Zones.create({
    ped = ShopPed,
    blip = Blips.create({label = "Test", sprite = 1, colour = 3, scale = 0.7,}),
    pos = ShopPed.pos,
    methode = function()
        print("test Fct")
    end,
})
vfvs = Zones.create({
    ped = ShopPed,
    blip = Blips.create({label = "Test", sprite = 1, colour = 3, scale = 0.7,}),
    pos = ShopPed.pos,
    methode = function()
        print("test Fct")
    end,
})

Citizen.CreateThread( function()
    Wait(2500)
    Shop:showZone()
    for _,v in pairs (ZonesAdded) do
        v.methode()
    end
end)

function Zones:showZone()
    if self.ped then
        self.blip:entityBlips(self.ped.id)
    else
        if not self.ped and self.blip then
            self.blip:blipCoords()
        end
    end
end