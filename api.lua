
-- add a new planetoid
function planetoidgen.register_planet(planet_def)
  table.insert(planetoidgen.planets, planet_def)
end

-- add new planet-type
-- fn(planet, minp, maxp)
function planetoidgen.register_planet_type(type, fn)
  planetoidgen.planettypes[type] = fn
end
