

-- deep space
skybox.register({
	-- https://github.com/Ezhh/other_worlds/blob/master/skybox.lua
	name = "deepspace",
	miny = 6001,
	maxy = 10999,
	always_day = true,
	fly = true,
	textures = {
		"sky_pos_z.png",
		"sky_neg_z.png^[transformR180",
		"sky_neg_y.png^[transformR270",
		"sky_pos_y.png^[transformR270",
		"sky_pos_x.png^[transformR270",
		"sky_neg_x.png^[transformR90"
	}
})

local col = "^[colorize:#7476F2:" .. 20

skybox.register({
	-- https://github.com/Ezhh/other_worlds/blob/master/skybox.lua
	name = "deepspace_planet",
	always_day = true,
	fly = true,
	match = function(_, pos)
		local planet = planetoidgen.get_planet_at_pos(pos)
		if planet then
			local distance = vector.distance(pos, planet.pos)

			if distance < planet.radius then
				return true
			end
		end
	end,
	priority = 1,
	textures = {
		"sky_pos_z.png" .. col,
		"sky_neg_z.png^[transformR180" .. col,
		"sky_neg_y.png^[transformR270" .. col,
		"sky_pos_y.png^[transformR270" .. col,
		"sky_pos_x.png^[transformR270" .. col,
		"sky_neg_x.png^[transformR90" .. col
	}
})
