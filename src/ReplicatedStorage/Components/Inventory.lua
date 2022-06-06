local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Roact = require(ReplicatedStorage.Roact)
local RoactRodux = require(ReplicatedStorage.RoactRodux)


local Inventory = Roact.Component:extend("Inventory")

function Inventory:init()
end

function Inventory:render()
    return Roact.createElement("ScreenGui", {}, {
        TextLabel = Roact.createElement("TextLabel", {
            Size = UDim2.new(1, 0, 1, 0),
            Text = "Hello, World!"
        })
    })
end

local function mapStateToProps(state)
    return {
    }
end

local function mapDispatchToProps(dispatch)
    return {
    }
end

return RoactRodux.connect(mapStateToProps, mapDispatchToProps)(Inventory)