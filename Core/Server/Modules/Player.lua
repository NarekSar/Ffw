Player = {}
Player.__index = Player

function Player.new(id)
    local self = {}
    
    self.id = id

    return setmetatable(self, Player)
end

function Player:getIdentifier(IdentifierType) -- (steam, license, xbl, ip, discord, live, fivem)
    local identifier = GetPlayerIdentifiers(self.id)
    for _, identifiers in pairs(identifier) do
        if string.find(identifiers, tostring(IdentifierType)) then
            return identifiers
        end
    end
end
