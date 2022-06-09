local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Roact = require(ReplicatedStorage.Roact)
local RoactRodux = require(ReplicatedStorage.RoactRodux)

local closeInventory = require(ReplicatedStorage:WaitForChild("Actions"):WaitForChild("closeInventory"))

local Inventory = Roact.Component:extend("Inventory")

function Inventory:init()
end

function Inventory:render()
    return Roact.createElement("Frame", {
        Size = UDim2.new(0.6, 0, 0.7, 0),
        Position = UDim2.new(0.5, 0, 0.5, 0),
        AnchorPoint = Vector2.new(0.5, 0.5),
    }, {
        TextLabel = Roact.createElement("TextLabel", {
            Size = UDim2.new(1, 0, 1, 0),
            Text = "Hello, Inventory!"
        }),
        CloseButton = Roact.createElement("TextButton", {
            Size = UDim2.new(0, 15, 0, 15),
            Position = UDim2.new(1, -10, 0, 10),
            AnchorPoint = Vector2.new(1, 0),
            Text = "X",
            [Roact.Event.MouseButton1Click] = function()
                print("Close Button Clicked")
                self.props.onCloseInventory()
            end
        })
    })
end

local function mapStateToProps(state)
    return {
    }
end

local function mapDispatchToProps(dispatch)
    return {
        onCloseInventory = function()
            dispatch(closeInventory())
        end
    }
end

return RoactRodux.connect(mapStateToProps, mapDispatchToProps)(Inventory)