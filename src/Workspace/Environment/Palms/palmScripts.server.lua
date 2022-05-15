local palmFolder = script.Parent

for _, palm in pairs(palmFolder:GetChildren()) do
	if (palm:IsA("BasePart")) then
		palm.Anchored = true

		local proximityPrompt = Instance.new("ProximityPrompt")
		proximityPrompt.Name = "ProximityPrompt"
		proximityPrompt.ObjectText = "Big Palm"
		proximityPrompt.ActionText = "Hit that tree!"
		proximityPrompt.KeyboardKeyCode = Enum.KeyCode.E
		proximityPrompt.GamepadKeyCode = Enum.KeyCode.ButtonA
		proximityPrompt.MaxActivationDistance = 10
		proximityPrompt.HoldDuration = 3
		proximityPrompt.RequiresLineOfSight = false
		
		local palmBase = palm:WaitForChild("Base")
		palmBase.Anchored = true
		palmBase.Size = Vector3.new(0, 0, 0)
		proximityPrompt.Parent = palmBase
	end
end