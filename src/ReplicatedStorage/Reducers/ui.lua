local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Rodux = require(ReplicatedStorage.Rodux)

local increment = require(ReplicatedStorage.Actions.increment)
local openInventory = require(ReplicatedStorage.Actions.openInventory)

local initialState = {
    openWindow = nil,
    val = 0
}

local reducer = Rodux.createReducer(initialState, {
    [increment.name] = function(state, action)
        return {
            val = state.val + action.amount
        }
    end,

    [openInventory.name] = function(state, action)
        return {
            openWindow = "inventory"
        }
    end
})

return reducer