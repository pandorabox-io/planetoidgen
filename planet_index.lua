
-- mapblock granular index of planets
-- for performance improvements on planet-lookups

-- hash(mapblock) => planet
local index = {}

-- generates the spatial index for a single planet
function planetoidgen.generate_index(planet)
  local radius = planet.radius + (planet.airshell_radius or planetoidgen.default_air_shell_radius)
  local min_mapblock = vector.round(vector.divide(vector.subtract(planet.pos, radius), 16))
  local max_mapblock = vector.round(vector.divide(vector.add(planet.pos, radius), 16))

  -- iterate over possible mapblock positions and set index
  for x=min_mapblock.x, max_mapblock.x do
    for y=min_mapblock.y, max_mapblock.y do
      for z=min_mapblock.z, max_mapblock.z do
        -- current mapblock
        local mapblock_pos = {x=x, y=y, z=z}

        -- calculate node position
        local pos = vector.multiply(mapblock_pos, 16)

        -- checks its distance to the center
        local distance_to_center = vector.distance(pos, planet.pos)
        local is_in_sphere_range = distance_to_center < (radius + 16)

        -- TODO: implement for other possible shapes (other than spheres)
        if is_in_sphere_range then
          -- mapblock is in the planet sphere, add to index
          local hash = minetest.hash_node_position(mapblock_pos)
          index[hash] = planet
        end

      end --z
    end --y
  end --x
end

function planetoidgen.get_planet_at_pos(pos)
  local mapblock_pos = vector.round(vector.divide(pos, 16))
  local hash = minetest.hash_node_position(mapblock_pos)

  return index[hash]
end
