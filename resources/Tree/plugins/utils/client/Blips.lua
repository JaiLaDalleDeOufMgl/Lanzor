local blips = {
    {name = "Bijouterie", sprite = 617, color = 3, coords = vector3(-628.24438476562, -235.35946655273, 38.057067871094)},
    {name = "Alamo Island", sprite = 183, color = 77, coords = vector3(232.73379516602, 3996.1862792969, 62.430797576904)},
}

CreateThread(function()
    for k,v in pairs(blips) do 
        Tree.Function.Blips.create(k, v.coords, v.sprite, v.color, v.name)
    end
end)