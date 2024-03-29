local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Roact = require(ReplicatedStorage.Roact)
local RoactRodux = require(ReplicatedStorage.RoactRodux)

local InventoryUIButton = require(ReplicatedStorage:WaitForChild("Components"):WaitForChild("InventoryUIButton"))
local Inventory = require(ReplicatedStorage:WaitForChild("Components"):WaitForChild("Inventory"))

local openInventory = require(ReplicatedStorage:WaitForChild("Actions"):WaitForChild("openInventory"))

local App = Roact.Component:extend("App")

function App:init()
end

function App:render()
    if self.props.openWindow == "inventory" then
        print("Rendering Inventory UI")
        return Roact.createElement("ScreenGui", {}, {
            Roact.createElement(Inventory)
        })
    end

    return Roact.createElement("ScreenGui", {}, {
        Roact.createElement(InventoryUIButton)
    })
end

local function mapStateToProps(state)
    return {
        openWindow = state.ui.openWindow
    }
end

local function mapDispatchToProps(dispatch)
    return {
        onOpenInventory = function()
            dispatch(openInventory())
        end
    }
end

return RoactRodux.connect(mapStateToProps, mapDispatchToProps)(App)