return function()
    local Players = game:GetService("Players")
    local UserInputService = game:GetService("UserInputService")
    local RunService = game:GetService("RunService")

    local player = Players.LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()
    local humanoid = character:WaitForChild("Humanoid")

    local noClip = false

    local function toggleNoClip()
        noClip = not noClip
        if noClip then
            print("No Clip: ON")
        else
            print("No Clip: OFF")
        end
    end

    UserInputService.InputBegan:Connect(function(input, gameProcessed)
        if gameProcessed then return end
        
        if input.KeyCode == Enum.KeyCode.N then
            toggleNoClip()
        end
    end)

    RunService.Stepped:Connect(function()
        if noClip and character then
            for _, part in pairs(character:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanCollide = false
                end
            end
        end
    end)
    
    print("No Clip Loaded! Press N to toggle.")
end
