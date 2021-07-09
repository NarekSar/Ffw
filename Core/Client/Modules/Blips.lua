Blips = {}
Blips.__index = Blips

--[[
    Blips = class
    
    *Create blip*
    local [retVal] = Blips.create(Label, Pos, Sprite, Colour) -- Create Blip
    *Set blip*
    [retVal]:SetScale(int) -- Change Blip Scale
]]

function Blips.create(Label, Pos, Sprite, Colour)
    local self = {}

    self.id = AddBlipForCoord(Pos)
    SetBlipSprite(self.id, Sprite)
    SetBlipColour(self.id, Colour)
    BeginTextCommandSetBlipName('STRING') 
    AddTextComponentSubstringPlayerName(Label) 
    EndTextCommandSetBlipName(self.id)

    return setmetatable(self, Blips)
end

function Blips:SetScale(int)
    SetBlipScale(self.id, int)
end
