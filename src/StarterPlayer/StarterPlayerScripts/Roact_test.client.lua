local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

local Roact = require(ReplicatedStorage.Roact)
local AppRoot = require(ReplicatedStorage.AppRoot)
local PlayerGui = Players.LocalPlayer:WaitForChild("PlayerGui")

-- Create our UI, which now runs on its own!
local handle = Roact.mount(AppRoot, PlayerGui, "Root App")

-- Later, we can destroy our UI and disconnect everything correctly.
wait(10)
Roact.unmount(handle)