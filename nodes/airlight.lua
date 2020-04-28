
minetest.register_node("planetoidgen:airlight", {
	description = "Air (with light)",
	inventory_image = "air.png",
	wield_image = "air.png",
	drawtype = "airlike",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	pointable = false,
	diggable = false,
	buildable_to = true,
	floodable = true,
	air_equivalent = true,
	drop = "",
	groups = {not_in_creative_inventory=1, not_blocking_trains=1},
	light_source = minetest.LIGHT_MAX
})
