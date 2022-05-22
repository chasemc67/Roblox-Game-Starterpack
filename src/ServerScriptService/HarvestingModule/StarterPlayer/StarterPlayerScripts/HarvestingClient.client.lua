local CollectionService = game:GetService("CollectionService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local HARVESTABLE_TAG = "HARVESTABLE"

local playerService = game:GetService("Players")
local player = playerService.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()

local ToolChangedEvent = ReplicatedStorage.ToolChanged

local setAllProxPrompts = function(enabled)
    for _,inst in pairs(CollectionService:GetTagged(HARVESTABLE_TAG)) do
        for _,part in pairs(inst:GetDescendants()) do
            if part:IsA("ProximityPrompt") then
                part.Enabled = enabled
            end
        end
    end
end

local setProxPrompt = function()
    -- get currently equipped tool of local player
    if char:FindFirstChild("Tiny Axe") and char["Tiny Axe"]:IsA("Tool") then
        setAllProxPrompts(true)
    else
        setAllProxPrompts(false)
    end
end

ToolChangedEvent.Event:Connect(setProxPrompt)

char.ChildAdded:Connect(function(tool)
	if tool:IsA("Tool") then
		ToolChangedEvent:Fire()
	end
end)