local CollectionService = game:GetService("CollectionService")
local HARVESTABLE_TAG = require(script.Parent.Collections).tags.HARVESTABLE

local harvesting = {}

local function OnHarvest(inst)
    print("Destroying tree")
    inst:Destroy()
end

local function attachPromptLogic(inst)
    if inst:IsA("Model") then
        for _,part in pairs(inst:GetDescendants()) do
            if part:IsA("ProximityPrompt") then
                part.Triggered:Connect(function (player) 
                    OnHarvest(inst)
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