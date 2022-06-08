local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerStorage = game:GetService("ServerStorage")
local Rodux = require(ReplicatedStorage.Rodux)

local updateInventory = require(ServerStorage.Actions.updateInventory)

local initialState = {
    wood = 0
}

local reducer = Rodux.createReducer(initialState, {
    [updateInventory.name] = function(state, action)
        -- update client that inventory changed
        -- using a remoteEvent
        -- inventoryUpdatedRemote:FireClients(action)
        return {
            wood = state.wood + 1
        }
    end
})

return reducer