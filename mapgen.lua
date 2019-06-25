

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

	local t0 = minetest.get_us_time()


	-- search for a planet in range
	local planet
	for _, pos in ipairs(get_corners(minp, maxp)) do
		for _, p in ipairs(planetoidgen.planets) do
			local distance = vector.distance(pos, p.pos)

			if distance < p.radius then
				-- planet in range
				local planetgenfn = planetoidgen.planettypes[planet.type]
				if not planetgenfn then
					minetest.log("warning", "[planetoidgen] generator not found for type: " .. planet.type)
				else
					planetgenfn(planet, minp, maxp, seed)
				end
			end
		end
	end

	local t1 = minetest.get_us_time()
	local micros = t1 -t0

	minetest.log("action", "[planetoidgen] mapgen for " .. minetest.pos_to_string(minp) .. ", type: " .. planet.type .. " took " .. micros .. " us")

end)
