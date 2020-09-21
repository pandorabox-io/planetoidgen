
minetest.register_chatcommand("planet_info", {
	func = function(name)
    local player = minetest.get_player_by_name(name)
    local pos = player:get_pos()
    local planet = planetoidgen.get_planet_at_pos(pos)

    if not planet then
      return true, "No planet found here!"
    else
      return true, dump(planet)
    end
  end
})
