Player = {}
Player.__index = Player
PlyData = {}

function Player.new(id, data, inventory)
    local result = data
    local self = {}

    self.id = id
    self.identifier = data.identifier
    self.vip = data.vip
    self.group = data.group
    if data.coords then
        self.coords = json.decode(data.coords)
    end
    self.name = data.name or nil
    self.account = data.account
    self.inventory = inventory

    return setmetatable(self, Player)
end

function Players(src)
    return PlyData[src]
end

function Player:getIdentifier(IdentifierType) -- (steam, license, xbl, ip, discord, live, fivem)
    local identifier = nil
    for k,v in ipairs(GetPlayerIdentifiers(self.id)) do
		if string.match(v, IdentifierType..':') then
			identifier = string.sub(v, 9)
			break
		end
	end
end

function Player:getName()
    return self.name
end

function Player:getGroup()
    return self.group
end

function Player:isVip()
    return self.vip
end

function Player:getAccount(str)
    local type = {
        ["money"] = self.account.money,
        ["bank"] = self.account.bank,
        ["black"] = self.account.black,
    }
    return type[str]
end

function Player:addMoney(amount)
    self.account.money = self.account.money + amount
    self:saveAccount()
end

function Player:addBank(amount)
    self.account.bank = self.account.bank + amount
    self:saveAccount()
end

function Player:addBlack(amount)
    self.account.black = self.account.black + amount
    self:saveAccount()
end

function Player:removeMoney(amount)
    self.account.money = self.account.money - amount
    self:saveAccount()
end

function Player:removeBank(amount)
    self.account.bank = self.account.bank - amount
    self:saveAccount()
end

function Player:removeBlack(amount)
    self.account.black = self.account.black - amount
    self:saveAccount()
end

function Player:getBucket()
    return (self.id + 1000)
end

function Player:getCoords()
    if CoreSett.useOneSync then
        local res, h = GetEntityCoords(GetPlayerPed(self.id)), GetEntityHeading(GetPlayerPed(self.id))
        return {x = res.x, y = res.y, z = res.z, h = h}
    else
        print("You can't get coords server side without OneSync")
    end
end

function Player:getBucket()
    return (self.id + 1000)
end

function Player:enterBucket()
    if CoreSett.useOneSync then
        SetPlayerRoutingBucket(self.id, (self.id + 1000))
        SetRoutingBucketPopulationEnabled((self.id + 1000), false)
        SetEntityRoutingBucket(GetPlayerPed(self.id), (self.id + 1000))
    else
        print("You can't use bucket without OneSync")
    end
end

function Player:leaveBucket()
    if CoreSett.useOneSync then
        SetPlayerRoutingBucket(self.id, publicSession.id)
        SetRoutingBucketPopulationEnabled(publicSession.id, true)
        SetEntityRoutingBucket(GetPlayerPed(self.id), publicSession.id)
    else
        print("You can't use bucket without OneSync")
    end
end

function Player:saveAccount()
    local account = json.encode(self.account)
    MySQL.Async.execute(
	    'UPDATE players SET account = @account WHERE identifier=@identifier',
    {
        ['@identifier'] = self.identifier,
        ['@account'] = account
    })
end

function Player:saveCoords(coords)
    local xCoords = json.encode(coords)
    MySQL.Async.execute(
        'UPDATE players SET coords = @coords WHERE identifier=@identifier',
    {
        ['@identifier'] = self.identifier,
        ['@coords'] = xCoords
    })
end
