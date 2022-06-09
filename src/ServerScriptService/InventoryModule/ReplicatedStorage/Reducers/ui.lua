local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Rodux = require(ReplicatedStorage.Rodux)

local openInventory = require(ReplicatedStorage:WaitForChild("Actions"):WaitForChild("openInventory"))
local closeInventory = require(ReplicatedStorage:WaitForChild("Actions"):WaitForChild("closeInventory"))

local initialState = {
    openWindow = nil
}

local reducer = Rodux.createReducer(initialState, {
    [openInventory.name] = function(state, action)
        return {
            openWindow = "inventory"
        }
    end,

    [closeInventory.name] = function(state, action)
        return {
            openWindow = nil
        }
    end
})

return reducer