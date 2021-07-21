Menus = {}
Menus.__index = Menus
crtMenu = nil

function Menus.create(params)
    local self = {}
    
    self.title = params.title or ""
    self.subtitle = params.subtitle or ""
    self.parent = params.parents or nil
    self.canClose = params.canClose or true
    self.banner = params.banner or {0, 0, 0, 185}
    self.buttons = {}
    self.index = 1
    
    return setmetatable(self, Menus)
end

function Menus:header()
    -- Header
    Draw:setRect(MenuSett.Header.xOffset + (MenuSett.Header.width/2), (MenuSett.Header.height/1.7), MenuSett.Header.width, MenuSett.Header.height, self.banner[1], self.banner[2], self.banner[3], self.banner[4])
    -- Title
    Draw:setText(MenuSett.Header.xOffset + (MenuSett.Header.width/2), (MenuSett.Header.height/4), MenuSett.Header.txtScale, crtMenu.title, 245, 245, 245, 255, 6)
    -- Subtitle
    Draw:setText(MenuSett.Header.xOffset + (MenuSett.Header.width/2), (MenuSett.Header.height/1.3), (MenuSett.Header.txtScale/2), crtMenu.subtitle, 245, 245, 245, 255, 6)
end

function Menus:items()
end

function Menus:open()
    if crtMenu == nil then
        Citizen.CreateThread(function ()
            crtMenu = self
            while crtMenu == self do
                Wait(0)
                
                crtMenu:navigation()
                crtMenu:header()
                crtMenu:items()
            end
        end)
    else
        if crtMenu.canClose then
            crtMenu = nil
            self:open()
        end
    end
end

function Menus:navigation()
    if IsControlJustPressed(0, 177) then
        crtMenu = nil
        PlaySoundFrontend(-1, "BACK", "HUD_FRONTEND_DEFAULT_SOUNDSET", true)
    end
end