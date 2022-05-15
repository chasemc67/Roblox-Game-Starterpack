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
		proximityPrompt.MaxActivationDistance = 500
		proximityPrompt.HoldDuration = 3
		
		
		-- get the CFrame
		-- get the length of the size 
		-- get a new CFrame which is 3/4s of the length down the CFrame (ideally respecting position)
		-- or, better yet, some number of units away from the end of the frame
		local palmSize = palm.Size
		print("Palm X: " .. palmSize.X .. "Palm Y: " .. palmSize.Y .. "Palm Z: " .. palmSize.Z)
		local proximityPosition = CFrame.new(palm.Position - Vector3.new(0, palmSize.Y/2 - 5, 0))
		
		local promptPart = Instance.new("Part")
		promptPart.Size = Vector3.new(0,0,0)
		promptPart.Parent = palm
		promptPart.CFrame = proximityPosition
		promptPart.Anchored = true
		proximityPrompt.Parent = promptPart
	end
end