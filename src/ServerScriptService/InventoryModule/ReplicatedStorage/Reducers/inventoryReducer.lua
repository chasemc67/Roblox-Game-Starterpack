local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Rodux = require(ReplicatedStorage.Rodux)
local RoduxUtils = require(ReplicatedStorage.RoduxUtils)

local loadUser = require(ReplicatedStorage:WaitForChild("Actions"):WaitForChild("loadUser"))
local inventoryUpdatedAction = require(ReplicatedStorage:WaitForChild("Actions"):WaitForChild("inventoryUpdatedAction"))

local initialState = {
}

-- need to also listen for InventoryChanged event from the server

local reducer = Rodux.createReducer(initialState, {
    [loadUser.name] = function(state, action)
        if action.data == nil or action.data.inventory == nil then
            return state
        end
        return action.data.inventory
    end,

    [inventoryUpdatedAction.name] = function(state, action)
        if action.data == nil or action.data.inventory == nil then
            return state
        end
        return action.data.inventory
    end
})

return reducer