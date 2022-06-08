local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerStorage = game:GetService("ServerStorage")
local Rodux = require(ReplicatedStorage.Rodux)

local serverReducer = require(ServerStorage.Reducers.serverReducer)

local store = Rodux.Store.new(serverReducer)

return store