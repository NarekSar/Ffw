Camera = {}
Camera.__index = Camera

--[[
    Camera = class
    
    local [retVal] = Camera.create(vector3(0, 0, 0), vector3(0, 0, 0)) -- Création Cam | Premier Pos = Cam | Deuxieme Pos = Point ou il regarde

    [retVal]:CamActive() -- Activer la camera

    [retVal]:DeleteCam() -- Supprimer la camera
]]

function Camera.create(PosCam, PosHeading)
    local self = {}

    self.id = CreateCam("DEFAULT_SCRIPTED_CAMERA", 0)
    self.exist = DoesCamExist(self.id)

    SetCamCoord(self.id, PosCam)
    PointCamAtCoord(self.id, PosHeading)

    return setmetatable(self, Camera)
end

function Camera:CamActive()
    if self.exist then
        SetCamActive(self.id, true)
        RenderScriptCams(true, true, 2000, true, false)
    end
end

function Camera:DeleteCam(bool)
    if self.exist then
    	SetCamActive(self.id, false)
	RenderScriptCams(false, bool, 2000, true, true)
	DestroyCam(self.id, false)
    end
end
