-- Load all modules parented to this script and require them
-- put them each in their own thread so if one is slow or errors ir
-- doesn't impact the rest 
for _, module in pairs(script:GetChildren()) do
	local loadMod = coroutine.create(function()
		require(module)
	end)

	coroutine.resume(loadMod)
end