local UserInputService = game:GetService("UserInputService")

-- Variable to control the aiming state
local isAiming = false

-- Function to get the closest player
local function getClosestPlayer()
    local closestDistance = math.huge
    local closestPlayer = nil

    -- Loop through all players in the game
    for _, player in pairs(game.Players:GetPlayers()) do
        -- Exclude the local player and players in the same team
        if player ~= game.Players.LocalPlayer and player.Team ~= game.Players.LocalPlayer.Team then
            local distance = (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - player.Character.HumanoidRootPart.Position).magnitude
            if distance < closestDistance then
                closestDistance = distance
                closestPlayer = player
            end
        end
    end

    return closestPlayer
end

-- When the MouseButton2 is pressed
UserInputService.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton2 then
        isAiming = true
        
        -- Continuously update camera position while aiming
        while isAiming do
            local camera = game.Workspace.CurrentCamera
            local closestPlayer = getClosestPlayer()
            
            if closestPlayer then
                -- Adjust the camera to look at the closest player's head position
                camera.CFrame = CFrame.new(camera.CFrame.Position, closestPlayer.Character.Head.Position)
            end
            
            wait()
        end
    end
end)

-- When the MouseButton2 is released
UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton2 then
        isAiming = false
    end
end)
