

local get_corners = function(minp, maxp)
	return {
		minp,
		maxp,
		{ x=maxp.x, y=minp.y, z=minp.z },
		{ x=minp.x, y=maxp.y, z=minp.z },
		{ x=minp.x, y=minp.y, z=maxp.z },
		{ x=maxp.x, y=maxp.y, z=minp.z },
		{ x=minp.x, y=maxp.y, z=maxp.z },
		{ x=maxp.x, y=minp.y, z=maxp.z },
	}
end

minetest.register_on_generated(function(minp, maxp, seed)

	-- default from 6k to 10k
	if minp.y < planetoidgen.miny or minp.y > planetoidgen.maxy then
		return
	end

	-- search for a planet in range
	local planet
	for _, pos in ipairs(get_corners(minp, maxp)) do
		for _, p in ipairs(planetoidgen.planets) do
			local distance = vector.distance(pos, p.pos)

			if distance < planet.radius then
				planet = p
			end
		end
	end

	-- check if a planet is defined here
	if not planet then
		return
	end


	local vm, emin, emax = minetest.get_mapgen_object("voxelmanip")
	local area = VoxelArea:new{MinEdge=emin, MaxEdge=emax}

  -- TODO

	vm:write_to_map()

end)
