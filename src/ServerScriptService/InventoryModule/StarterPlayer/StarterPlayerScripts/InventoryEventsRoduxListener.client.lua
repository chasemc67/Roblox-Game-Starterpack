local ReplicatedStorage = game:GetService("ReplicatedStorage")
local clientStore = require(ReplicatedStorage:WaitForChild("clientStore"))
local InventoryChanged = ReplicatedStorage:WaitForChild("InventoryChanged")
local inventoryUpdatedAction = require(ReplicatedStorage:WaitForChild("Actions"):WaitForChild("inventoryUpdatedAction"))

InventoryChanged.OnClientEvent:Connect(function(inventory)
    clientStore:dispatch(inventoryUpdatedAction(inventory))
end)
