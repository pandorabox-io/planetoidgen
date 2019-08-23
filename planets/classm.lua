
local c_ignore = minetest.get_content_id("ignore")
local c_air = minetest.get_content_id("air")
local c_shell = minetest.get_content_id("default:stone")
local c_dirt_with_grass = minetest.get_content_id("default:dirt_with_grass")
local c_dirt_with_rainforest_litter = minetest.get_content_id("default:dirt_with_rainforest_litter")
local c_dirt_with_dry_grass = minetest.get_content_id("default:dirt_with_dry_grass")
local c_dirt_with_coniferous_litter = minetest.get_content_id("default:dirt_with_coniferous_litter")
local c_dirt_with_snow = minetest.get_content_id("default:dirt_with_snow")
local c_sand = minetest.get_content_id("default:sand")


local noise_params = {
	offset = 0,
	scale = 5,
	spread = {x=256, y=256, z=256},
	seed = 5477835,
	octaves = 2,
	persist = 0.5
}

local perlin
local perlin_map = {}



planetoidgen.planettypes["class-m"] = function(planet, minp, maxp)

  -- setup perlin stuff
	local side_length = maxp.x - minp.x + 1 -- 80
	local map_lengths_xyz = {x=side_length, y=side_length, z=side_length}
	perlin = perlin or minetest.get_perlin_map(noise_params, map_lengths_xyz)
	perlin:get_2d_map_flat({x=minp.x, y=minp.z}, perlin_map)
	local perlin_index = 1


	local vm, emin, emax = minetest.get_mapgen_object("voxelmanip")
	local data = vm:get_data()
	local area = VoxelArea:new{MinEdge=emin, MaxEdge=emax}

	for z=minp.z,maxp.z do
	for x=minp.x,maxp.x do

		-- normalized factor from 0...1
		local perlin_factor = math.min(1, math.abs( perlin_map[perlin_index] * 0.1 ) )

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
						if perlin_factor > 0.9 then
							data[i] = c_sand
						elseif perlin_factor > 0.7 then
							data[i] = c_dirt_with_dry_grass
						elseif perlin_factor > 0.5 then
							data[i] = c_dirt_with_coniferous_litter
						elseif perlin_factor > 0.4 then
							data[i] = c_dirt_with_rainforest_litter
						elseif perlin_factor > 0.1 then
							data[i] = c_dirt_with_grass
						else
							data[i] = c_dirt_with_snow
						end

					end

				end -- distance check
			end -- air check
		end--y

		perlin_index = perlin_index + 1

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
