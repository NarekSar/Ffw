function Player:getStats()
    return self.stats
end

function Player:addHunger(inc)
    local newHunger = self.stats.hunger + inc
    if newHunger < 100 then
        self.stats.hunger = newHunger
    else
        self.stats.hunger = 100
    end 
    self:saveStats()
end

function Player:removeHunger(dec)
    local newHunger = self.stats.hunger - dec
    if newHunger > 0 then
        self.stats.hunger = newHunger
    else
        self.stats.hunger = 0
    end
    if self.stats.hunger <= 5.0 then
        --self:triggerClient 
    end
end 

function Player:addThirst(inc)
    local newThirst = self.stats.thirst + inc
    if newThirst < 100 then
        self.stats.thirst = newThirst
    else
        self.stats.thrist = 100
    end
end

function Player:removeThirst(dec)
    local newThirst = self.stats.thirst - dec
    if newThirst > 0 then
        self.stats.thrist = newThirst
    else
        self.stats.thrist = 0
    end
    if self.stats.thirst <= 5.0 then
        --self:triggerClient 
    end
end

function Player:addDrunk(inc)
    self.stats.drunk = true
    self.stats.drunkTime = self.stats.drunkTime + inc
    --self:triggerClient
end

function Player:saveStats()
    local stats = json.encode(self.stats)
    MySQL.Async.execute(
	    'UPDATE players SET stats = @stats WHERE identifier=@identifier',
    {
        ['@identifier'] = self.identifier,
        ['@stats'] = stats
    })
end