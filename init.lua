
planetoidgen = {
	planets = {}, -- list<planet>
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

dofile(MP.."/planettypes/classh.lua")
dofile(MP.."/planettypes/classp.lua")
dofile(MP.."/planettypes/classm.lua")
dofile(MP.."/planettypes/classn.lua")
dofile(MP.."/planettypes/sun.lua")
dofile(MP.."/planettypes/dyson-sphere.lua")

if minetest.get_modpath("skybox") then
	dofile(MP.."/skybox.lua")
end

print("[OK] Planetoidgen")
