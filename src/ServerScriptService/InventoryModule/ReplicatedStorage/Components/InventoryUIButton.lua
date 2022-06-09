local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

local Roact = require(ReplicatedStorage.Roact) 
local RoactRodux = require(ReplicatedStorage.RoactRodux)

local openInventory = require(ReplicatedStorage:WaitForChild("Actions"):WaitForChild("openInventory"))

local Inventory = Roact.Component:extend("Inventory")

function Inventory:init()
    -- In init, we can use setState to set up our initial component state.
    self:setState({
    })
end

-- This render function is almost completely unchanged from the first example.
function Inventory:render()
    return Roact.createElement("Frame", 
        {
            Position = UDim2.new(0, 20, 0.5, 0),
        },
        {
            WoodLabel = Roact.createElement("TextButton", {
                Size = UDim2.new(0, 100, 0, 100),
                Position = UDim2.new(0, 20, 0.5, 0),
                Text = "Wood Collected: " .. self.props.wood,
                [Roact.Event.MouseButton1Click] = function()
                    print("Open Inventory Button Clicked")
                    self.props.onOpenInventory()
                end
            })
        }
    )
end

-- Set up our loop in didMount, so that it starts running when our
-- component is created.
function Inventory:didMount()
end

-- Stop the loop in willUnmount, so that our loop terminates when the
-- component is destroyed.
function Inventory:willUnmount()
end

local function mapStateToProps(state)
    return {
        wood = state.inventory and state.inventory.wood or 0
    }
end

local function mapDispatchToProps(dispatch)
    return {
        onOpenInventory = function()
            dispatch(openInventory())
        end
    }
end

return RoactRodux.connect(mapStateToProps, mapDispatchToProps)(Inventory)