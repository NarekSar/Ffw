Cars = {}
Cars.__index = Cars

--[[
    Cars = class
    
    *Create ped*
    local [retVal] = Cars.create("adder", {x = 27.98, y = -1031.78, z = 28.79, w = 0.0}, true) -- true = Sync or not with other player
    *Get car state*
    [retVal]:getFuelTank() -- return Max fuel tank
    [retVal]:getSpeed() -- return Kmh or Mph (See Ffw/Core/Settings.lua)
    *Modify car state*
    [retVal]:setFuel(100.0) -- Set vehicle fuel level
    *Modify car model*
    [retVal]:setPrimaryColor(5) -- Set premiary vehicle color
    [retVal]:setSecondaryColor(5) -- Set secondary vehicle color
    [retVal]:setPlate("Location") -- Set plate of vehicle
    [retVal]:DeleteCar() -- Delete Car
]]

function Cars.create(Hash, Pos, Sync)
    local self = {}
    setmetatable(self, Cars)
    
    Stream:loadModel(Hash)
    self.id = CreateVehicle(GetHashKey(Hash), Pos.x, Pos.y, Pos.z, Pos.w, Sync, true)
    self.exist = DoesEntityExist(self.id)

    return self
end

--[[ *Get function* ]]--

function Cars:getFuelTank()
    Wait(50)
    if self.exist then
        return GetVehicleHandlingFloat(self.id, "CHandlingData", "fPetrolTankVolume")
    end
end

function Cars:getSpeed()
    Wait(50)
    if self.exist then
        if CoreSett.useMph then
            return math.ceil(GetEntitySpeed(self.id) * 2.236936)
        else
            return math.ceil(GetEntitySpeed(self.id) * 3.6)
        end
    end
end

--[[ *Set function* ]]--

function Cars:setFuel(int)
    Wait(50)
    if self.exist then
        SetVehicleFuelLevel(self.id, int)
    end
end

function Cars:setPrimaryColor(int)
    Wait(50)
    if self.exist then
        local colorPrimary, colorSecondary = GetVehicleColours(self.id)
        SetVehicleColours(self.id, int, colorSecondary)
    end
end

function Cars:setSecondaryColor(int)
    Wait(50)
    if self.exist then
        local colorPrimary, colorSecondary = GetVehicleColours(self.id)
        SetVehicleColours(self.id, colorPrimary, int)
    end
end

function Cars:setPlate(string)
    Wait(50)
    if self.exist then
        SetVehicleNumberPlateText(self.id, string)
    end
end

function Cars:deleteCar()
    Wait(50)
    if self.exist then
        DeleteEntity(self.id)
    end
end

--[[ *Other function* ]]--
