
--[[
planetoidgen.register_planet({
  pos = { x=2500, y=7500, z=2500 },
  name = "xy",
  type = "dyson-sphere",
  radius = 2000,
  sun_radius = 50,
  airshell = true
})
--]]


local c_sun = minetest.get_content_id("planetoidgen:sun")
local c_dirt = minetest.get_content_id("default:dirt")
local c_stone = minetest.get_content_id("default:stone")
local c_air = minetest.get_content_id("air")
local c_airlight = minetest.get_content_id("planetoidgen:airlight")


planetoidgen.planettypes["dyson-sphere"] = function(planet, minp, maxp)

	local vm, emin, emax = minetest.get_mapgen_object("voxelmanip")
	local data = vm:get_data()
	local area = VoxelArea:new{MinEdge=emin, MaxEdge=emax}

  -- apply defaults
  planet.sun_radius = planet.sun_radius or 50

  -- dirt starts from here outward
  local dirt_radius = planet.radius - 50

  -- shell material starts from here outward
  local shell_radius = planet.radius - 20

  local enable_decorations = false
  local enable_ores = false

	for z=minp.z,maxp.z do
	for x=minp.x,maxp.x do
	for y=minp.y,maxp.y do
		local i = area:index(x,y,z)

		local pos = area:position(i)
		local distance_to_center = vector.distance(pos, planet.pos)

    if distance_to_center > shell_radius then
      -- shell
      data[i] = c_stone
      enable_decorations = true
    elseif distance_to_center > dirt_radius then
      -- dirt
      data[i] = c_dirt
      enable_decorations = true
    elseif distance_to_center > planet.sun_radius then
      -- air
      if math.random(0, 5) == 1 then
        -- light source
        data[i] = c_airlight
      else
        -- normal air
        data[i] = c_air
      end
    else
      -- sun
      data[i] = c_sun
    end

  end--y
  end--x
	end--z

  if enable_decorations then
    minetest.generate_decorations(vm, minp, maxp)
  end

  if enable_ores then
    minetest.generate_ores(vm, minp, maxp)
  end

	vm:set_data(data)

	vm:set_lighting({day=15, night=0})
	vm:write_to_map()
end
