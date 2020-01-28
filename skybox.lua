

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

for i=1,5 do
 local col = "^[colorize:#0000FF:" .. i * 10

	skybox.register({
		-- https://github.com/Ezhh/other_worlds/blob/master/skybox.lua
		name = "deepspace_" .. i,
		always_day = true,
		fly = true,
		match = function(_, pos)
			for _, p in ipairs(planetoidgen.planets) do
				local distance = vector.distance(pos, p.pos)

				if distance < p.radius then
					local factor = distance / p.radius
					if factor < 0.5 and i == 5 or
						factor < 0.6 and i == 4 or
						factor < 0.7 and i == 3 or
						factor < 0.8 and i == 2 or
						factor < 1 and i == 1
					then
						return true
					end
				end
			end
		end,
		priority = i,
		textures = {
			"sky_pos_z.png" .. col,
			"sky_neg_z.png^[transformR180" .. col,
			"sky_neg_y.png^[transformR270" .. col,
			"sky_pos_y.png^[transformR270" .. col,
			"sky_pos_x.png^[transformR270" .. col,
			"sky_neg_x.png^[transformR90" .. col
		}
	})
end
