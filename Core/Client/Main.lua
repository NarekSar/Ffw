Citizen.CreateThread(function()
    while not NetworkIsSessionActive() do 
        Wait(50) 
    end
    TriggerServerEvent('Ffw:InitPlayer')
end)

RegisterNetEvent("Ffw:InitPlayer")
AddEventHandler("Ffw:InitPlayer", function()
    myPlayer = Player.new()
end)