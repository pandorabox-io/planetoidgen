
-- returns true if pos occupied (with safety margin)
function planetoidgen.is_occupied(pos)
  for _, planet in ipairs(planetoidgen.planets) do
    local distance = vector.distance(pos, planet.pos)

    if distance < planet.radius+500 then
      -- planet is here
      return true
    end
  end

  return false
end

-- add a new planetoid
function planetoidgen.register_planet(planet_def)
  table.insert(planetoidgen.planets, planet_def)
end
