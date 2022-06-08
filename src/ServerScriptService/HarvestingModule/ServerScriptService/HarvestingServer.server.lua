local CollectionService = game:GetService("CollectionService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerStorage = game:GetService("ServerStorage")

local HARVESTABLE_TAG = "HARVESTABLE"
local Data = require(script.Parent.ServerHandler.Data)
local serverStore = require(ServerStorage.serverStore)
local updateInventory = require(ServerStorage.Actions.updateInventory)

local function OnHarvest(player, inst)
    print("Destroying tree")
    inst:Destroy()
    Data.increment(player, "Wood", 1)
    ReplicatedStorage.InventoryChanged:FireClient(player)
    serverStore:dispatch(updateInventory(player))
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