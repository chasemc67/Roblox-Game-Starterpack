local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

local Roact = require(ReplicatedStorage.Roact)
local RoactRodux = require(ReplicatedStorage.RoactRodux)
local clientStore = require(ReplicatedStorage.clientStore)
local App = require(ReplicatedStorage.Components.App)

local app = Roact.createElement(RoactRodux.StoreProvider, {
    store = clientStore,
}, {
    Roact.createElement(App),
})

local PlayerGui = Players.LocalPlayer:WaitForChild("PlayerGui")
-- Create our UI, which now runs on its own!
local handle = Roact.mount(app, PlayerGui, "Root App")

-- Later, we can destroy our UI and disconnect everything correctly.
wait(10)
Roact.unmount(handle)