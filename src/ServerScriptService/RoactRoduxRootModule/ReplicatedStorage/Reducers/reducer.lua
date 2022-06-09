local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Rodux = require(ReplicatedStorage.Rodux)

local ui = require(ReplicatedStorage:WaitForChild("Reducers"):WaitForChild("ui"))
local inventory = require(ReplicatedStorage:WaitForChild("Reducers"):WaitForChild("inventoryReducer"))

local reducer = Rodux.combineReducers({
    ui = ui,
    inventory = inventory
})

return reducer