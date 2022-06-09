local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Rodux = require(ReplicatedStorage.Rodux)

local function inventoryUpdatedAction(inventory)
    return {
        inventory = inventory
    }
end

-- using makeActionCreator just handles having it set the type for us
return Rodux.makeActionCreator(script.Name, inventoryUpdatedAction)
