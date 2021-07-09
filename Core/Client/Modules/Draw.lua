Draw = {}

function Draw:setRect(x, y, width, height, r, g, b, a)
    DrawRect((x/1920), (y/1080), (width/1920), (height/1080), r, g, b, a)
end

function Draw:setText(x, y, scale, text, r, g, b, a, font)
    --[[
        justify :
        0: Center-Justify  
        1: Left-Justify  
        2: Right-Justify  
    ]]
    SetTextFont(font)
    SetTextJustification(0)
    SetTextScale(scale, scale)
    SetTextColour(r, g, b, a)
    BeginTextCommandDisplayText("STRING")
    AddTextComponentSubstringPlayerName(text)
    EndTextCommandDisplayText((x/1920), (y/1080))
end