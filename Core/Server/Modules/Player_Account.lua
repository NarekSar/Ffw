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

function Player:saveAccount()
    local account = json.encode(self.account)
    MySQL.Async.execute(
	    'UPDATE players SET account = @account WHERE identifier=@identifier',
    {
        ['@identifier'] = self.identifier,
        ['@account'] = account
    })
end