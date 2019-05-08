
planetoidgen = {
	miny = tonumber(minetest.settings:get("planetoidgen.miny")) or 6000,
	maxy = tonumber(minetest.settings:get("planetoidgen.maxy")) or 10000,
  planets = {}
}


local MP = minetest.get_modpath("planetoidgen")

dofile(MP.."/planets.lua")
dofile(MP.."/override.lua")
dofile(MP.."/mapgen.lua")

print("[OK] Planetoidgen")
