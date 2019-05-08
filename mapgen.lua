

minetest.register_on_generated(function(minp, maxp, seed)

	-- default from 6k to 10k
	if minp.y < planetoidgen.miny or minp.y > planetoidgen.maxy then
		return
	end


	local vm, emin, emax = minetest.get_mapgen_object("voxelmanip")
	local area = VoxelArea:new{MinEdge=emin, MaxEdge=emax}

  -- TODO

	vm:write_to_map()

end)
