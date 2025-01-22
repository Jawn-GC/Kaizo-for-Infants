local neobabylon2 = {
    identifier = "Neo Babylon-2",
    title = "Neo Babylon-2",
    theme = THEME.NEO_BABYLON,
    width = 4,
    height = 4,
	world = 6,
	level = 2,
    file_name = "Neo Babylon-2.lvl",
}

local level_state = {
    loaded = false,
    callbacks = {},
}

neobabylon2.load_level = function()
    if level_state.loaded then return end
    level_state.loaded = true

	level_state.callbacks[#level_state.callbacks+1] = set_post_entity_spawn(function(entity, spawn_flags)
		entity:destroy()
	end, SPAWN_TYPE.SYSTEMIC, 0, ENT_TYPE.ITEM_PICKUP_SKELETON_KEY)
	
	level_state.callbacks[#level_state.callbacks+1] = set_post_entity_spawn(function(entity, spawn_flags)
		entity:destroy()
	end, SPAWN_TYPE.ANY, 0, ENT_TYPE.MONS_SKELETON)

	level_state.callbacks[#level_state.callbacks+1] = set_post_entity_spawn(function(entity, spawn_flags)
		entity:destroy()
	end, SPAWN_TYPE.ANY, 0, ENT_TYPE.ITEM_SKULL)
	
	level_state.callbacks[#level_state.callbacks+1] = set_post_entity_spawn(function(entity, spawn_flags)
		entity:destroy()
	end, SPAWN_TYPE.ANY, 0, ENT_TYPE.ITEM_BONES)

	level_state.callbacks[#level_state.callbacks+1] = set_post_entity_spawn(function (entity)
		entity.flags = set_flag(entity.flags, 6)
    end, SPAWN_TYPE.ANY, 0, ENT_TYPE.FLOORSTYLED_BABYLON)

	level_state.callbacks[#level_state.callbacks+1] = set_post_entity_spawn(function (entity)
		entity.flags = set_flag(entity.flags, 6)
    end, SPAWN_TYPE.ANY, 0, ENT_TYPE.FLOOR_GENERIC)
	
	level_state.callbacks[#level_state.callbacks+1] = set_post_entity_spawn(function (entity)
		entity.flags = set_flag(entity.flags, 6)
    end, SPAWN_TYPE.ANY, 0, ENT_TYPE.FLOOR_FORCEFIELD)

	level_state.callbacks[#level_state.callbacks+1] = set_post_entity_spawn(function(entity, spawn_flags)
		entity.x = entity.x - 0.5
	end, SPAWN_TYPE.ANY, 0, ENT_TYPE.ITEM_TELESCOPE)

	local laser = {}
	level_state.callbacks[#level_state.callbacks+1] = set_post_entity_spawn(function (entity)
		laser[#laser + 1] = entity
		entity.flags = set_flag(entity.flags, 6)
    end, SPAWN_TYPE.ANY, 0, ENT_TYPE.FLOOR_HORIZONTAL_FORCEFIELD)

	local frames = 0
	local laser_on = false
	level_state.callbacks[#level_state.callbacks+1] = set_callback(function ()
		if laser[1].timer > 0 and laser_on == false then
			laser_on = true
		end
		
		if laser_on == true then
			for i = 1,#laser do
				laser[i].timer = 2 -- Keep forcefield on
			end
		end
        frames = frames + 1
    end, ON.FRAME)
	
	toast(neobabylon2.title)
end

neobabylon2.unload_level = function()
    if not level_state.loaded then return end
    
    local callbacks_to_clear = level_state.callbacks
    level_state.loaded = false
    level_state.callbacks = {}
    for _, callback in pairs(callbacks_to_clear) do
        clear_callback(callback)
    end
end

return neobabylon2