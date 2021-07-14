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
    self.inputText = params.inputText or ""

    table.insert(ZonesAdded, self)
    return setmetatable(self, Zones)
end

local TestPed = Peds.create("a_f_m_beach_01", vector4(-2612.967, 3555.02, 4.847656, 0), false)
Test = Zones.create({
    ped = TestPed,
    blip = Blips.create({label = "Test", sprite = 1, colour = 3, scale = 0.7,}),
    marker = Markers.create({type = 2, radius = 15.0, pos = vector3(TestPed.pos.x, TestPed.pos.y, TestPed.pos.z + 1.18), width = 0.3, height = 0.3, colour = {r = 0, g = 245, b = 245, a = 185}, blowUp = true, faceCam = true, inversed = true}),
    pos = TestPed.pos,
    radius = 2.0,
    inputText = "Appuyer sur E pour discuter.",
    methode = function()
        E:onPress(function()
            mainMenu:open()
        end)
    end,
})

local ZoneTiming = 500
Citizen.CreateThread( function()
    while true do
        Wait(ZoneTiming)
        
        if myPlayer then
            for _,v in pairs (ZonesAdded) do
                if v.marker then
                    if myPlayer:isNear(vector3(v.pos.x, v.pos.y, v.pos.z), v.marker.radius) then
                        ZoneTiming = 0
                        if v.marker ~= nil then
                            v.marker:showMarker()
                        end
                    else
                        ZoneTiming = 500
                    end
                end
                if myPlayer:isNear(vector3(v.pos.x, v.pos.y, v.pos.z), v.radius) then
                    ZoneTiming = 0
                    if not crtMenu then
                        Citizen.CreateThread( function()
                            myPlayer:helpNotif(v.inputText)
                            v.methode()
                        end)
                    end
                else
                    if not v.marker then
                        ZoneTiming = 500
                    end
                end
            end
        end
    end
end)

function Zones:showZone()
    if self.ped then
        self.blip:entityBlips(self.ped.id)

        self.ped:setInvincible(true)
        self.ped:setFreeze(true)
        self.ped:setPassif(true)
    else
        if not self.ped and self.blip then
            self.blip:blipCoords()
        end
    end
end