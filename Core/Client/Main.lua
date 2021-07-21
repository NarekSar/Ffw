Citizen.CreateThread(function()
    while not NetworkIsSessionActive() do 
        Wait(50) 
    end
    TriggerServerEvent('Ffw:InitPlayer')
end)

RegisterNetEvent("Ffw:InitPlayer")
AddEventHandler("Ffw:InitPlayer", function(data)
    for _,v in pairs (ZonesAdded) do
        v:showZone()
    end
    myPlayer = Player.new()
    if not CoreSett.useWantedLvl then
	    SetMaxWantedLevel(0)
    end
    if CoreSett.usePvp then
        SetCanAttackFriendly(PlayerPedId(), true, false)
	    NetworkSetFriendlyFireOption(true)
    end
    if data.coords then
        myPlayer:setCoords(vector3(data.coords.x, data.coords.y, data.coords.z), data.coords.h)
    else

    end
end)

Citizen.CreateThread(function()
    if not CoreSett.useOneSync then
        while true do
            Citizen.Wait(15000)
            local coords, heading = myPlayer:getCoords()
            TriggerServerEvent('Ffw:SavePlayerCoords', coords, heading)
        end
    end
end)