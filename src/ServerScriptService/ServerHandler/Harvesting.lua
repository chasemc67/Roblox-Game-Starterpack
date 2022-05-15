local CollectionService = game:GetService("CollectionService")
local HARVESTABLE_TAG = require(script.Parent.Collections).tags.HARVESTABLE
local Data = require(script.Parent.Data)

local harvesting = {}

local function OnHarvest(player, inst)
    print("Destroying tree")
    inst:Destroy()
    Data.increment(player, "Wood", 1)
end

local function attachPromptLogic(inst)
    if inst:IsA("Model") then
        for _,part in pairs(inst:GetDescendants()) do
            if part:IsA("ProximityPrompt") then
                part.Triggered:Connect(function (player) 
                    OnHarvest(player, inst)
                end)
            end
        end
    end
end

for _,inst in pairs(CollectionService:GetTagged(HARVESTABLE_TAG)) do
    attachPromptLogic(inst)
end

CollectionService:GetInstanceAddedSignal(HARVESTABLE_TAG):Connect(attachPromptLogic)

return harvesting