Camera = {}
Camera.__index = Camera

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

function Camera:DeleteCam()
    SetCamActive(self.id, false)
	RenderScriptCams(false, true, 2000, true, true)
    DestroyAllCams(true)
end
