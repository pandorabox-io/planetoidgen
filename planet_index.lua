
-- simple 1-dimensional spatial index
-- for performance improvements on planet-lookups

-- mapblock_x -> list[planets]
local index = {}

-- generates the spatial index for a single planet
function planetoidgen.generate_index(planet)
  local min_x = planet.pos.x - planet.radius
  local max_x = planet.pos.x + planet.radius

  local mapblock_min_x = math.floor(min_x / 16)
  local mapblock_max_x = math.floor(max_x / 16)

  for mapblock_x = mapblock_min_x, mapblock_max_x do
    local stride = index[mapblock_x]
    if not stride then
      stride = {}
      index[mapblock_x] = stride
    end
    table.insert(stride, planet);
  end
end

function planetoidgen.get_planet_at_pos(pos, margin)
  local mapblock_x = math.floor(pos.x / 16)
  local stride = index[mapblock_x]
  if not stride then
    -- nothing here
    return
  end

  -- default to 0 marging (exact position)
  margin = margin or 0

  for _, planet in ipairs(stride) do
    local distance = vector.distance(pos, planet.pos)
    if distance < planet.radius+margin then
      -- planet found
      return planet
    end
  end
end
