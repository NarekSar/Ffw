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
    myPlayer:DistancePlayer(vector(0,0,0), Heading) -- Get Distance Pos > Player
    myPlayer:ShowNotification("Coucou") -- Notification Player
    myPlayer:ShowAdvancedNotification('title', 'subject', 'msg', "CHAR_ARTHUR", 1) -- Advanced Notification Player
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

function Player:DistancePlayer(newPos, Radius)
    local pos, head = self:getCoords()
    if #(pos - newPos) < Radius then
        return true
    end 
    return false
end

function Player:notify(params)
    color = {
        ["common"] = {0, 0, 0, 185},
        ["succes"] = {0, 245, 0, 185},
        ["error"] = {245, 0, 0, 185},
    }
    Citizen.CreateThread( function()
        busy = true
        self:timerNotif()
        while busy do
            Wait(0)

            Draw:setRect(960, 952, 512, 128, color[params.type][1], color[params.type][2], color[params.type][3], color[params.type][4])
            Draw:setText(960, 890, 0.55, params.title, 245, 245, 245, 245, 8)
            Draw:setRect(960, 930, 128, 2, 245, 245, 245, 245)
            Draw:setText(960, 940, 0.35, params.message, 245, 245, 245, 245, 8, 960+512)
        end
    end)
end

function Player:timerNotif()
    Citizen.CreateThread( function()
        Wait(5000)
        busy = false
    end)
end

function Player:ShowAdvancedNotification(sender, subject, msg, textureDict, iconType, flash, saveToBrief, hudColorIndex)
    if saveToBrief == nil then saveToBrief = true end
	AddTextEntry('AdvancedNotification', msg)
	BeginTextCommandThefeedPost('AdvancedNotification')
	if hudColorIndex then ThefeedNextPostBackgroundColor(hudColorIndex) end
	EndTextCommandThefeedPostMessagetext(textureDict, textureDict, false, iconType, sender, subject)
	EndTextCommandThefeedPostTicker(flash or false, saveToBrief)
end

myPlayer = Player.new()
