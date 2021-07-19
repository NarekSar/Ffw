function Player:getInventory()
    return self.inventory
end

function Player:addInventory(item, count)
    if Items[item] then
        if self.inventory[item] then
            self.inventory[item].count = self.inventory[item].count + count
        else
            self.inventory[item] = {}
            self.inventory[item].label = Items[item].label
            self.inventory[item].name = item
            self.inventory[item].count = count
        end
        self:saveInventory()
    end
end

function Player:removeInventory(item, count)
    if Items[item] then
        if self.inventory[item] then
            if (self.inventory[item].count - count) >= 0 then
                self.inventory[item].count = self.inventory[item].count - count
            end
        end
        self:saveInventory()
    end
end

function Player:getItem(item)
    if Items[item] then
        if self.inventory[item] then
            return self.inventory[item]
        else
            return {name = item, label = Items[item].label, count = 0}
        end
    end
end

function Player:saveInventory()
    local inventory = json.encode(self.inventory)
    MySQL.Async.execute(
	    'UPDATE players SET inventory = @inventory WHERE identifier=@identifier',
    {
        ['@identifier'] = self.identifier,
        ['@inventory'] = inventory
    }, function()
        print(inventory)
    end)
end