local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Rodux = require(ReplicatedStorage.Rodux)

local function loadUser(player, data)
    return {
        player = player,
        data = data
    }
end

-- using makeActionCreator just handles having it set the type for us
return Rodux.makeActionCreator(script.Name, loadUser)
