
-- returns true if pos occupied (with safety margin)
planetoidgen.is_occupied = function(pos)
  for _, planet in ipairs(planetoidgen.planets) do
    local distance = vector.distance(pos, planet.pos)

    if distance < planet.radius+500 then
      -- planet is here
      return true
    end
  end

  return false
end
