
local save_data = function()

   local data = minetest.write_json(planetoids.planets, true);
   local path = minetest.get_worldpath().."/planets.json";

   local file = io.open( path, "w" );
   if( file ) then
      file:write(data);
      file:close();
   else
      print(S("[Planetoidgen] Error: Savefile '%s' could not be written."):format(tostring(path)));
   end
end


local load_data = function()
  local path = minetest.get_worldpath().."/planets.json";

  local file = io.open( path, "r" );
  if( file ) then
    local data = file:read("*all");
    local planets = minetest.parse_json(data);
    file:close();

    if planets then
      planetoidgen.planets = planets

      local count = 0
      for _, planet in ipairs(planets) do
        print("[Planetoidgen] Planet '" .. planet.name .. "', pos: " .. minetest.pos_to_string(planet.pos) ..
          ", type: " .. planet.type .. ", radius: " .. planet.radius)
        count = count + 1
      end

      print("[Planetoidgen] Loaded " .. count .. " planets")
    else
      return false
    end
  else
    print(S("[Planetoidgen] Error: Savefile '%s' not found."):format(tostring(path)));
  end

  return true
end

load_data()


minetest.register_chatcommand("planetoidgen_reload", {
  description = "reload planets.json",
  privs = { server = true },
  func = function(name, param)
    if load_data() then
      return true, "reload successful"
    else
      return true, "error, could not load planets.json"
    end
  end
})
