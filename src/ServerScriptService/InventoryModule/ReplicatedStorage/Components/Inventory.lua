local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Roact = require(ReplicatedStorage.Roact)
local RoactRodux = require(ReplicatedStorage.RoactRodux)


local Inventory = Roact.Component:extend("Inventory")

function Inventory:init()
end

function Inventory:render()
    return Roact.createElement("Frame", {
        Size = UDim2.new(1,0,1,0)
    }, {
        TextLabel = Roact.createElement("TextLabel", {
            Size = UDim2.new(1, 0, 1, 0),
            Text = "Hello, Inventory!"
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