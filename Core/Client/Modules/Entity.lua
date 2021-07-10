Entity = {}
Entity.__index = Entity

function Entity.create(Hash, Pos, Sync)
    local self = {}
    setmetatable(self, Entity)
    
    Stream:loadModel(Hash)
    self.id = CreateObject(GetHashKey(Hash), Pos.x, Pos.y, Pos.z, Sync, false, true)
    self.pos = {x = Pos.x, y = Pos.y, z = Pos.z}
    self.exist = DoesEntityExist(self.id)

    return self
end

function Entity:setFreeze(bool)
    Wait(50)
    if self.exist then
        FreezeEntityPosition(self.id, bool)
    end
end

function Entity:setCollision(bool)
    Wait(50)
    if self.exist then
        SetEntityCollision(self.id, bool, bool)
    end
end

function Entity:setAlpha(int)
    Wait(50)
    if self.exist then
        SetEntityAlpha(self.id, int)
    end
end

function Entity:delete()
    Wait(50)
    if self.exist then
        DeleteObject(self.id)
    end
end

