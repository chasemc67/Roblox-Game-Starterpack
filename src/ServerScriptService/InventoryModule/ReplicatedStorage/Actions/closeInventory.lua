local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Rodux = require(ReplicatedStorage.Rodux)

local function closeInventory()
    return {
    }
end

-- using makeActionCreator just handles having it set the type for us
return Rodux.makeActionCreator(script.Name, closeInventory)
