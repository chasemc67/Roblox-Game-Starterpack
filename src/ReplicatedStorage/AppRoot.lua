local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Roact = require(ReplicatedStorage.Roact)
local RoactRodux = require(ReplicatedStorage.RoactRodux)

local App = ReplicatedStorage.Components.App

local clientStore = require(ReplicatedStorage.clientStore)

local AppRoot = Roact.createElement(RoactRodux.StoreProvider, {
    store = clientStore
}, {
    Roact.createElement(App)
})

return AppRoot