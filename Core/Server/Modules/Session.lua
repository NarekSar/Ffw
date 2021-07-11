Session = {}
Session.__index = Session

function Session.create()
    local self = {}

    return setmetatable(self, Session)
end

function Session:getAllPlayers()
    local Players = {}
    for k,v in pairs(GetPlayers()) do
        table.insert(Players, {id = v})
    end
    return Players
end

publicSession = Session.create()
