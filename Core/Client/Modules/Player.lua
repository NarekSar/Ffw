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
    myPlayer:notify({ -- Add Notification
	title = "Location",
	message = 'Le véhicule à bien été ranger !',
	type = "succes",
    })
    myPlayer:DisplayMap(true/false) -- Off / On Map + Radar
    myPlayer:MissionNotif("Test", 1500) -- Mission Notif
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

function Player:isArmed()
    return IsPedArmed(self.ped, 4)
end

function Player:isInCar()
    return IsPedOnVehicle(self.ped)
end

function Player:isNear(Pos, Radius)
    local coords, head = self:getCoords()
    if #(coords - Pos) <= Radius then
        return true
    end 
    return false
end

function Player:notify(params)
    local color = {
        ["common"] = {0, 0, 0, 185},
        ["succes"] = {0, 245, 0, 185},
        ["error"] = {245, 0, 0, 185},
    }
    Citizen.CreateThread( function()
        if not busy then
            busy = true
            self:timerNotif()
            while busy do
                Wait(0)

                Draw:setRect(960, 952, 512, 128, color[params.type][1], color[params.type][2], color[params.type][3], color[params.type][4])
                Draw:setText(960, 890, 0.55, params.title, 245, 245, 245, 245, 8)
                Draw:setRect(960, 930, 128, 2, 245, 245, 245, 245)
                Draw:setText(960, 940, 0.35, params.message, 245, 245, 245, 245, 8, 960+512)
            end
        end
    end)
end

function Player:timerNotif()
    Citizen.CreateThread( function()
        Wait(2500)
        busy = false
    end)
end

function Player:setPlayerModel(Hash)
    Stream:loadModel(Hash)
    local modelHash = GetHashKey(Hash)
    SetPlayerModel(self.id, modelHash)
    SetModelAsNoLongerNeeded(modelHash)
end

function Player:displayMap(bool) 
    DisplayRadar(bool)
end

function Player:missionNotif(msg, time) 
    ClearPrints()
    SetTextEntry_2("STRING")
    AddTextComponentString(msg)
    DrawSubtitleTimed(time and math.ceil(time) or 0, true)
end

function Player:helpNotif(msg)
    if not IsHelpMessageOnScreen() then
		SetTextComponentFormat('STRING')
		AddTextComponentString(msg)
		DisplayHelpTextFromStringLabel(0, 0, 1, -1)
	end
end