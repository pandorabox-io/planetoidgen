planetoidgen.register_planet({
  pos = { x=2500, y=7500, z=2500 },
  name = "my-planet",
  type = "class-m",
  radius = 50,
  airshell = true,
  airshell_radius = 10
})

planetoidgen.register_planet({
  pos = { x=-2500, y=7500, z=-2500 },
  name = "my-planet 2",
  type = "class-m",
  radius = 500,
  airshell = true,
  airshell_radius = 100
})

-- unnamed system
planetoidgen.register_planet({
  pos = { x = 9000, y = 9500, z = 5000 },
  radius = 400, type = "sun", name = "system-2 sun"
})
planetoidgen.register_planet({
  pos = { x = 9000, y = 9500, z = 6000 },
  radius = 300, type = "class-p", name = "system-2 top", airshell = true
})
planetoidgen.register_planet({
  pos = { x = 9866, y = 9500, z = 5500 },
  radius = 300, type = "class-m", name = "system-2 top-right", airshell = true
})
planetoidgen.register_planet({
  pos = { x = 9866, y = 9500, z = 4500 },
  radius = 300, type = "class-m", name = "system-2 bottom-right", airshell = true
})
planetoidgen.register_planet({
  pos = { x = 9000, y = 9500, z = 4000 },
  radius = 300, type = "class-h", name = "system-2 bottom desert", airshell = true
})
planetoidgen.register_planet({
  pos = { x = 8134, y = 9500, z = 4500 },
  radius = 300, type = "class-m", name = "system-2 bottom-left", airshell = true
})
planetoidgen.register_planet({
  pos = { x = 8134, y = 9500, z = 5500 },
  radius = 300, type = "class-m", name = "system-2 top-left", airshell = true
})
