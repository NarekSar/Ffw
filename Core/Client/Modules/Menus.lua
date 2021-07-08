Menus = {}
Menus.__index = Menus
local crtMenu = nil
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
    
    return setmetatable(self, Menus)
end

function Menus:setTitle(newTitle)
    self.title = newTitle 
end

function Menus:setWidth(newWidth)
    self.width = newWidth
end

function Menus:onClose(methode)

end

function Menus:setClosable(bool)
    self.canClose = bool 
end

function Menus:headerRender()
    Ui:setRect((self.pos.x + (self.width/1.9)), (self.pos.y + (MenuSett.background.height/1.7)), self.width, self.height, 0, 0, 0, 150)
    Ui:setText((self.pos.x + (self.width/1.9)), self.pos.y + (MenuSett.background.height/4), MenuSett.background.txtScale, self.title, 245, 245, 245, 255, 6)
    Ui:setRect((self.pos.x + (self.width/1.9)), self.pos.y + (MenuSett.background.height/1.4), self.width/2, 2, 245, 245, 245, 255)
    Ui:setRect((self.pos.x + (self.width/1.9)), self.pos.y + MenuSett.background.height, self.width, 2, 245, 245, 245, 255)
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
            crtY[index].y = self.crtY + (MenuSett.background.height/1.35)
            self.crtY = self.crtY + MenuSett.items.height
        end
        if not crtY[index].selected then
            Ui:setRect((self.pos.x + (self.width/1.9)), crtY[index].y, self.width, MenuSett.items.height, 0, 0, 0, 150)
            Ui:setText((self.pos.x + (self.width/1.9)), crtY[index].y - (MenuSett.items.height/3), MenuSett.items.txtScale, value.label, 245, 245, 245, 255, 6)
        else
            Ui:setText((self.pos.x + (self.width/1.9)), crtY[index].y - (MenuSett.items.height/3), MenuSett.items.txtScale, value.label, 0, 0, 0, 255, 6)
            Ui:setRect((self.pos.x + (self.width/1.9)), crtY[index].y, self.width, MenuSett.items.height, 245, 245, 245, 255)
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
        if not crtY[index] then
            crtY[index] = {}
            crtY[index].selected = false
            crtY[index].y = self.crtY + (MenuSett.background.height/1.35)
            self.crtY = self.crtY + MenuSett.items.height
        end
        if not crtY[index].selected then
            Ui:setRect((self.pos.x + (self.width/1.9)), crtY[index].y, self.width, MenuSett.items.height, 0, 0, 0, 150)
            Ui:setText((self.pos.x + (self.width/1.9)), crtY[index].y - (MenuSett.items.height/3), MenuSett.items.txtScale, value.label, 245, 245, 245, 255, 6)
        else
            Ui:setText((self.pos.x + (self.width/1.9)), crtY[index].y - (MenuSett.items.height/3), MenuSett.items.txtScale, value.label, 0, 0, 0, 255, 6)
            Ui:setRect((self.pos.x + (self.width/1.9)), crtY[index].y, self.width, MenuSett.items.height, 245, 245, 245, 255)
        end
    end
end

function Menus:open()
    if crtMenu == nil then
        Citizen.CreateThread(function ()
            crtMenu = self
            while crtMenu == self do
                Wait(0)
                
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
            self:onClose()
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
        self:onClose()
        crtMenu = nil
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
            self.items[self.index].onClick()
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
        PlaySoundFrontend(-1, "BACK", "HUD_FRONTEND_DEFAULT_SOUNDSET", true)
    end
end