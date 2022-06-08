local playerService = game:GetService("Players")
local dataService = game:GetService("DataStoreService")
local ServerStorage = game:GetService("ServerStorage")
local serverStore = require(ServerStorage.serverStore)
local loadUser = require(ServerStorage.Actions.loadUser)
local removeUser = require(ServerStorage.Actions.removeUser)

-- Getting store will fail if game isn't published
local store = nil
local success, err = pcall(function()
    store = dataService:GetDataStore("DataStoreV1")
end)
if not success then
    print("Unable to load data store, is this game published?")
end

local dataMod = {}
local AUTOSAVE_INTERVAL = 120

local function getRoduxStateForPlayer(player)
	-- RoduxState will look like
	-- {
		-- "13114": {
			-- inventory = {
				-- wood = 1,
			--}
		-- }
		-- "13115": {
			-- inventory = {
				-- wood = 1,
			--}
		-- }
	--}

	local roduxState = serverStore:getState()
	return {inventory = roduxState.inventory[player.UserId]}
end

local function setRoduxStateForPlayer(player, data)
	-- saved data will look like:
	-- {
		-- inventory = {
			-- wood = 1,
			-- stone = 2,
		--}
	--}
	serverStore:dispatch(loadUser(player, data))
end

dataMod.recursiveCopy = function(dataTable)
	local tableCopy = {}
	
	for index, value in pairs(dataTable) do
		if type(value) == "table" then
			value = dataMod.recursiveCopy(value)
		end
		tableCopy[index] = value
	end
	
	return tableCopy
end

dataMod.load = function(player, count)
	count = count or 1
	if count > 3 then
		return
	end

	local data 
	local success, err = pcall(function()
		data = store:GetAsync(player.UserId)
	end)
	
	if not success then
		if store ~= nil then
			dataMod.load(player, count + 1)
			return
		else
			print("Failed to load data, store is nil")
			return
		end
	end

	print("Loading data for " .. player.UserId)
	if data == nil then
		print("No data found for " .. player.UserId)
	else
		print("data found for " .. player.UserId)
	end

	setRoduxStateForPlayer(player, data)
end

dataMod.save = function(player, count)
	count = count or 1
	if count > 3 then
		return
	end

	local key = player.UserId
	local data = getRoduxStateForPlayer(player)
	
	local success, err = pcall(function()
		store:SetAsync(key, data)
	end)
	
	if success then
		print(player.Name.. "'s data has been saved!")
	else
		if store ~= nil then
			print("Loading data failed with error: " .. err .. ", trying again.")
			dataMod.save(player, count + 1)
			return
		else
			print("Failed to save data, store is nil")
		end
	end
end

local function autoSave()
	while wait(AUTOSAVE_INTERVAL) do
		print("Auto-saving data for all players")
		
		for key, dataTable in pairs(serverStore:getState().inventory) do
			local player = playerService:GetPlayerByUserId(key)
			dataMod.save(player)
		end
	end
end

playerService.PlayerAdded:Connect(function(player)
	dataMod.load(player)
end)

playerService.PlayerRemoving:Connect(function(player)
	dataMod.save(player)
	serverStore:dispatch(removeUser(player))
end)

spawn(autoSave) --Initialize autosave loop

game:BindToClose(function()
	for _, player in pairs(playerService:GetPlayers()) do
		dataMod.save(player)
		player:Kick("Shutting down game. All data saved.")
	end
end)

return dataMod
