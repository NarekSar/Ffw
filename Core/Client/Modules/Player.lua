Player = {}
Player.__index = Player

--[[
    Player = class
    
    myPlayer:getHealth()) -- Get Player Health
    myPlayer:getArmor()) -- Get Player Armor
    myPlayer:getCoords()) -- Get Player Coords
    myPlayer:IsInCar()) -- Get Player Is In Car
    myPlayer:IsArmed())  -- Get Player Is Armed
    myPlayer:setHealth(Male 100 > 200 / Female 0 > 100) -- Set Player Health
    myPlayer:setArmor(0 > 100) -- Set Player Armor
    myPlayer:setVisible(true/false) -- Set Player Visible
    myPlayer:setInvincible(true/false) -- Set Player Invincible
    myPlayer:giveWeapon("weapon_pistol", 999) -- Give Player Weapon
    myPlayer:setCoords(vector3(0,0,0), 0) -- Set Player Coords
    myPlayer:FreezePlayer(true/false) -- Freeze Player
    myPlayer:DistancePlayer(vector(0,0,0)) -- Get Distance Pos > Player
]]


function Player.new()
    local self = {}
    
    self.id = PlayerId()
    self.ped = PlayerPedId()
    self.skin = {}
    self.clothe = {}
    self.data = {}

    return setmetatable(self, Player)
end

function Player:setCoords(Pos, Heading)
    SetEntityCoords(self.ped, Pos)
    SetEntityHeading(self.ped, Heading)
end

function Player:setHealth(int)
    SetEntityHealth(self.ped, int)
end

function Player:setArmor(int)
    SetPedArmour(self.ped, int)
end

function Player:setInvincible(bool)
    SetPlayerInvincible(self.id, bool)
end

function Player:setVisible(bool)
    SetEntityVisible(self.ped, bool, 0)
end

function Player:FreezePlayer(bool)
    FreezeEntityPosition(self.ped, bool)
end

function Player:giveWeapon(Weapon, Ammo)
    GiveWeaponToPed(self.ped, Weapon, Ammo, false, false)
end

function Player:getCoords()
    return GetEntityCoords(self.ped), GetEntityHeading(self.ped)
end

function Player:getHealth()
    return GetEntityHealth(self.ped)
end

function Player:getArmor()
    return GetPedArmour(self.ped)
end

function Player:IsArmed()
    return GetPedArmour(self.ped, 4)
end

function Player:IsInCar()
    return IsPedOnVehicle(self.ped)
end

function Player:DistancePlayer(Pos)
    return GetDistanceBetweenCoords(Pos, myPlayer:getCoords(), true)
end

myPlayer = Player.new()
