local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Rodux = require(ReplicatedStorage.Rodux)
local reducer = require(ReplicatedStorage.Reducers.reducer)

-- TODO add Rodux.thunkMiddleware here
-- TODO add server store 
local store = Rodux.Store.new(reducer, nil)

return store