mcstair = {}

local get_stair_param = function(node)
	local stair = minetest.get_item_group(node.name, "stair")
	local param = (node.param2 % 32) % 24
	if stair == 0 or (param > 3 and param < 20) then
		return
	elseif stair == 1 then
		return param
	elseif stair == 2 then
		if param < 12 then
			return param + 4
		else
			return param - 4
		end
	elseif stair == 3 then
		if param < 12 then
			return param + 8
		else
			return param - 8
		end
	end
end

function mcstair.register(subname)
	local node_def = minetest.registered_nodes["stairs:stair_"..subname]
	if node_def == nil then
		minetest.log("error", "mcstair: Can not register \"stairs:stair_"..subname.."\". Node not found in registered nodes.")
		return
	end
	local outer_groups = table.copy(node_def.groups)
	outer_groups.not_in_creative_inventory = 1
	local inner_groups = table.copy(outer_groups)
	outer_groups.stair = 2
	inner_groups.stair = 3
	local drop = node_def.drop or "stairs:stair_"..subname
	minetest.override_item("stairs:stair_"..subname, {
		after_place_node = function(pos, placer, itemstack, pointed_thing)
			local node = minetest.get_node(pos)
			if node.param2 == 0 then
				local param = get_stair_param(minetest.get_node({x = pos.x, y = pos.y, z = pos.z + 1}))
				if param then
					if param == 3 or param == 7 or param == 8 then
						local param = get_stair_param(minetest.get_node({x = pos.x + 1, y = pos.y, z = pos.z}))
						if not param or (param ~= 0 and param ~= 4 and param ~= 9) then
							minetest.swap_node(pos, {name = "stairs:stair_outer_"..subname, param2 = 0})
							return
						end
					elseif param == 1 or param == 6 or param == 9 then
						local param = get_stair_param(minetest.get_node({x = pos.x - 1, y = pos.y, z = pos.z}))
						if not param or (param ~= 0 and param ~= 5 and param ~= 8) then
							minetest.swap_node(pos, {name = "stairs:stair_outer_"..subname, param2 = 1})
							return
						end
					end
				end
				local param = get_stair_param(minetest.get_node({x = pos.x, y = pos.y, z = pos.z - 1}))
				if param then
					if param == 1 or param == 5 or param == 10 then
						local param = get_stair_param(minetest.get_node({x = pos.x + 1, y = pos.y, z = pos.z}))
						if not param or (param ~= 0 and param ~= 4 and param ~= 9) then
							minetest.swap_node(pos, {name = "stairs:stair_inner_"..subname, param2 = 1})
							return
						end
					elseif param == 3 or param == 4 or param == 11 then
						local param = get_stair_param(minetest.get_node({x = pos.x - 1, y = pos.y, z = pos.z}))
						if not param or (param ~= 0 and param ~= 5 and param ~= 8) then
							minetest.swap_node(pos, {name = "stairs:stair_inner_"..subname, param2 = 0})
							return
						end
					end
				end
			elseif node.param2 == 1 then
				local param = get_stair_param(minetest.get_node({x = pos.x + 1, y = pos.y, z = pos.z}))
				if param then
					if param == 2 or param == 7 or param == 10 then
						local param = get_stair_param(minetest.get_node({x = pos.x, y = pos.y, z = pos.z + 1}))
						if not param or (param ~= 1 and param ~= 6 and param ~= 9) then
							minetest.swap_node(pos, {name = "stairs:stair_outer_"..subname, param2 = 2})
							return
						end
					elseif param == 0 or param == 4 or param == 9 then
						local param = get_stair_param(minetest.get_node({x = pos.x, y = pos.y, z = pos.z - 1}))
						if not param or (param ~= 1 and param ~= 5 and param ~= 10) then
							minetest.swap_node(pos, {name = "stairs:stair_outer_"..subname, param2 = 1})
							return
						end
					end
				end
				local param = get_stair_param(minetest.get_node({x = pos.x - 1, y = pos.y, z = pos.z}))
				if param then
					if param == 0 or param == 5 or param == 8 then
						local param = get_stair_param(minetest.get_node({x = pos.x, y = pos.y, z = pos.z + 1}))
						if not param or (param ~= 1 and param ~= 6 and param ~= 9) then
							minetest.swap_node(pos, {name = "stairs:stair_inner_"..subname, param2 = 1})
							return
						end
					elseif param == 2 or param == 6 or param == 11 then
						local param = get_stair_param(minetest.get_node({x = pos.x, y = pos.y, z = pos.z - 1}))
						if not param or (param ~= 1 and param ~= 5 and param ~= 10) then
							minetest.swap_node(pos, {name = "stairs:stair_inner_"..subname, param2 = 2})
							return
						end
					end
				end
			elseif node.param2 == 2 then
				local param = get_stair_param(minetest.get_node({x = pos.x, y = pos.y, z = pos.z + 1}))
				if param then
					if param == 1 or param == 6 or param == 9 then
						local param = get_stair_param(minetest.get_node({x = pos.x + 1, y = pos.y, z = pos.z}))
						if not param or (param ~= 2 and param ~= 7 and param ~= 10) then
							minetest.swap_node(pos, {name = "stairs:stair_inner_"..subname, param2 = 2})
							return
						end
					elseif param == 3 or param == 7 or param == 8 then
						local param = get_stair_param(minetest.get_node({x = pos.x - 1, y = pos.y, z = pos.z}))
						if not param or (param ~= 2 and param ~= 6 and param ~= 11) then
							minetest.swap_node(pos, {name = "stairs:stair_inner_"..subname, param2 = 3})
							return
						end
					end
				end
				local param = get_stair_param(minetest.get_node({x = pos.x, y = pos.y, z = pos.z - 1}))
				if param then
					if param == 3 or param == 4 or param == 11 then
						local param = get_stair_param(minetest.get_node({x = pos.x + 1, y = pos.y, z = pos.z}))
						if not param or (param ~= 2 and param ~= 7 and param ~= 10) then
							minetest.swap_node(pos, {name = "stairs:stair_outer_"..subname, param2 = 3})
							return
						end
					elseif param == 1 or param == 5 or param == 10 then
						local param = get_stair_param(minetest.get_node({x = pos.x - 1, y = pos.y, z = pos.z}))
						if not param or (param ~= 2 and param ~= 6 and param ~= 11) then
							minetest.swap_node(pos, {name = "stairs:stair_outer_"..subname, param2 = 2})
							return
						end
					end
				end
			elseif node.param2 == 3 then
				local param = get_stair_param(minetest.get_node({x = pos.x + 1, y = pos.y, z = pos.z}))
				if param then
					if param == 0 or param == 4 or param == 9 then
						local param = get_stair_param(minetest.get_node({x = pos.x, y = pos.y, z = pos.z + 1}))
						if not param or (param ~= 3 and param ~= 7 and param ~= 8) then
							minetest.swap_node(pos, {name = "stairs:stair_inner_"..subname, param2 = 0})
							return
						end
					elseif param == 2 or param == 7 or param == 10 then
						local param = get_stair_param(minetest.get_node({x = pos.x, y = pos.y, z = pos.z - 1}))
						if not param or (param ~= 3 and param ~= 4 and param ~= 11) then
							minetest.swap_node(pos, {name = "stairs:stair_inner_"..subname, param2 = 3})
							return
						end
					end
				end
				local param = get_stair_param(minetest.get_node({x = pos.x - 1, y = pos.y, z = pos.z}))
				if param then
					if param == 2 or param == 6 or param == 11 then
						local param = get_stair_param(minetest.get_node({x = pos.x, y = pos.y, z = pos.z + 1}))
						if not param or (param ~= 3 and param ~= 7 and param ~= 8) then
							minetest.swap_node(pos, {name = "stairs:stair_outer_"..subname, param2 = 3})
							return
						end
					elseif param == 0 or param == 5 or param == 8 then
						local param = get_stair_param(minetest.get_node({x = pos.x, y = pos.y, z = pos.z - 1}))
						if not param or (param ~= 3 and param ~= 4 and param ~= 11) then
							minetest.swap_node(pos, {name = "stairs:stair_outer_"..subname, param2 = 0})
							return
						end
					end
				end
			elseif node.param2 == 20 then
				local param = get_stair_param(minetest.get_node({x = pos.x, y = pos.y, z = pos.z + 1}))
				if param then
					if param == 21 or param == 18 or param == 13 then
						local param = get_stair_param(minetest.get_node({x = pos.x + 1, y = pos.y, z = pos.z}))
						if not param or (param ~= 20 and param ~= 17 and param ~= 12) then
							minetest.swap_node(pos, {name = "stairs:stair_outer_"..subname, param2 = 21})
							return
						end
					elseif param == 23 or param == 19 or param == 12 then
						local param = get_stair_param(minetest.get_node({x = pos.x - 1, y = pos.y, z = pos.z}))
						if not param or (param ~= 20 and param ~= 16 and param ~= 13) then
							minetest.swap_node(pos, {name = "stairs:stair_outer_"..subname, param2 = 20})
							return
						end
					end
				end
				local param = get_stair_param(minetest.get_node({x = pos.x, y = pos.y, z = pos.z - 1}))
				if param then
					if param == 23 or param == 16 or param == 15 then
						local param = get_stair_param(minetest.get_node({x = pos.x + 1, y = pos.y, z = pos.z}))
						if not param or (param ~= 20 and param ~= 17 and param ~= 12) then
							minetest.swap_node(pos, {name = "stairs:stair_inner_"..subname, param2 = 20})
							return
						end
					elseif param == 21 or param == 17 or param == 14 then
						local param = get_stair_param(minetest.get_node({x = pos.x - 1, y = pos.y, z = pos.z}))
						if not param or (param ~= 20 and param ~= 16 and param ~= 13) then
							minetest.swap_node(pos, {name = "stairs:stair_inner_"..subname, param2 = 21})
							return
						end
					end
				end
			elseif node.param2 == 21 then
				local param = get_stair_param(minetest.get_node({x = pos.x + 1, y = pos.y, z = pos.z}))
				if param then
					if param == 20 or param == 17 or param == 12 then
						local param = get_stair_param(minetest.get_node({x = pos.x, y = pos.y, z = pos.z + 1}))
						if not param or (param ~= 21 and param ~= 18 and param ~= 13) then
							minetest.swap_node(pos, {name = "stairs:stair_inner_"..subname, param2 = 21})
							return
						end
					elseif param == 22 or param == 18 or param == 15 then
						local param = get_stair_param(minetest.get_node({x = pos.x, y = pos.y, z = pos.z - 1}))
						if not param or (param ~= 21 and param ~= 17 and param ~= 14) then
							minetest.swap_node(pos, {name = "stairs:stair_inner_"..subname, param2 = 22})
							return
						end
					end
				end
				local param = get_stair_param(minetest.get_node({x = pos.x - 1, y = pos.y, z = pos.z}))
				if param then
					if param == 22 or param == 19 or param == 14 then
						local param = get_stair_param(minetest.get_node({x = pos.x, y = pos.y, z = pos.z + 1}))
						if not param or (param ~= 21 and param ~= 18 and param ~= 13) then
							minetest.swap_node(pos, {name = "stairs:stair_outer_"..subname, param2 = 22})
							return
						end
					elseif param == 20 or param == 16 or param == 13 then
						local param = get_stair_param(minetest.get_node({x = pos.x, y = pos.y, z = pos.z - 1}))
						if not param or (param ~= 21 and param ~= 17 and param ~= 14) then
							minetest.swap_node(pos, {name = "stairs:stair_outer_"..subname, param2 = 21})
							return
						end
					end
				end
			elseif node.param2 == 22 then
				local param = get_stair_param(minetest.get_node({x = pos.x, y = pos.y, z = pos.z + 1}))
				if param then
					if param == 23 or param == 19 or param == 12 then
						local param = get_stair_param(minetest.get_node({x = pos.x + 1, y = pos.y, z = pos.z}))
						if not param or (param ~= 22 and param ~= 18 and param ~= 15) then
							minetest.swap_node(pos, {name = "stairs:stair_inner_"..subname, param2 = 23})
							return
						end
					elseif param == 21 or param == 18 or param == 13 then
						local param = get_stair_param(minetest.get_node({x = pos.x - 1, y = pos.y, z = pos.z}))
						if not param or (param ~= 22 and param ~= 19 and param ~= 14) then
							minetest.swap_node(pos, {name = "stairs:stair_inner_"..subname, param2 = 22})
							return
						end
					end
				end
				local param = get_stair_param(minetest.get_node({x = pos.x, y = pos.y, z = pos.z - 1}))
				if param then
					if param == 21 or param == 17 or param == 14 then
						local param = get_stair_param(minetest.get_node({x = pos.x + 1, y = pos.y, z = pos.z}))
						if not param or (param ~= 22 and param ~= 18 and param ~= 15) then
							minetest.swap_node(pos, {name = "stairs:stair_outer_"..subname, param2 = 22})
							return
						end
					elseif param == 23 or param == 16 or param == 15 then
						local param = get_stair_param(minetest.get_node({x = pos.x - 1, y = pos.y, z = pos.z}))
						if not param or (param ~= 22 and param ~= 19 and param ~= 14) then
							minetest.swap_node(pos, {name = "stairs:stair_outer_"..subname, param2 = 23})
							return
						end
					end
				end
			elseif node.param2 == 23 then
				local param = get_stair_param(minetest.get_node({x = pos.x + 1, y = pos.y, z = pos.z}))
				if param then
					if param == 22 or param == 18 or param == 15 then
						local param = get_stair_param(minetest.get_node({x = pos.x, y = pos.y, z = pos.z + 1}))
						if not param or (param ~= 23 and param ~= 19 and param ~= 12) then
							minetest.swap_node(pos, {name = "stairs:stair_outer_"..subname, param2 = 23})
							return
						end
					elseif param == 20 or param == 17 or param == 12 then
						local param = get_stair_param(minetest.get_node({x = pos.x, y = pos.y, z = pos.z - 1}))
						if not param or (param ~= 23 and param ~= 16 and param ~= 15) then
							minetest.swap_node(pos, {name = "stairs:stair_outer_"..subname, param2 = 20})
							return
						end
					end
				end
				local param = get_stair_param(minetest.get_node({x = pos.x - 1, y = pos.y, z = pos.z}))
				if param then
					if param == 20 or param == 16 or param == 13 then
						local param = get_stair_param(minetest.get_node({x = pos.x, y = pos.y, z = pos.z + 1}))
						if not param or (param ~= 23 and param ~= 19 and param ~= 12) then
							minetest.swap_node(pos, {name = "stairs:stair_inner_"..subname, param2 = 20})
							return
						end
					elseif param == 22 or param == 19 or param == 14 then
						local param = get_stair_param(minetest.get_node({x = pos.x, y = pos.y, z = pos.z - 1}))
						if not param or (param ~= 23 and param ~= 16 and param ~= 15) then
							minetest.swap_node(pos, {name = "stairs:stair_inner_"..subname, param2 = 23})
							return
						end
					end
				end
			end
		end
	})
	minetest.override_item("stairs:stair_outer_"..subname, {
		groups = outer_groups,
		drop = drop
	})
	minetest.override_item("stairs:stair_inner_"..subname, {
		groups = inner_groups,
		drop = drop
	})
	minetest.clear_craft({output = "stairs:stair_outer_"..subname})
	minetest.clear_craft({output = "stairs:stair_inner_"..subname})
