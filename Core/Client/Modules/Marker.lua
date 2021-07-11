Markers = {}
Markers.__index = Markers

--[[
    Markers = class
    
    *Create Markers*
    local [retVal] = DrawMarker(Type, Pos, 0.0, 0.0, 0.0, 0.0, 180.0, 0.0, Scale.x, Scale.y, Scale.z, Color.r, Color.g, Color.b, Color.a, false, true, 2, nil, nil, false) -- Create Marker
]]

function Markers.create(params)
    local self = {}

    self.id = nil
    self.type = params.type or nil
    self.pos = params.pos or nil
    self.width = params.width or 1.0
    self.height = params.height or 1.0
    self.colour = params.colour or {r = 245, g = 245, b = 245, a = 245}
    self.blowUp = params.blowUp or false
    self.faceCam = params.faceCam or false
    self.inversed = params.inversed or false
    self.radius = params.radius or 15.0


    return setmetatable(self, Markers)
end

function Markers:showMarker()
    local rot = 0.0
    if self.inversed then
        rot = 180.0
    end
    self.id = DrawMarker(self.type, self.pos.x, self.pos.y, self.pos.z, 0.0, 0.0, 0.0, 0.0, rot, 0.0, self.width, self.width, self.height, self.colour.r, self.colour.g, self.colour.b, self.colour.a, self.blowUp, self.faceCam, 2, nil, nil, false)
end

function Markers:showMarker()
    self.id = DrawMarker(self.type, self.pos, 0.0, 0.0, 0.0, 0.0, 180.0, 0.0, self.width, self.width, self.height, self.colour.r, self.colour.g, self.colour.b, self.colour.a, self.blowUp, self.faceCam, 2, nil, nil, false)
end
