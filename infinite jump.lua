return function()
    local Players = game:GetService("Players")
    local UserInputService = game:GetService("UserInputService")

    local player = Players.LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()
    local humanoid = character:WaitForChild("Humanoid")

    local infiniteJumpEnabled = false

    UserInputService.InputBegan:Connect(function(input, gameProcessed)
        if gameProcessed then return end
        
        if input.KeyCode == Enum.KeyCode.Space and infiniteJumpEnabled then
            humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
        end
        
        if input.KeyCode == Enum.KeyCode.H then
            infiniteJumpEnabled = not infiniteJumpEnabled
            if infiniteJumpEnabled then
                print("Infinite Jump: ON")
            else
                print("Infinite Jump: OFF")
            end
        end
    end)
    
    print("Infinite Jump Loaded! Press H to toggle.")
end
