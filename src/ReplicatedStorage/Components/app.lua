local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Roact = require(ReplicatedStorage.Roact)
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

return RoactRodux.connect(mapStateToProps, mapDispatchToProps)(App)

-- local app = Roact.createElement(RoactRodux.StoreProvider, {
--     store = clientStore
-- }, {
--     App = Roact.createElement(App)
-- })