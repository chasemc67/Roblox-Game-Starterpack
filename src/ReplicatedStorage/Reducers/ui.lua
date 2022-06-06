local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Rodux = require(ReplicatedStorage.Rodux)
local increment = require(ReplicatedStorage.Actions.increment)

local initialState = {
    val = 0
}

local reducer = Rodux.createReducer(initialState, {
    [increment.name] = function(state, action)
        return {
            val = state.val + action.amount
        }
    end
})

return reducer