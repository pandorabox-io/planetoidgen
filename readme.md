
This mod generates planetoids at predefined positions

## Planet types

See: https://en.wikipedia.org/wiki/Star_Trek_planet_classification

* `class-m` earth like, flat (various dirt top layers and stone body)
* `class-n` all stone, flat
* `class-h` desert planet (desert-sand top layer and desert-sandstone body)
* `class-p` ice planet (snowblock top layer and ice body)
* `sun` single lava-like node

## Api

### planetoidgen.register_planet

Registers a planet with type, size and position:
```lua
planetoidgen.register_planet({
  pos = { x=2500, y=7500, z=2500 },
  name = "my-planet",
  type = "class-m",
  radius = 300,
  airshell = true
})
```

# TODO

* [ ] dyson sphere "planet" (sun core, outer shell with dirt and cobble/stone)
