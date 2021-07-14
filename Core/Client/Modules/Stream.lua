Stream = {}

function Stream:loadAnimDict(dict)
    Citizen.CreateThread(function()
        RequestAnimDict(dict)
        while not HasAnimDictLoaded(dict) do
            Wait(50)
        end
    end)
end

function Stream:loadModel(model)
    Citizen.CreateThread(function()
        RequestModel(model)
        while not HasModelLoaded(model) do
            Wait(50)
        end
    end)
end
