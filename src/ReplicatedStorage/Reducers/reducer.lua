local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Rodux = require(ReplicatedStorage.Rodux)

local ui = require(ReplicatedStorage.Reducers:WaitForChild("ui"))

local reducer = Rodux.combineReducers({
    ui = ui
})

return reducer