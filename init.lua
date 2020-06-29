
planetoidgen = {
	planets = {},
	planettypes = {} -- type => fn
}


local MP = minetest.get_modpath("planetoidgen")

dofile(MP.."/planet_index.lua")
dofile(MP.."/api.lua")

if minetest.get_modpath("vacuum") then
	dofile(MP.."/vacuum.lua")
end

dofile(MP.."/mapgen.lua")

dofile(MP.."/nodes/sun.lua")
dofile(MP.."/nodes/airlight.lua")

dofile(MP.."/planets/classh.lua")
dofile(MP.."/planets/classp.lua")
dofile(MP.."/planets/classm.lua")
dofile(MP.."/planets/classn.lua")
dofile(MP.."/planets/sun.lua")
dofile(MP.."/planets/dyson-sphere.lua")

if minetest.get_modpath("skybox") then
	dofile(MP.."/skybox.lua")
end

print("[OK] Planetoidgen")
