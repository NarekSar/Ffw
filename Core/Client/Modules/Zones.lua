Zones = {}
Zones.__index = Zones
ZonesAdded = {}
local ActualZone = nil

function Zones.create(params)
    local self = {}
    
    self.pos = params.pos or nil
    self.blip = params.blip or nil
    self.ped = params.ped or nil
    self.forJob = params.forJob or nil
    self.marker = params.marker or nil
    self.methode = params.methode or nil
    self.radius = params.radius or 1.5
    self.inputText = params.inputText or ""

    table.insert(ZonesAdded, self)
    return setmetatable(self, Zones)
end

local ZoneTiming = 500
Citizen.CreateThread( function()
    while true do
        Wait(ZoneTiming)
        
        if myPlayer then
            for _,v in pairs (ZonesAdded) do
                if v.marker then
                    if myPlayer:isNear(vector3(v.pos.x, v.pos.y, v.pos.z), v.marker.radius) then
                        ZoneTiming = 0
                        ActualZone = v
                        v.marker:showMarker()
                    end
                end
                if myPlayer:isNear(vector3(v.pos.x, v.pos.y, v.pos.z), v.radius) then
                    ZoneTiming = 0
                    ActualZone = v
                    if not crtMenu then
                        Citizen.CreateThread( function()
                            if not v.forJob then
                                myPlayer:helpNotif(v.inputText)
                                v.methode()
                            else
                                if v.forJob == myPlayer.jobName then
                                    myPlayer:helpNotif(v.inputText)
                                    v.methode()
                                end
                            end
                        end)
                    end
                else
                    if not ActualZone then
                        ZoneTiming = 500
                    else
                        if not myPlayer:isNear(vector3(ActualZone.pos.x, ActualZone.pos.y, ActualZone.pos.z), ActualZone.radius) then
                            ZoneTiming = 500
                            ActualZone = nil
                        end
                    end
                end
            end
        end
    end
end)

function Zones:showZone()
    if self.ped then
        self.blip:entityBlips(self.ped.id)
        Wait(250)
        self.ped:setInvincible(true)
        self.ped:setFreeze(true)
        self.ped:setPassif(true)
    else
        if not self.ped and self.blip then
            self.blip:blipCoords()
        end
    end
end