local CollectionService = game:GetService("CollectionService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerStorage = game:GetService("ServerStorage")

local HARVESTABLE_TAG = "HARVESTABLE"
local serverStore = require(ServerStorage:WaitForChild("serverStore"))
local updateInventory = require(ServerStorage:WaitForChild("Actions"):WaitForChild("updateInventory"))

local function OnHarvest(player, inst)
    local loot = nil
    if inst:IsA("Model") then
        for _,part in pairs(inst:GetDescendants()) do
            if part:IsA("ModuleScript") and part.Name == "Drops" then
                loot = require(part)
                break
            end
        end
    end

    inst:Destroy()
    serverStore:dispatch(updateInventory(player, loot))
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