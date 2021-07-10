Blips = {}
Blips.__index = Blips

--[[
    Blips = class
    
    *Create blip*
    local [retVal] = Blips.create(Label, Pos, Sprite, Colour) -- Create Blip
]]

function Blips.create(params)
    local self = {}

    self.id = nil
    self.label = params.label or nil
    self.pos = params.pos or nil
    self.sprite = params.sprite or nil
    self.colour = params.colour or nil
    self.scale = params.scale or nil


    return setmetatable(self, Blips)
end

function Blips:blipCoords()
    self.id = AddBlipForCoord(self.pos)
    SetBlipSprite(self.id, self.sprite)
    SetBlipColour(self.id, self.colour)
    SetBlipScale(self.id, self.scale)
    BeginTextCommandSetBlipName('STRING')
    AddTextComponentSubstringPlayerName(self.label)
    EndTextCommandSetBlipName(self.id)
    return self.id
end

function Blips:entityBlips(entityId)
    self.id = AddBlipForEntity(entityId)
    SetBlipSprite(self.id, self.sprite)
    SetBlipColour(self.id, self.colour)
    SetBlipScale(self.id, self.scale)
    BeginTextCommandSetBlipName('STRING')
    AddTextComponentSubstringPlayerName(self.label)
    EndTextCommandSetBlipName(self.id)
end