end

---[[ legacy code
local get_stair_from_param = function(param, stairs)
	if param < 12 then
		if param < 4 then
			return {name = stairs[1], param2 = param}
		elseif param < 8 then
			return {name = stairs[2], param2 = param - 4}
		else
			return {name = stairs[3], param2 = param - 8}
		end
	else
		if param >= 20 then
			return {name = stairs[1], param2 = param}
		elseif param >= 16 then
			return {name = stairs[2], param2 = param + 4}
		else
			return {name = stairs[3], param2 = param + 8}
		end
	end
end

local stair_param_to_connect = function(param, ceiling)
	local out = {false, false, false, false, false, false, false, false}
	if not ceiling then
		if param == 0 then
			out[3] = true
			out[8] = true
		elseif param == 1 then
			out[2] = true
			out[5] = true
		elseif param == 2 then
			out[4] = true
			out[7] = true
		elseif param == 3 then
			out[1] = true
			out[6] = true
		elseif param == 4 then
			out[1] = true
			out[8] = true
		elseif param == 5 then
			out[2] = true
			out[3] = true
		elseif param == 6 then
			out[4] = true
			out[5] = true
		elseif param == 7 then
			out[6] = true
			out[7] = true
		elseif param == 8 then
			out[3] = true
			out[6] = true
		elseif param == 9 then
			out[5] = true
			out[8] = true
		elseif param == 10 then
			out[2] = true
			out[7] = true
		elseif param == 11 then
			out[1] = true
			out[4] = true
		end
	else
		if param == 12 then
			out[5] = true
			out[8] = true
		elseif param == 13 then
			out[3] = true
			out[6] = true
		elseif param == 14 then
			out[1] = true
			out[4] = true
		elseif param == 15 then
			out[2] = true
			out[7] = true
		elseif param == 16 then
			out[2] = true
			out[3] = true
		elseif param == 17 then
			out[1] = true
			out[8] = true
		elseif param == 18 then
			out[6] = true
			out[7] = true
		elseif param == 19 then
			out[4] = true
			out[5] = true
		elseif param == 20 then
			out[3] = true
			out[8] = true
		elseif param == 21 then
			out[1] = true
			out[6] = true
		elseif param == 22 then
			out[4] = true
			out[7] = true
		elseif param == 23 then
			out[2] = true
			out[5] = true
		end
	end
	return out
end

local stair_connect_to_param = function(connect, ceiling)
	local param
	if not ceiling then
		if connect[3] and connect[8] then
			param = 0
		elseif connect[2] and connect[5] then
			param = 1
		elseif connect[4] and connect[7] then
			param = 2
		elseif connect[1] and connect[6] then
			param = 3
		elseif connect[1] and connect[8] then
			param = 4
		elseif connect[2] and connect[3] then
			param = 5
		elseif connect[4] and connect[5] then
			param = 6
		elseif connect[6] and connect[7] then
			param = 7
		elseif connect[3] and connect[6] then
			param = 8
		elseif connect[5] and connect[8] then
			param = 9
		elseif connect[2] and connect[7] then
			param = 10
		elseif connect[1] and connect[4] then
			param = 11
		end
	else
		if connect[5] and connect[8] then
			param = 12
		elseif connect[3] and connect[6] then
			param = 13
		elseif connect[1] and connect[4] then
			param = 14
		elseif connect[2] and connect[7] then
			param = 15
		elseif connect[2] and connect[3] then
			param = 16
		elseif connect[1] and connect[8] then
			param = 17
		elseif connect[6] and connect[7] then
			param = 18
		elseif connect[4] and connect[5] then
			param = 19
		elseif connect[3] and connect[8] then
			param = 20
		elseif connect[1] and connect[6] then
			param = 21
		elseif connect[4] and connect[7] then
			param = 22
		elseif connect[2] and connect[5] then
			param = 23
		end
	end
	return param
end

function mcstair.add(name, stairtiles)
	local node_def = minetest.registered_nodes[name]
	if node_def == nil then
		minetest.log("error", "mcstair: Can not register \""..name.."\". Node not found in registered nodes.")
		return
	end
	local outer_tiles
	local inner_tiles
	if stairtiles then
		outer_tiles = stairtiles[1]
		inner_tiles = stairtiles[2]
	else
		outer_tiles = node_def.tiles
		inner_tiles = node_def.tiles
	end
	local outer_groups = table.copy(node_def.groups)
	outer_groups.not_in_creative_inventory = 1
	local inner_groups = table.copy(outer_groups)
	outer_groups.stair = 2
	inner_groups.stair = 3
	local drop = node_def.drop or name
	local after_dig_node = function(pos, oldnode)
		local param = get_stair_param(oldnode)
		local ceiling
		if param < 12 then
			ceiling = false
		else
			ceiling = true
		end
		local connect = stair_param_to_connect(param, ceiling)
		local t = {
			{pos = {x = pos.x, y = pos.y, z = pos.z + 2}},
			{pos = {x = pos.x - 1, y = pos.y, z = pos.z + 1}}, {pos = {x = pos.x, y = pos.y, z = pos.z + 1}}, {pos = {x = pos.x + 1, y = pos.y, z = pos.z + 1}},
			{pos = {x = pos.x - 2, y = pos.y, z = pos.z}}, {pos = {x = pos.x - 1, y = pos.y, z = pos.z}},
			{pos = pos, connect = connect},
			{pos = {x = pos.x + 1, y = pos.y, z = pos.z}}, {pos = {x = pos.x + 2, y = pos.y, z = pos.z}},
			{pos = {x = pos.x - 1, y = pos.y, z = pos.z - 1}}, {pos = {x = pos.x, y = pos.y, z = pos.z - 1}}, {pos = {x = pos.x + 1, y = pos.y, z = pos.z - 1}},
			{pos = {x = pos.x, y = pos.y, z = pos.z - 2}}
		}
		for i,v in ipairs(t) do
			if not v.connect then
				local node = minetest.get_node(v.pos)
				local node_def = minetest.registered_nodes[node.name] or {}
				if node_def.stairs then
					t[i].stairs = node_def.stairs
					t[i].connect = stair_param_to_connect(get_stair_param(node), ceiling)
				else
					t[i].connect = {false, false, false, false, false, false, false, false}
				end
			end
		end
		local swap_stair = function(index, n1, n2)
			local connect = {false, false, false, false, false, false, false, false}
			connect[n1] = true
			connect[n2] = true
			local node = get_stair_from_param(stair_connect_to_param(connect, ceiling), t[index].stairs)
			minetest.swap_node(t[index].pos, node)
		end
		if t[3].stairs then
			if t[7].connect[1] and t[3].connect[6] then
				if t[3].connect[1] and t[1].connect[6] then
					if t[2].connect[3] then
						swap_stair(3, 1, 8)
					elseif t[4].connect[7] then
						swap_stair(3, 1, 4)
					end
				elseif t[3].connect[7] then
					swap_stair(3, 4, 7)
				elseif t[3].connect[3] then
					swap_stair(3, 3, 8)
				end
			elseif t[7].connect[2] and t[3].connect[5] then
				if t[3].connect[2] and t[1].connect[5] then
					if t[4].connect[8] then
						swap_stair(3, 2, 3)
					elseif t[2].connect[4] then
						swap_stair(3, 2, 7)
					end
				elseif t[3].connect[4] then
					swap_stair(3, 4, 7)
				elseif t[3].connect[8] then
					swap_stair(3, 3, 8)
				end
			end
		end
		if t[8].stairs then
			if t[7].connect[3] and t[8].connect[8] then
				if t[8].connect[3] and t[9].connect[8] then
					if t[4].connect[5] then
						swap_stair(8, 2, 3)
					elseif t[12].connect[1] then
						swap_stair(8, 3, 6)
					end
				elseif t[8].connect[1] then
					swap_stair(8, 1, 6)
				elseif t[8].connect[5] then
					swap_stair(8, 2, 5)
				end
			elseif t[7].connect[4] and t[8].connect[7] then
				if t[8].connect[4] and t[9].connect[7] then
					if t[12].connect[2] then
						swap_stair(8, 4, 5)
					elseif t[4].connect[6] then
						swap_stair(8, 1, 4)
					end
				elseif t[8].connect[6] then
					swap_stair(8, 1, 6)
				elseif t[8].connect[2] then
					swap_stair(8, 2, 5)
				end
			end
		end
		if t[11].stairs then
			if t[7].connect[5] and t[11].connect[2] then
				if t[11].connect[5] and t[13].connect[2] then
					if t[12].connect[7] then
						swap_stair(11, 4, 5)
					elseif t[10].connect[3] then
						swap_stair(11, 5, 8)
					end
				elseif t[11].connect[3] then
					swap_stair(11, 3, 8)
				elseif t[11].connect[7] then
					swap_stair(11, 4, 7)
				end
			elseif t[7].connect[6] and t[11].connect[1] then
				if t[11].connect[6] and t[13].connect[1] then
					if t[10].connect[4] then
						swap_stair(11, 6, 7)
					elseif t[12].connect[8] then
						swap_stair(11, 3, 6)
					end
				elseif t[11].connect[8] then
					swap_stair(11, 3, 8)
				elseif t[11].connect[4] then
					swap_stair(11, 4, 7)
				end
			end
		end
		if t[6].stairs then
			if t[7].connect[7] and t[6].connect[4] then
				if t[6].connect[7] and t[5].connect[4] then
					if t[10].connect[1] then
						swap_stair(6, 6, 7)
					elseif t[2].connect[5] then
						swap_stair(6, 2, 7)
					end
				elseif t[6].connect[5] then
					swap_stair(6, 2, 5)
				elseif t[6].connect[1] then
					swap_stair(6, 1, 6)
				end
			elseif t[7].connect[8] and t[6].connect[3] then
				if t[6].connect[8] and t[5].connect[3] then
					if t[2].connect[6] then
						swap_stair(6, 1, 8)
					elseif t[10].connect[2] then
						swap_stair(6, 5, 8)
					end
				elseif t[6].connect[2] then
					swap_stair(6, 2, 5)
				elseif t[6].connect[6] then
					swap_stair(6, 1, 6)
				end
			end
		end
	end
	minetest.override_item(name, {
		stairs = {name, name.."_outer", name.."_inner"},
		after_dig_node = function(pos, oldnode) after_dig_node(pos, oldnode) end,
		on_place = nil,
		after_place_node = function(pos, placer, itemstack, pointed_thing)
			local node = minetest.get_node(pos)
			local ceiling = false
			if pointed_thing.under.y > pointed_thing.above.y or
					(pointed_thing.under.y == pointed_thing.above.y and minetest.pointed_thing_to_face_pos(placer, pointed_thing).y % 1 < 0.5) then
				ceiling = true
				if node.param2 == 0 then node.param2 = 20
				elseif node.param2 == 1 then node.param2 = 23
				elseif node.param2 == 2 then node.param2 = 22
				elseif node.param2 == 3 then node.param2 = 21
				end
			end
			local connect = stair_param_to_connect(get_stair_param(node), ceiling)
			local t = {
				{pos = {x = pos.x - 1, y = pos.y, z = pos.z + 1}}, {pos = {x = pos.x, y = pos.y, z = pos.z + 1}}, {pos = {x = pos.x + 1, y = pos.y, z = pos.z + 1}},
				{pos = {x = pos.x - 1, y = pos.y, z = pos.z}}, {pos = pos, stairs = {name, name.."_outer", name.."_inner"}, connect = connect}, {pos = {x = pos.x + 1, y = pos.y, z = pos.z}},
				{pos = {x = pos.x - 1, y = pos.y, z = pos.z - 1}}, {pos = {x = pos.x, y = pos.y, z = pos.z - 1}}, {pos = {x = pos.x + 1, y = pos.y, z = pos.z - 1}},
			}
			for i,v in ipairs(t) do
				if not v.connect then
					local node = minetest.get_node(v.pos)
					local node_def = minetest.registered_nodes[node.name] or {}
					if node_def.stairs then
						t[i].stairs = node_def.stairs
						t[i].connect = stair_param_to_connect(get_stair_param(node), ceiling)
					else
						t[i].connect = {false, false, false, false, false, false, false, false}
					end
				end
			end
			local reset_node = function(n1, n2)
				local connect = {false, false, false, false, false, false, false, false}
				connect[n1] = true
				connect[n2] = true
				node = get_stair_from_param(stair_connect_to_param(connect, ceiling), t[5].stairs)
			end
			local swap_stair = function(index, n1, n2)
				local connect = {false, false, false, false, false, false, false, false}
				connect[n1] = true
				connect[n2] = true
				local node = get_stair_from_param(stair_connect_to_param(connect, ceiling), t[index].stairs)
				t[index].connect = connect
				minetest.swap_node(t[index].pos, node)
			end
			if connect[3] then
				if t[4].connect[2] and t[4].connect[5] and t[1].connect[5] and not t[7].connect[2] then
					swap_stair(4, 2, 3)
				elseif t[4].connect[1] and t[4].connect[6] and t[7].connect[1] and not t[1].connect[6] then
					swap_stair(4, 3, 6)
				end
				if t[6].connect[1] and t[6].connect[6] and t[3].connect[6] and not t[9].connect[1] then
					swap_stair(6, 1, 8)
				elseif t[6].connect[2] and t[6].connect[5] and t[9].connect[2] and not t[3].connect[5] then
					swap_stair(6, 5, 8)
				end
				if t[4].connect[3] ~= t[6].connect[8] then
					if t[4].connect[3] then
						if t[2].connect[6] then
							reset_node(1, 8)
						elseif t[8].connect[2] then
							reset_node(5, 8)
						elseif t[2].connect[4] and t[2].connect[7] and t[1].connect[4] and not t[3].connect[7] then
							swap_stair(2, 6, 7)
							reset_node(1, 8)
						elseif t[2].connect[3] and t[2].connect[8] and t[3].connect[8] and not t[1].connect[3] then
							swap_stair(2, 3, 6)
							reset_node(1, 8)
						elseif t[8].connect[3] and t[8].connect[8] and t[9].connect[8] and not t[7].connect[3] then
							swap_stair(8, 2, 3)
							reset_node(5, 8)
						elseif t[8].connect[4] and t[8].connect[7] and t[7].connect[4] and not t[9].connect[7] then
							swap_stair(8, 2, 7)
							reset_node(5, 8)
						end
					else
						if t[2].connect[5] then
							reset_node(2, 3)
						elseif t[8].connect[1] then
							reset_node(3, 6)
						elseif t[2].connect[4] and t[2].connect[7] and t[3].connect[7] and not t[1].connect[4] then
							swap_stair(2, 4, 5)
							reset_node(2, 3)
						elseif t[2].connect[3] and t[2].connect[8] and t[1].connect[3] and not t[3].connect[8] then
							swap_stair(2, 5, 8)
							reset_node(2, 3)
						elseif t[8].connect[3] and t[8].connect[8] and t[7].connect[3] and not t[9].connect[8] then
							swap_stair(8, 1, 8)
							reset_node(3, 6)
						elseif t[8].connect[4] and t[8].connect[7] and t[9].connect[7] and not t[7].connect[4] then
							swap_stair(8, 1, 4)
							reset_node(3, 6)
						end
					end
				end
			elseif connect[2] then
				if t[2].connect[4] and t[2].connect[7] and t[3].connect[7] and not t[1].connect[4] then
					swap_stair(2, 4, 5)
				elseif t[2].connect[3] and t[2].connect[8] and t[1].connect[3] and not t[3].connect[8] then
					swap_stair(2, 5, 8)
				end
				if t[8].connect[3] and t[8].connect[8] and t[9].connect[8] and not t[7].connect[3] then
					swap_stair(8, 2, 3)
				elseif t[8].connect[4] and t[8].connect[7] and t[7].connect[4] and not t[9].connect[7] then
					swap_stair(8, 2, 7)
				end
				if t[2].connect[5] ~= t[8].connect[2] then
					if t[2].connect[5] then
						if t[6].connect[8] then
							reset_node(2, 3)
						elseif t[4].connect[4] then
							reset_node(2, 7)
						elseif t[6].connect[1] and t[6].connect[6] and t[3].connect[6] and not t[9].connect[1] then
							swap_stair(6, 1, 8)
							reset_node(2, 3)
						elseif t[6].connect[2] and t[6].connect[5] and t[9].connect[2] and not t[3].connect[5] then
							swap_stair(6, 5, 8)
							reset_node(2, 3)
						elseif t[4].connect[2] and t[4].connect[5] and t[7].connect[2] and not t[1].connect[5] then
							swap_stair(4, 4, 5)
							reset_node(2, 7)
						elseif t[4].connect[1] and t[4].connect[6] and t[1].connect[6] and not t[7].connect[1] then
							swap_stair(4, 1, 4)
							reset_node(2, 7)
						end
					else
						if t[6].connect[7] then
							reset_node(4, 5)
						elseif t[4].connect[3] then
							reset_node(5, 8)
						elseif t[6].connect[1] and t[6].connect[6] and t[9].connect[1] and not t[3].connect[6] then
							swap_stair(6, 6, 7)
							reset_node(4, 5)
						elseif t[6].connect[2] and t[6].connect[5] and t[3].connect[5] and not t[9].connect[2] then
							swap_stair(6, 2, 7)
							reset_node(4, 5)
						elseif t[4].connect[2] and t[4].connect[5] and t[1].connect[5] and not t[7].connect[2] then
							swap_stair(4, 2, 3)
							reset_node(5, 8)
						elseif t[4].connect[1] and t[4].connect[6] and t[7].connect[1] and not t[1].connect[6] then
							swap_stair(4, 3, 6)
							reset_node(5, 8)
						end
					end
				end
			elseif connect[4] then
				if t[6].connect[1] and t[6].connect[6] and t[9].connect[1] and not t[3].connect[6] then
					swap_stair(6, 6, 7)
				elseif t[6].connect[2] and t[6].connect[5] and t[3].connect[5] and not t[9].connect[2] then
					swap_stair(6, 2, 7)
				end
				if t[4].connect[2] and t[4].connect[5] and t[7].connect[2] and not t[1].connect[5] then
					swap_stair(4, 4, 5)
				elseif t[4].connect[1] and t[4].connect[6] and t[1].connect[6] and not t[7].connect[1] then
					swap_stair(4, 1, 4)
				end
				if t[4].connect[4] ~= t[6].connect[7] then
					if t[4].connect[4] then
						if t[8].connect[1] then
							reset_node(6, 7)
						elseif t[2].connect[5] then
							reset_node(2, 7)
						elseif t[8].connect[3] and t[8].connect[8] and t[7].connect[3] and not t[9].connect[8] then
							swap_stair(8, 1, 8)
							reset_node(6, 7)
						elseif t[8].connect[4] and t[8].connect[7] and t[9].connect[7] and not t[7].connect[4] then
							swap_stair(8, 1, 4)
							reset_node(6, 7)
						elseif t[2].connect[4] and t[2].connect[7] and t[3].connect[7] and not t[1].connect[4] then
							swap_stair(2, 4, 5)
							reset_node(2, 7)
						elseif t[2].connect[3] and t[2].connect[8] and t[1].connect[3] and not t[3].connect[8] then
							swap_stair(2, 5, 8)
							reset_node(2, 7)
						end
					else
						if t[8].connect[2] then
							reset_node(4, 5)
						elseif t[2].connect[6] then
							reset_node(1, 4)
						elseif t[8].connect[3] and t[8].connect[8] and t[9].connect[8] and not t[7].connect[3] then
							swap_stair(8, 2, 3)
							reset_node(4, 5)
						elseif t[8].connect[4] and t[8].connect[7] and t[7].connect[4] and not t[9].connect[7] then
							swap_stair(8, 2, 7)
							reset_node(4, 5)
						elseif t[2].connect[4] and t[2].connect[7] and t[1].connect[4] and not t[3].connect[7] then
							swap_stair(2, 6, 7)
							reset_node(1, 4)
						elseif t[2].connect[3] and t[2].connect[8] and t[3].connect[8] and not t[1].connect[3] then
							swap_stair(2, 3, 6)
							reset_node(1, 4)
						end
					end
				end
			elseif connect[1] then
				if t[8].connect[3] and t[8].connect[8] and t[7].connect[3] and not t[9].connect[8] then
					swap_stair(8, 1, 8)
				elseif t[8].connect[4] and t[8].connect[7] and t[9].connect[7] and not t[7].connect[4] then
					swap_stair(8, 1, 4)
				end
				if t[2].connect[4] and t[2].connect[7] and t[1].connect[4] and not t[3].connect[7] then
					swap_stair(2, 6, 7)
				elseif t[2].connect[3] and t[2].connect[8] and t[3].connect[8] and not t[1].connect[3] then
					swap_stair(2, 3, 6)
				end
				if t[2].connect[6] ~= t[8].connect[1] then
					if t[2].connect[6] then
						if t[4].connect[3] then
							reset_node(1, 8)
						elseif t[6].connect[7] then
							reset_node(1, 4)
						elseif t[4].connect[2] and t[4].connect[5] and t[1].connect[5] and not t[7].connect[2] then
							swap_stair(4, 2, 3)
							reset_node(1, 8)
						elseif t[4].connect[1] and t[4].connect[6] and t[7].connect[1] and not t[1].connect[6] then
							swap_stair(4, 3, 6)
							reset_node(1, 8)
						elseif t[6].connect[1] and t[6].connect[6] and t[9].connect[1] and not t[3].connect[6] then
							swap_stair(6, 6, 7)
							reset_node(1, 4)
						elseif t[6].connect[2] and t[6].connect[5] and t[3].connect[5] and not t[9].connect[2] then
							swap_stair(6, 2, 7)
							reset_node(1, 4)
						end
					else
						if t[4].connect[4] then
							reset_node(6, 7)
						elseif t[6].connect[8] then
							reset_node(3, 6)
						elseif t[4].connect[2] and t[4].connect[5] and t[7].connect[2] and not t[1].connect[5] then
							swap_stair(4, 4, 5)
							reset_node(6, 7)
						elseif t[4].connect[1] and t[4].connect[6] and t[1].connect[6] and not t[7].connect[1] then
							swap_stair(4, 1, 4)
							reset_node(6, 7)
						elseif t[6].connect[1] and t[6].connect[6] and t[3].connect[6] and not t[9].connect[1] then
							swap_stair(6, 1, 8)
							reset_node(3, 6)
						elseif t[6].connect[2] and t[6].connect[5] and t[9].connect[2] and not t[3].connect[5] then
							swap_stair(6, 5, 8)
							reset_node(3, 6)
						end
					end
				end
			end
			minetest.swap_node(pos, node)
		end
	})
	minetest.register_node(":"..name.."_outer", {
		description = node_def.description,
		drawtype = "nodebox",
		tiles = outer_tiles,
		paramtype = "light",
		paramtype2 = "facedir",
		is_ground_content = false,
		groups = outer_groups,
		sounds = node_def.sounds,
		node_box = {
			type = "fixed",
			fixed = {
				{-0.5, -0.5, -0.5, 0.5, 0, 0.5},
				{-0.5, 0, 0, 0, 0.5, 0.5}
			}
		},
		drop = drop,
		stairs = {name, name.."_outer", name.."_inner"},
		after_dig_node = function(pos, oldnode) after_dig_node(pos, oldnode) end
	})
	minetest.register_node(":"..name.."_inner", {
		description = node_def.description,
		drawtype = "nodebox",
		tiles = inner_tiles,
		paramtype = "light",
		paramtype2 = "facedir",
		is_ground_content = false,
		groups = inner_groups,
		sounds = node_def.sounds,
		node_box = {
			type = "fixed",
			fixed = {
				{-0.5, -0.5, -0.5, 0.5, 0, 0.5},
				{-0.5, 0, 0, 0.5, 0.5, 0.5},
				{-0.5, 0, -0.5, 0, 0.5, 0}
			}
		},
		drop = drop,
		stairs = {name, name.."_outer", name.."_inner"},
		after_dig_node = function(pos, oldnode) after_dig_node(pos, oldnode) end
	})
end
--]]

