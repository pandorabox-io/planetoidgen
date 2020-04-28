local old_is_pos_in_space = vacuum.is_pos_in_space
vacuum.is_pos_in_space = function(pos)
  local planet = planetoidgen.get_planet_at_pos(pos, 160)
  if planet then
    if planet.airshell then
      return false
    else
      -- no airshell == space
      return true
    end
  end

  return old_is_pos_in_space(pos)
end
