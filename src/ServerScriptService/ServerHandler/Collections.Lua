-- Add tags to objects in workspace for collections service
local collectionService = game:GetService("CollectionService")

local collections = {}
collections.tags = {
    HARVESTABLE = "HARVESTABLE";
}

local palmTrees = workspace.InteractiveEnvironment.Palms

for _, tree in pairs(palmTrees:GetChildren()) do
    collectionService:AddTag(tree, collections.tags.HARVESTABLE)
end

return collections