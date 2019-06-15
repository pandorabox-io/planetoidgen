
local c_ignore = minetest.get_content_id("ignore")
local c_air = minetest.get_content_id("air")
local c_sun = minetest.get_content_id("planetoidgen:sun")


planetoidgen.planettypes["sun"] = function(planet, minp, maxp, seed)

	local vm, emin, emax = minetest.get_mapgen_object("voxelmanip")
	local data = vm:get_data()
	local area = VoxelArea:new{MinEdge=emin, MaxEdge=emax}

	for z=minp.z,maxp.z do
	for x=minp.x,maxp.x do
	for y=minp.y,maxp.y do
		local i = area:index(x,y,z)

		local pos = area:position(i)
		local distance_to_center = vector.distance(pos, planet.pos)

		-- check if inside radius
		if distance_to_center <= planet.radius then
      data[i] = c_sun
		end -- distance check
  end--y
  end--x
	end--z


	vm:set_data(data)

	vm:set_lighting({day=15, night=0})
	vm:write_to_map()
end
