local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Roact = require(ReplicatedStorage.Roact)
local RoactRodux = require(ReplicatedStorage.RoactRodux)

local InventoryUIButton = require(ReplicatedStorage.Components.InventoryUIButton)
local Inventory = require(ReplicatedStorage.Components.Inventory)

local openInventory = require(ReplicatedStorage.Actions.openInventory)
local increment = require(ReplicatedStorage.Actions.increment)

local App = Roact.Component:extend("App")

function App:init()
end

function App:render()
    return Roact.createElement("ScreenGui", {}, {
        Roact.createElement(InventoryUIButton)
    })
end

local function mapStateToProps(state)
    return {
        openWindow = state.openWindow
    }
end

local function mapDispatchToProps(dispatch)
    return {
        onIncrement = function()
            dispatch(increment(1))
        end,
        onOpenInventory = function()
            dispatch(openInventory())
        end
    }
end

return RoactRodux.connect(mapStateToProps, mapDispatchToProps)(App)