local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerStorage = game:GetService("ServerStorage")
local Rodux = require(ReplicatedStorage.Rodux)

local store = require(ServerStorage.serverStore)


local updateInventory = require(ServerStorage.Actions.updateInventory)

print("Current wood: " .. store:getState().inventory.wood)

store:dispatch(updateInventory())

print("After Disaptch wood: " .. store:getState().inventory.wood)