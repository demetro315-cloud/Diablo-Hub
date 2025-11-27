return function()
    local Players = game:GetService("Players")
    local UserInputService = game:GetService("UserInputService")

    local player = Players.LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()
    local humanoid = character:WaitForChild("Humanoid")

    local defaultWalkSpeed = humanoid.WalkSpeed
    local speedBoost = 50

    local function toggleSpeed()
        if humanoid.WalkSpeed == defaultWalkSpeed then
            humanoid.WalkSpeed = defaultWalkSpeed + speedBoost
            print("Speed enabled: " .. humanoid.WalkSpeed)
        else
            humanoid.WalkSpeed = defaultWalkSpeed
            print("Speed disabled")
        end
    end

    UserInputService.InputBegan:Connect(function(input, gameProcessed)
        if gameProcessed then return end
        
        if input.KeyCode == Enum.KeyCode.X then
            toggleSpeed()
        end
    end)

    player.CharacterAdded:Connect(function(newCharacter)
        character = newCharacter
        humanoid = character:WaitForChild("Humanoid")
        defaultWalkSpeed = humanoid.WalkSpeed
    end)
    
    print("Speed Script Loaded! Press X to toggle.")
end
