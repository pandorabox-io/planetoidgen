
planetoidgen = {
	planets = {},
	planettypes = {} -- type => fn
}


local MP = minetest.get_modpath("planetoidgen")

dofile(MP.."/planets.lua")
dofile(MP.."/api.lua")
dofile(MP.."/vacuum.lua")
dofile(MP.."/mapgen.lua")

dofile(MP.."/nodes/sun.lua")

dofile(MP.."/planets/classh.lua")
dofile(MP.."/planets/classp.lua")
dofile(MP.."/planets/classm.lua")
dofile(MP.."/planets/classn.lua")
dofile(MP.."/planets/sun.lua")

if minetest.get_modpath("skybox") then
	dofile(MP.."/skybox.lua")
end

print("[OK] Planetoidgen")
