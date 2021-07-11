Menus = {}
Menus.__index = Menus
crtMenu = nil
local crtY = {}

function Menus.create(params)
    local self = {}
    
    self.title = params.title or ""
    self.pos = params.pos or {x = 0, y = 0}
    self.width = params.width or 431
    self.height = MenuSett.background.height
    self.maxBtn = params.maxBtn or 8
    self.crtBtn = 0
    self.parent = params.parent or nil
    self.items = {}
    self.index = 1
    self.crtY = (self.pos.y + (MenuSett.background.height/1.7))
    self.canClose = true
    self.onClose = params.onClose or nil
    self.timer = 0
    
    return setmetatable(self, Menus)
end

function Menus:setTitle(newTitle)
    self.title = newTitle 
end

function Menus:setWidth(newWidth)
    self.width = newWidth
end

function Menus:onClose(methode)
    for _,v in pairs (crtY) do
        if v.selected then
            v.selected = false
        end
    end
    if methode then
        methode()
    end
end

function Menus:setClosable(bool)
    self.canClose = bool 
end

function Menus:headerRender()
    Draw:setRect((self.pos.x + (self.width/1.9)), (self.pos.y + (MenuSett.background.height/1.7)), self.width, self.height, 0, 0, 0, 150)
    Draw:setText((self.pos.x + (self.width/1.9)), self.pos.y + (MenuSett.background.height/4), MenuSett.background.txtScale, self.title, 245, 245, 245, 255, 6)
    Draw:setRect((self.pos.x + (self.width/1.9)), self.pos.y + (MenuSett.background.height/1.4), self.width/2, 2, 245, 245, 245, 255)
    Draw:setRect((self.pos.x + (self.width/1.9)), self.pos.y + MenuSett.background.height, self.width, 2, 245, 245, 245, 255)
end

