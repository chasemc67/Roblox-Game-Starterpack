local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Rodux = require(ReplicatedStorage.Rodux)
local inventoryUpdatedAction = require(ReplicatedStorage:WaitForChild("Actions"):WaitForChild("inventoryUpdatedAction"))

local initialState = {
}

-- need to also listen for InventoryChanged event from the server

local reducer = Rodux.createReducer(initialState, {
    [inventoryUpdatedAction.name] = function(state, action)
        if action.inventory == nil then
            return state
        end
        return action.inventory
    end
})

return reducer