Menus = {}
Menus.__index = Menus
local crtMenu = nil

function Menus.create(params)
    local self = {}
    setmetatable(self, Menus)
    
    self.title = params.title or ""
    self.pos = params.pos or {x = 0, y = 0}
    self.width = params.width or 435
    self.maxBtn = params.maxBtn or 7
    self.parent = params.parent or nil
    self.items = {}
    self.index = 0
    self.crtY = params.pos.y or 0
    self.canClose = true
    
    return self
end

local mainMenu = Menus.create({
    title = "Menu d'exemmle",
    pos = {x = 0, y = 0},
    width = 512,
    maxBtn = 10,
    parent = nil,
})

function Menus:setTitle(newTitle)
    self.title = newTitle 
end

function Menus:setWidth(newWidth)
    self.width = newWidth
end

function Menus:onClose(methode)
    methode()
end

function Menus:setClosable(bool)
    self.canClose = bool 
end

function Menus:addButton(params)
    local newItem = {
        type = "button",
        label = params.label or "", 
        rightTxt = params.rightTxt or "",
        onClick = params.action.onClick or nil,
        subMenu = params.subMenu or nil,
        render = Menus.buttonRender
    }
    table.insert(self.items, #self.items + 1, newItem)
    if self.index == 0 then
        self.index = 1
    end
end

function Menus.buttonRender(label, rightTxt)
  
end

mainMenu:addButton({
  label = "Test button",
  rightTxt = "Test",
  onClick = function()
      print("Test onClick button")
  end,
  subMenu = nil,
})

function Menus:addList(params)
    if tonumber(params.index) ~= nil and params.list[1] ~= nil then
        local newItem = {
            type = "list", 
            label = params.label or "",
            list = params.list, 
            index = params.index,
            onChange = params.action.onChange,
            onClick = params.action.onClick,
            subMenu = params.subMenu or nil,
            render = Menus.listRender
        }
        table.insert(self.items, #self.items + 1, newItem)
        if self.index == 0 then
            self.index = 1
        end
    else
        print("Your list "..params.label.." don't have 'list={}' or 'index=1'. ")
    end
end

function Menus.listRender(label, list)
  
end

mainMenu:addList({
  label = "Test list",
  list = {"Test", "Des", "Liste"},
  index = 1,
  onChange = function()
    print("onChange list")
  end,
  onClick = function()
    print("onClick list")
  end,
  subMenu = nil,
})

function Menus:open()
    if crtMenu == nil then
        Citizen.CreateThread(function ()
            crtMenu = self
            while crtMenu == self do
                Wait(0)
                
                -- Ui background
                -- Ui title
                -- Render items
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
      self.parent:open()
  else
      self:onClose()
      crtMenu = nil
  end
end