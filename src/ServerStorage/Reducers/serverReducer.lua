local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerStorage = game:GetService("ServerStorage")
local Rodux = require(ReplicatedStorage.Rodux)

local inventory = require(ServerStorage.Reducers.inventory)

local reducer = Rodux.combineReducers({
    inventory = inventory
})

return reducer