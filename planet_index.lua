
-- mapblock granular index of planets
-- for performance improvements on planet-lookups

-- hash(mapblock) => planet
local index = {}

local function lookup_planet(pos)
  for _, planet in ipairs(planetoidgen.planets) do
    local radius = planet.radius + (planet.airshell_radius or planetoidgen.default_air_shell_radius)
    local distance_to_center = vector.distance(pos, planet.pos)

    if distance_to_center <= (radius + 16) then
      return planet
    end
  end
end

function planetoidgen.get_planet_at_pos(pos)
  local mapblock_pos = vector.round(vector.divide(pos, 16))
  local hash = minetest.hash_node_position(mapblock_pos)
  if index[hash] == nil then
    -- lookup planet and cache it
    index[hash] = lookup_planet(pos) or false
  end

  -- return value from cache
  return index[hash]
end
