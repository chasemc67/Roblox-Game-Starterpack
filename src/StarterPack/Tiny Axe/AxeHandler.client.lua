local playerService = game:GetService("Players")
local player = playerService.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local humanoid = char:WaitForChild("Humanoid")
local animator = humanoid:WaitForChild("Animator")
local mouse = player:GetMouse()

local tool = script.Parent
local equipped = false

local startingWalkSpeed = humanoid.WalkSpeed

local animation = tool:WaitForChild("Animation")
local animationTrack = animator:LoadAnimation(animation)
animationTrack.Priority = Enum.AnimationPriority.Action
animationTrack.Looped = true

local ProximityPromptService = game:GetService("ProximityPromptService")


tool.Equipped:Connect(function()
	equipped = true
end)

tool.Unequipped:Connect(function()
	equipped = false
end)

ProximityPromptService.PromptButtonHoldBegan:Connect(function()
	print("Swing axe")
    humanoid.WalkSpeed = 0
    animationTrack:Play()
end)


ProximityPromptService.PromptButtonHoldEnded:Connect(function()
    print("Stop Swinging")
	humanoid.WalkSpeed = startingWalkSpeed
    animationTrack:Stop()
end)