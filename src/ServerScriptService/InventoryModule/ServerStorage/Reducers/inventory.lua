local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerStorage = game:GetService("ServerStorage")
local Rodux = require(ReplicatedStorage.Rodux)
local RoduxUtils = require(ReplicatedStorage.RoduxUtils)

local updateInventory = require(ServerStorage:WaitForChild("Actions"):WaitForChild("updateInventory"))
local loadUser = require(ServerStorage:WaitForChild("Actions"):WaitForChild("loadUser"))
local removeUser = require(ServerStorage:WaitForChild("Actions"):WaitForChild("removeUser"))
local InventoryChanged = ReplicatedStorage:WaitForChild("InventoryChanged")

local initialState = {
}

local reducer = Rodux.createReducer(initialState, {
    [updateInventory.name] = function(state, action)
        
        local userId = action.player.UserId
        local newValue = 1
        if state[userId] and state[userId].wood then
            newValue = state[userId].wood + 1
        end

        local tableUpdates = {
            [userId] = {
                wood = newValue
            }
        }
        local newState = RoduxUtils.deepmerge(RoduxUtils.deepcopy(state), tableUpdates)

        -- update client that inventory changed
        -- using a remoteEvent
        -- inventoryUpdatedRemote:FireClients(action)
        print("Updating client that inventory changed")
        InventoryChanged:FireClient(action.player, newState[userId])
        return newState
    end,

    [loadUser.name] = function(state, action)
        local userId = action.player.UserId
        local data = action.data

        if data == nil then
            return
        end

        local tableUpdates = {
            [userId] = data.inventory
        }

        local newState = RoduxUtils.deepmerge(RoduxUtils.deepcopy(state), tableUpdates)

        print("Updating client that inventory loaded")
        InventoryChanged:FireClient(action.player, newState[userId])
        return newState
    end,

    [removeUser.name] = function(state, action)
        local userId = action.player.UserId
        
        local currentState = RoduxUtils.deepcopy(state)
        currentState[userId] = nil
        return currentState
    end
})

return reducer