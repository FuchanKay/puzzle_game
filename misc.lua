processCoords = function(x, y, z)
    if x and y and z then return x.." "..y.." "..z
    elseif type(x) == "table" then return x[1].." "..x[2].." "..x[3] end
end