for _,v in ipairs({
	"wood",
	"junglewood",
	"pine_wood",
	"acacia_wood",
	"aspen_wood",
	"stone",
	"cobble",
	"mossycobble",
	"stonebrick",
	"stone_block",
	"desert_stone",
	"desert_cobble",
	"desert_stonebrick",
	"desert_stone_block",
	"sandstone",
	"sandstonebrick",
	"sandstone_block",
	"obsidian",
	"obsidianbrick",
	"obsidian_block",
	"brick",
	"straw",
	"steelblock",
	"copperblock",
	"bronzeblock",
	"goldblock"
}) do
	mcstair.register(v)
	minetest.register_alias("stairs:stair_"..v.."_outer", "stairs:stair_outer_"..v)
	minetest.register_alias("stairs:stair_"..v.."_inner", "stairs:stair_inner_"..v)
end

for _,v in ipairs({
	"desert_sandstone",
	"desert_sandstone_brick",
	"desert_sandstone_block",
	"silver_sandstone",
	"silver_sandstone_brick",
	"silver_sandstone_block",
	"tinblock",
	"ice",
	"snowblock",
	"glass",
	"obsidian_glass"
}) do
	mcstair.register(v)
end

if minetest.get_modpath("mtg_plus") then
	for _,v in ipairs({
		"sandstone_cobble",
		"desert_sandstone_cobble",
		"silver_sandstone_cobble",
		"jungle_cobble",
		"snow_brick",
		"hard_snow_brick",
		"ice_snow_brick",
		"ice_brick",
		"ice_tile4",
		"goldwood",
		"goldbrick",
		"bronzebrick",
		"tinbrick",
		"copperbrick",
		"steelbrick",
		"harddirtbrick",
		"gravel_cobble"
	}) do
		mcstair.register(v)
	end
end

if minetest.get_modpath("quartz") then
	for _,v in ipairs({
		"quartzblock",
		"quartzstair"
	}) do
		mcstair.register(v)
	end
end

if minetest.get_modpath("xdecor") then
	for _,v in ipairs({
		"barrel",
		"cactusbrick",
		"coalstone_tile",
		"desertstone_tile",
		"hard_clay",
		"moonbrick",
		"stone_tile",
		"stone_rune",
		"packed_ice",
		"wood_tile",
		"woodframed_glass"
	}) do
		mcstair.register(v)
	end
end
