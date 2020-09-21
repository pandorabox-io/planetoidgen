
-- returns true if pos occupied (with safety margin)
function planetoidgen.is_occupied(pos)
  local planet = planetoidgen.get_planet_at_pos(pos, 500)
  if planet then
    -- planet is here
    return true
  end

  return false
end

-- add a new planetoid
function planetoidgen.register_planet(planet_def)
  table.insert(planetoidgen.planets, planet_def)
  planetoidgen.generate_index(planet_def)
end

-- add new planet-type
-- fn(planet, minp, maxp)
function planetoidgen.register_planet_type(type, fn)
  planetoidgen.planettypes[type] = fn
end
