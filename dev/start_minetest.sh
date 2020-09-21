#!/bin/sh

test -d worldmods || mkdir worldmods
test -d worldmods/vacuum || git clone https://github.com/mt-mods/vacuum.git worldmods/vacuum
test -d worldmods/skybox || git clone https://github.com/pandorabox-io/skybox.git worldmods/skybox
test -d worldmods/scifi_nodes || git clone https://github.com/D00Med/scifi_nodes.git worldmods/scifi_nodes

docker run --rm -it \
	-u root:root \
	-v $(pwd)/minetest.conf:/etc/minetest/minetest.conf \
	-v $(pwd)/worldmods:/root/.minetest/worlds/world/worldmods \
	-v $(pwd)/custom_planets:/root/.minetest/worlds/world/worldmods/custom_planets \
	-v $(pwd)/../:/root/.minetest/worlds/world/worldmods/planetoidgen \
	-v $(pwd)/data:/root/.minetest/worlds/world \
	--network host \
	registry.gitlab.com/minetest/minetest/server:5.3.0
