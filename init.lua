
planetoidgen = {
	miny = tonumber(minetest.settings:get("planetoidgen.miny")) or 6000,
	maxy = tonumber(minetest.settings:get("planetoidgen.maxy")) or 10000,
  planets = {},
	planettypes = {} -- type => fn
}


local MP = minetest.get_modpath("planetoidgen")

dofile(MP.."/planets.lua")
dofile(MP.."/vacuum.lua")
dofile(MP.."/mapgen.lua")

dofile(MP.."/nodes/sun.lua")

dofile(MP.."/planets/classh.lua")
dofile(MP.."/planets/classp.lua")
dofile(MP.."/planets/classm.lua")
dofile(MP.."/planets/sun.lua")

print("[OK] Planetoidgen")
