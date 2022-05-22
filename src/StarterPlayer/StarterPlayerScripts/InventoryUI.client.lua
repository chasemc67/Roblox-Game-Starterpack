local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

local Roact = require(ReplicatedStorage.Roact)

local Inventory = Roact.Component:extend("Inventory")

function Inventory:init()
    -- In init, we can use setState to set up our initial component state.
    self:setState({
        wood = 0
    })
end

-- This render function is almost completely unchanged from the first example.
function Inventory:render()
    -- As a convention, we'll pull currentTime out of state right away.
    local currentWood = self.state.wood

    return Roact.createElement("ScreenGui", {

    }, {
        WoodLabel = Roact.createElement("TextButton", {
            Size = UDim2.new(0, 100, 0, 100),
            Position = UDim2.new(0, 20, 0.5, 0),
            Text = "Wood Collected: " .. currentWood,
            [Roact.Event.MouseButton1Click] = function()
                print("Wood Button Clicked")
            end
        })
    })
end

-- Set up our loop in didMount, so that it starts running when our
-- component is created.
function Inventory:didMount()
    -- Set a value that we can change later to stop our loop
    self.running = true

    -- -- We don't want to block the main thread, so we spawn a new one!
    -- spawn(function()
    --     while self.running do
    --         -- Because we depend on the previous state, we use the function
    --         -- variant of setState. This will matter more when Roact gets
    --         -- asynchronous rendering!
    --         self:setState(function(state)
    --             return {
    --                 currentTime = state.currentTime + 1
    --             }
    --         end)

    --         wait(1)
    --     end
    -- end)
end

-- Stop the loop in willUnmount, so that our loop terminates when the
-- component is destroyed.
function Inventory:willUnmount()
    self.running = false
end

local PlayerGui = Players.LocalPlayer.PlayerGui

-- Create our UI, which now runs on its own!
local handle = Roact.mount(Roact.createElement(Inventory), PlayerGui, "Inventory UI")

-- Later, we can destroy our UI and disconnect everything correctly.
wait(10)
Roact.unmount(handle)