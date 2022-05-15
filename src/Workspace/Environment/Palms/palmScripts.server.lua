local palmFolder = script.Parent

for _, palm in pairs(palmFolder:GetChildren()) do
	if (palm:IsA("BasePart")) then
		palm.Anchored = true

		local proximityPrompt = Instance.new("ProximityPrompt")
		proximityPrompt.Name = "ProximityPrompt"
		proximityPrompt.ObjectText = "Big Palm"
		proximityPrompt.ActionText = "Hit that tree!"
		proximityPrompt.KeyboardKeyCode = Enum.KeyCode.E
		proximityPrompt.GamePadKeyCode = Enum.KeyCode.ButtonA
		proximityPrompt.MaxDistance = 5

		proximityPrompt.Parent = palm
	end
end