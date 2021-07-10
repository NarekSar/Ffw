Entity = {}
Entity.__index = Entity

function Entity.create(Hash, Pos, Sync)
    local self = {}
    setmetatable(self, Entity)
    
    Stream:loadModel(Hash)
    self.id = CreateObject(GetHashKey(Hash), Pos.x, Pos.y, Pos.z, Sync, false, true)
    self.exist = DoesEntityExist(self.id)

    return self
end

function Entity:setFreeze(bool)
    if self.exist then
        FreezeEntityPosition(self.id, bool)
    end
end

function Entity:setCollision(bool)
    if self.exist then
        SetEntityCollision(self.id, bool, bool)
    end
end

function Entity:setAlpha(int)
    if self.exist then
        SetEntityAlpha(self.id, int)
    end
end

function Entity:delete()
    if self.exist then
        DeleteObject(self.id)
    end
end

