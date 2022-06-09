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
        CloseButton = Roact.createElement("TextButton", {
            Size = UDim2.new(0, 15, 0, 15),
            Position = UDim2.new(1, -10, 0, 10),
            AnchorPoint = Vector2.new(1, 0),
            Text = "X",
            [Roact.Event.MouseButton1Click] = function()
                print("Close Button Clicked")
                self.props.onCloseInventory()
            end
        }),
        InventoryGridFrame = Roact.createElement("Frame", {
            Size = UDim2.new(0.9, 0, 0.9, -35),
            Position = UDim2.new(0.5, 0, 0.5, 35),
            AnchorPoint = Vector2.new(0.5, 0.5),
            BorderSizePixel = 0
        }, {
            InventoryGrid = Roact.createElement("UIGridLayout", {
                CellPadding = UDim2.new(0, 5, 0, 5),
                CellSize = UDim2.new(0, 50, 0, 50),
                FillDirection = Enum.FillDirection.Horizontal,
                HorizontalAlignment = Enum.HorizontalAlignment.Left,
                VerticalAlignment = Enum.VerticalAlignment.Top,
            }), 
            Wood = Roact.createElement("TextButton", {
                Text = "Wood" .. "<br/><br/>" ..  self.props.wood, -- use rich text to make multiline
                TextSize = 12,
                ZIndex = 7,
                BorderSizePixel = 1,
                BackgroundColor3 = Color3.new(0.9, 0.9, 0.9),
                TextWrapped = true,
                RichText=true
            })
        })
    })
end

local function mapStateToProps(state)
    return {
        wood = state.inventory and state.inventory.wood or 0
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