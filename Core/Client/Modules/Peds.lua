Peds = {}
Peds.__index = Peds

--[[
    Peds = class
    
    *Create ped*
    local [retVal] = Peds.create("csb_abigail", {x = 27.98, y = -1031.78, z = 28.79, w = 0.0}, false) -- false = Sync or not with other player
    *Modify ped state*
    [retVal]:setInvincible(true/false) -- Set ped invincible or not
    [retVal]:setFreeze(true/false) -- Set ped freeze or not
    [retVal]:setVisible(true/false) -- Set ped visible or not
    [retVal]:setArmour(0.0 -> 100.0) -- Set ped armour
    *Modify ped model*
    [retVal]:setAlpha(51/102/153/204/255) -- Set ped opacity
    [retVal]:defaultComps() -- Set ped default components
    *Other*
    [retval]:playScenario("WORLD_FISH_FLEE") -- Play scenario in place
    [retval]:playAnim("mini@strip_club@idles@bouncer@base", "base") -- Play animation in place
    [retval]:stopAnim() -- Stop anim in progress
]]

function Peds.create(Hash, Pos, Sync)
    local self = {}
    setmetatable(self, Peds)
    
    Citizen.CreateThread(function()
        RequestModel(Hash)
        while not HasModelLoaded(Hash) do
            RequestModel(Hash)
            Wait(10)
        end
        
        self.id = CreatePed(1, GetHashKey(Hash), Pos.x, Pos.y, Pos.z, Pos.w, Sync, false)
        self.exist = DoesEntityExist(self.id)
    end)

    return self
end

--[[ *Set function* ]]--

function Peds:setInvincible(bool)
    Wait(50)
    if self.exist then
        SetEntityInvincible(self.id, bool)
        SetEntityCanBeDamaged(self.id, not bool)
    end
end

function Peds:setPassif(bool)
    Wait(50)
    if self.exist then
        SetBlockingOfNonTemporaryEvents(self.id, bool)
    end
end

function Peds:setFreeze(bool)
    Wait(50)
    if self.exist then
        FreezeEntityPosition(self.id, bool)
    end
end

function Peds:setVisible(bool)
    Wait(50)
    if self.exist then
        SetEntityVisible(self.id, bool, 0)
    end
end

function Peds:setAlpha(int)
    Wait(50)
    if self.exist then
        SetEntityAlpha(self.id, int, false)
    end
end

function Peds:setArmour(int)
    Wait(50)
    if self.exist then
        SetPedArmour(self.id, int)
    end
end

function Peds:defaultComps()
    Wait(50)
    if self.exist then
        SetPedDefaultComponentVariation(self.id)
    end
end

--[[ *Other function* ]]--

function Peds:playScenario(scenario)
    Wait(50)
    if self.exist then
        TaskStartScenarioInPlace(self.id, scenario, -1, true)
    end
end

function Peds:playAnim(dict, anim)
    Wait(50)
    if self.exist then
        self:setFreeze(true)
        RequestAnimDict(dict)
        while not HasAnimDictLoaded(dict) do
            Citizen.Wait(0)
        end
        TaskPlayAnim(self.id, dict, anim, 8.0, 0.0, -1, 1, 0, 0, 0, 0)
    end
end

function Peds:stopAnim()
    Wait(50)
    if self.exist then
        ClearPedTasksImmediately(self.id)
    end
end
