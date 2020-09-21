local old_is_pos_in_space = vacuum.is_pos_in_space
vacuum.is_pos_in_space = function(pos)
  local planet = planetoidgen.get_planet_at_pos(pos)
  if planet then
    if planet.airshell then
      -- calculate air-shell with node-precision
      -- mapgen rounds up to mapblocks, abm-vacuum-propagation will smooth it out

      -- default to 160 nodes airshell around planet
      local airshell_radius = planet.airshell_radius or planetoidgen.default_air_shell_radius
      local distance_to_center = vector.distance(pos, planet.pos)

      -- true if outside of airshell
      return distance_to_center > (planet.radius + airshell_radius)
    else
      -- no airshell == space
      return true
    end
  end

  return old_is_pos_in_space(pos)
end
