local CollectionService = game:GetService("CollectionService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ProximityPromptService = game:GetService("ProximityPromptService")
local HARVESTABLE_TAG = "HARVESTABLE"

local playerService = game:GetService("Players")
local player = playerService.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local humanoid = char:WaitForChild("Humanoid")
local startingWalkSpeed = humanoid.WalkSpeed

local ToolChangedEvent = ReplicatedStorage:WaitForChild("ToolChanged")

local runningAnimationTrack = nil

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
    local tool
    for _,child in pairs(char:GetChildren()) do
        if child:IsA("Tool") then
            tool = child
            break
        end
    end
    if tool then
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

local getAnimationTrackForCurrentToolOrDefault = function()
    local defaultAnimation = Instance.new("Animation")
    defaultAnimation.AnimationId = "rbxassetid://9633674639"

    local animator = humanoid:WaitForChild("Animator")

    local tool
    for _,child in pairs(char:GetChildren()) do
        if child:IsA("Tool") then
            tool = child
            break
        end
    end

    local animation
    for _,child in pairs(tool:GetChildren()) do
        if child:IsA("Animation") then
            animation = child
            break
        end
    end

    if not animation then
        defaultAnimation.Parent = tool
    end

    local animationTrack
    if animation then
        animationTrack = animator:LoadAnimation(animation)
    else
        animationTrack = animator:LoadAnimation(defaultAnimation)
    end

    animationTrack.Priority = Enum.AnimationPriority.Action
    animationTrack.Looped = true

    return animationTrack
end

ProximityPromptService.PromptButtonHoldBegan:Connect(function()
	print("Swing axe")
    humanoid.WalkSpeed = 0
    runningAnimationTrack = getAnimationTrackForCurrentToolOrDefault()
    runningAnimationTrack:Play()
end)

ProximityPromptService.PromptButtonHoldEnded:Connect(function()
    print("Stop Swinging")
	humanoid.WalkSpeed = startingWalkSpeed
    if runningAnimationTrack then
        runningAnimationTrack:Stop()
    end
    runningAnimationTrack = nil
end)