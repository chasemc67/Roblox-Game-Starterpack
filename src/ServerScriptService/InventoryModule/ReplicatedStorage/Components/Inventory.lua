local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Roact = require(ReplicatedStorage.Roact)
local RoactRodux = require(ReplicatedStorage.RoactRodux)
local TableUtils = require(ReplicatedStorage.TableUtils)

local closeInventory = require(ReplicatedStorage:WaitForChild("Actions"):WaitForChild("closeInventory"))

local Inventory = Roact.Component:extend("Inventory")

function Inventory:init()
end

function Inventory:render()

    local items = TableUtils.map(self.props.inventory, function(key, value)
        return Roact.createElement("TextButton", {
            Text = key .. "<br/><br/>" ..  value, -- use rich text to make multiline
            TextSize = 12,
            ZIndex = 7,
            BorderSizePixel = 1,
            BackgroundColor3 = Color3.new(0.9, 0.9, 0.9),
            TextWrapped = true,
            RichText=true
        })
    end)

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
            Items = Roact.createFragment(items)
        })
    })
end

local function mapStateToProps(state)
    return {
        inventory = state.inventory or {}
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