function Menus:addButton(params)
    if self.crtBtn < self.maxBtn then
        local newItem = {
            type = "button",
            label = params.label or "",
            onClick = params.onClick or nil,
            subMenu = params.subMenu or nil,
        }
        table.insert(self.items, #self.items + 1, newItem)
        self.crtBtn = self.crtBtn + 1
    else
        print("To many items in "..self.title.." menu")
    end
end

function Menus:buttonRender(index, value)
    if index <= self.maxBtn then
        if not crtY[index] then
            crtY[index] = {}
            crtY[index].selected = false
            crtY[index].y = self.crtY + (MenuSett.background.height/1.46)
            self.crtY = self.crtY + MenuSett.items.height
        end
        if not crtY[index].selected then
            Draw:setRect((self.pos.x + (self.width/1.9)), crtY[index].y, self.width, MenuSett.items.height, 0, 0, 0, 150)
            Draw:setText((self.pos.x + (self.width/1.9)), crtY[index].y - (MenuSett.items.height/3), MenuSett.items.txtScale, value.label, 245, 245, 245, 255, 8)
        else
            Draw:setText((self.pos.x + (self.width/1.9)), crtY[index].y - (MenuSett.items.height/3), MenuSett.items.txtScale, value.label, 0, 0, 0, 255, 8)
            Draw:setRect((self.pos.x + (self.width/1.9)), crtY[index].y, self.width, MenuSett.items.height, 245, 245, 245, 255)
        end
    end
end

function Menus:addList(params)
    if self.crtBtn < self.maxBtn then
        if tonumber(params.index) ~= nil and params.list[1] ~= nil then
            local newItem = {
                type = "list", 
                label = params.label or "",
                list = params.list, 
                index = params.index,
                onChange = params.onChange,
                onClick = params.onClick,
                subMenu = params.subMenu or nil,
            }
            table.insert(self.items, #self.items + 1, newItem)
        else
            print("Your list "..params.label.." don't have 'list={}' or 'index=1'. ")
        end
        self.crtBtn = self.crtBtn + 1
    else
        print("To many items in "..self.title.." menu")
    end
end

function Menus:listRender(index, value)
    if index <= self.maxBtn then
        if self.items[index].list then
            if not crtY[index] then
                crtY[index] = {}
                crtY[index].selected = false
                crtY[index].y = self.crtY + (MenuSett.background.height/1.46)
                self.crtY = self.crtY + MenuSett.items.height
            end
            if not crtY[index].selected then
                Draw:setRect((self.pos.x + (self.width/1.9)), crtY[index].y, self.width, MenuSett.items.height, 0, 0, 0, 150)
                Draw:setText((self.pos.x + (self.width/1.9)), crtY[index].y - (MenuSett.items.height/2), MenuSett.items.txtScale, self.items[index].label, 245, 245, 245, 255, 8)
                Draw:setText((self.pos.x + (self.width/1.9)), crtY[index].y - (MenuSett.items.height/10), (MenuSett.items.txtScale/1.2), string.format("← %s →", self.items[index].list[self.items[index].index].label), 245, 245, 245, 255, 8)
            else
                Draw:setText((self.pos.x + (self.width/1.9)), crtY[index].y - (MenuSett.items.height/2), MenuSett.items.txtScale, self.items[index].label, 0, 0, 0, 255, 8)
                Draw:setText((self.pos.x + (self.width/1.9)), crtY[index].y - (MenuSett.items.height/10), (MenuSett.items.txtScale/1.2), string.format("← %s →", self.items[index].list[self.items[index].index].label), 0, 0, 0, 255, 8)
                Draw:setRect((self.pos.x + (self.width/1.9)), crtY[index].y, self.width, MenuSett.items.height, 245, 245, 245, 255)
            end
        end
        self:sliderControl()
    end
end

function Menus:open()
    if crtMenu == nil then
        Citizen.CreateThread(function ()
            crtMenu = self
            while crtMenu == self do
                Wait(self.timer)
                
                self:navigation()
                self:headerRender()
                for _,v in pairs (self.items) do
                    if v.type == "button" then
                        self:buttonRender(_, v)
                    else
                        self:listRender(_, v)
                    end
                end
            end
        end)
    else
        if crtMenu.canClose then
            self:onClose(self.onClose)
            crtMenu = nil
            self:open()
        end
    end
end

function Menus:goBack()
    if self.parent then
        self.parent.index = 1
        self.parent:open()
    else
        if self.canClose then
            self:onClose(self.onClose)
            crtMenu = nil
        end
    end
end

function Menus:navigation()
    if crtY[self.index] then
        if not crtY[self.index].selected then
            crtY[self.index].selected = true
        end
    end
    self:goUp()
    self:goDown()
    self:goEnter()
    self:goReturn()
end

function Menus:goUp()
    if IsControlJustPressed(0, 172) then
        if self.items[self.index - 1] then
            crtY[self.index].selected = false
            self.index = self.index - 1
        else
            crtY[self.index].selected = false
            self.index = #self.items
        end
        PlaySoundFrontend(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", true)
    end
end

function Menus:goDown()
    if IsControlJustPressed(0, 173) then
        if self.items[self.index + 1] then
            crtY[self.index].selected = false
            self.index = self.index + 1
        else
            crtY[self.index].selected = false
            self.index = 1
        end
        PlaySoundFrontend(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", true)
    end
end

function Menus:goEnter()
    if IsControlJustPressed(0, 201) then
        if self.items[self.index].onClick then
            if self.items[self.index].list then
                self.items[self.index].onClick(self.items[self.index].index, self.items[self.index].list[self.items[self.index].index])
            else
                self.items[self.index].onClick()
            end
        end
        if self.items[self.index].subMenu ~= nil then
            crtY[self.index].selected = false
            self.items[self.index].subMenu:open()
        end
        PlaySoundFrontend(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", true)
    end
end

function Menus:goReturn()
    if IsControlJustPressed(0, 177) then
        self:goBack()
        if self.canClose then
            PlaySoundFrontend(-1, "BACK", "HUD_FRONTEND_DEFAULT_SOUNDSET", true)
        else
            PlaySoundFrontend(-1, "ERROR", "HUD_FRONTEND_DEFAULT_SOUNDSET", true)
        end
    end
end

function Menus:closeAll()
    self:onClose(self.onClose)
    self.timer = 50
    crtMenu = nil
end

function Menus:sliderControl()
    if self.items[self.index].list then
        if IsControlJustPressed(0, 174) then
            if self.items[self.index].list[self.items[self.index].index - 1] then
                self.items[self.index].index = self.items[self.index].index - 1
                if self.items[self.index].onChange then
                    Citizen.CreateThread( function()
                        self.items[self.index].onChange(self.items[self.index].index, self.items[self.index].list[self.items[self.index].index])
                    end)
                end
            else
                self.items[self.index].index = #self.items[self.index].list
            end
            PlaySoundFrontend(-1, "NAV_LEFT_RIGHT", "HUD_FRONTEND_DEFAULT_SOUNDSET", true)
        elseif IsControlJustPressed(0, 175) then
            if self.items[self.index].list[self.items[self.index].index + 1] then
                self.items[self.index].index = self.items[self.index].index + 1
                if self.items[self.index].onChange then
                    Citizen.CreateThread( function()
                        self.items[self.index].onChange(self.items[self.index].index, self.items[self.index].list[self.items[self.index].index])
                    end)
                end
            else
                self.items[self.index].index = 1
            end
            PlaySoundFrontend(-1, "NAV_LEFT_RIGHT", "HUD_FRONTEND_DEFAULT_SOUNDSET", true)
        end
    end
end
