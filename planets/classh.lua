
local c_ignore = minetest.get_content_id("ignore")
local c_air = minetest.get_content_id("air")
local c_shell = minetest.get_content_id("default:desert_sandstone")
local c_sand = minetest.get_content_id("default:desert_sand")


planetoidgen.planettypes["class-h"] = function(planet, minp, maxp)

	local vm, emin, emax = minetest.get_mapgen_object("voxelmanip")
	local data = vm:get_data()
	local area = VoxelArea:new{MinEdge=emin, MaxEdge=emax}

	for z=minp.z,maxp.z do
	for x=minp.x,maxp.x do
	for y=minp.y,maxp.y do
			local i = area:index(x,y,z)

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
						data[i] = c_sand

					end

				end -- distance check
			end -- air check
	end--y
	end--x
	end--z


	vm:set_data(data)

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

	vm:set_lighting({day=15, night=0})
	vm:write_to_map()
end
