local c_ignore = minetest.get_content_id("ignore")
local c_air = minetest.get_content_id("air")

local c_shell = minetest.get_content_id("default:stone")
local c_top = minetest.get_content_id("default:dirt_with_grass")


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

			if distance < p.radius then
				planet = p
			end
		end
	end

	-- check if a planet is defined here
	if not planet then
		return
	end

	local t0 = minetest.get_us_time()

	local vm, emin, emax = minetest.get_mapgen_object("voxelmanip")
	local data = vm:get_data()
	local area = VoxelArea:new{MinEdge=emin, MaxEdge=emax}

	for i in area:iter(
		minp.x, minp.y, minp.z,
		maxp.x, maxp.y, maxp.z
	) do
		if data[i] == c_air or data[i] == c_ignore then
			local pos = area:position(i)
			local distance_to_center = vector.distance(pos, planet.pos)

			-- check if inside radius
			if distance_to_center <= planet.radius then

				local is_outer_shell = pos.y < planet.pos.y
				local is_top = pos.y == planet.pos.y

				if is_outer_shell then
					data[i] = c_shell

				elseif is_top then
					data[i] = c_top

				end

			end -- distance check
		end -- air check
	end -- iter

	if minp.y < planet.pos.y then
		print("[planetoidgen] generating ores for " .. minetest.pos_to_string(minp))
		-- generate ores
		minetest.generate_ores(vm, minp, {
			x = maxp.x,
			y = math.min(maxp.y, planet.pos.y-1),
			z = maxp.z
		})

	end
	if minp.y <= planet.pos.y and maxp.y >= planet.pos.y then
		print("[planetoidgen] generating decos for " .. minetest.pos_to_string(minp))
		-- generate decorations
		minetest.generate_decorations(vm, {
			x = minp.x, y = planet.pos.y-20, z=minp.z
		}, {
			x = maxp.x, y = planet.pos.y+10, z=maxp.z
		})

	end

	vm:set_data(data)
	vm:write_to_map()

	local t1 = minetest.get_us_time()
	local micros = t1 -t0

	if planetoidgen.profile_mapgen then
		print("[planetoidgen] mapgen for " .. minetest.pos_to_string(minp) .. " took " .. micros .. " us")
	end

end)
