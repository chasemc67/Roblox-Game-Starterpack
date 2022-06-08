local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

local Roact = require(ReplicatedStorage.Roact) 
local RoactRodux = require(ReplicatedStorage.RoactRodux)

local openInventory = require(ReplicatedStorage.Actions.openInventory)

local Inventory = Roact.Component:extend("Inventory")

function Inventory:init()
    self.inventoryChangedEvent = nil

    -- In init, we can use setState to set up our initial component state.
    self:setState({
        wood = 0
    })
end

-- This render function is almost completely unchanged from the first example.
function Inventory:render()
    -- As a convention, we'll pull currentTime out of state right away.
    local currentWood = self.state.wood

    return Roact.createElement("Frame", 
        {
            Position = UDim2.new(0, 20, 0.5, 0),
        },
        {
            WoodLabel = Roact.createElement("TextButton", {
                Size = UDim2.new(0, 100, 0, 100),
                Position = UDim2.new(0, 20, 0.5, 0),
                Text = "Wood Collected: " .. currentWood,
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
    -- Set a value that we can change later to stop our loop
    self.running = true

    -- Connect to a pickup event here: 
    self.inventoryChangedEvent = ReplicatedStorage.InventoryChanged.OnClientEvent:Connect(function(newState)
        print("Inventory changed event fired")
        self:setState({
            wood = newState.wood
        })
    end)

end

-- Stop the loop in willUnmount, so that our loop terminates when the
-- component is destroyed.
function Inventory:willUnmount()
    self.running = false

    -- prevent memory leaks
    -- self.inventoryChangedEvent.OnClientEvent:Disconnect()
end

local function mapStateToProps(state)
    return {
        wood = 1
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