local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Rodux = require(ReplicatedStorage.Rodux)

local openInventory = require(ReplicatedStorage.Actions.openInventory)

local initialState = {
    openWindow = nil,
    val = 0
}

local reducer = Rodux.createReducer(initialState, {
    [openInventory.name] = function(state, action)
        return {
            openWindow = "inventory"
        }
    end
})

return reducer