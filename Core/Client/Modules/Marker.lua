Marker = {}
Marker.__index = Marker

--[[
    Marker = class
    
    *Create Marker*
    local [retVal] = DrawMarker(Type, Pos, 0.0, 0.0, 0.0, 0.0, 180.0, 0.0, Scale.x, Scale.y, Scale.z, Color.r, Color.g, Color.b, Color.a, false, true, 2, nil, nil, false) -- Create Marker
]]

function Marker.create(Type, Pos, Scale, Color)
    local self = {}

    self.id = DrawMarker(Type, Pos, 0.0, 0.0, 0.0, 0.0, 180.0, 0.0, Scale.x, Scale.y, Scale.z, Color.r, Color.g, Color.b, Color.a, false, true, 2, nil, nil, false)

    return setmetatable(self, Marker)
end
