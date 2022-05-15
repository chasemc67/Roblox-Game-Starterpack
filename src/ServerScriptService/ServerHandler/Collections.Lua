-- Add tags to objects in workspace for collections service
local collectionService = game:GetService("CollectionService")
local harvestableTag = "HARVESTABLE"

local collections = {}

local palmTrees = workspace.InteractiveEnvironment.Palms

for _, tree in pairs(palmTrees:GetChildren()) do
    collectionService:AddTag(tree, harvestableTag)
end

return collections