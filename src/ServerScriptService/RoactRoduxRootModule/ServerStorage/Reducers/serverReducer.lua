local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerStorage = game:GetService("ServerStorage")
local Rodux = require(ReplicatedStorage.Rodux)

local inventory = require(ServerStorage:WaitForChild("Reducers"):WaitForChild("inventory"))

local reducer = Rodux.combineReducers({
    inventory = inventory
})

return reducer