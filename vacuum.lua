local has_vacuum_mod = minetest.get_modpath("vacuum")


if has_vacuum_mod then

  local old_is_pos_in_space = vacuum.is_pos_in_space
  vacuum.is_pos_in_space = function(pos)
    for _, planet in ipairs(planetoidgen.planets) do
      local distance = vector.distance(pos, planet.pos)

      if distance < planet.radius+80 then
        -- planet is here, not space (plus safety margin for air shell)
        return false
      end
    end

    return old_is_pos_in_space(pos)
  end

  local old_no_vacuum_abm = vacuum.no_vacuum_abm
  vacuum.no_vacuum_abm = function(pos)
    for _, planet in ipairs(planetoidgen.planets) do
      local distance = vector.distance(pos, planet.pos)

      if distance < planet.radius+10 and distance > planet.radius-10 then
        -- no air/vacuum interaction at planet boundary
        return true
      end
    end

    return old_no_vacuum_abm(pos)
  end

end
