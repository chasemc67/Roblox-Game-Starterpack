local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Roact = require(ReplicatedStorage.Roact)
local Rodux = require(ReplicatedStorage.Rodux)
local RoactRodux = require(ReplicatedStorage.RoactRodux)

local App = Roact.Component:extend("App")

function App:init()
    local currentVal = self.props.val
end

function App:render()
    return Roact.createElement("ScreenGui", {}, {
        TextLabel = Roact.createElement("TextLabel", {
            Size = UDim2.new(1, 0, 1, 0),
            Text = "Hello, World!"
        })
    })
end

local function mapStateToProps(state)
    return {
        val = state.val
    }
end

local function mapDispatchToProps(dispatch)
    return {
        onIncrement = function()
            dispatch({
                type = "INCREMENT"
            })
        end
    }
end

local function reducer (state, action) 
    state = state or {
        value = 0,
    }

    if action.type == "INCREMENT" then
        return {
            value = state.value + 1,
        }
    end

    return state
end

return RoactRodux.connect(mapStateToProps, mapDispatchToProps)(App)