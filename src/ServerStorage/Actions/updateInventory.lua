local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Rodux = require(ReplicatedStorage.Rodux)

local function updateInventory(player)
    return {
        player = player
    }
end

-- using makeActionCreator just handles having it set the type for us
return Rodux.makeActionCreator(script.Name, updateInventory)
