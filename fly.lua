return function()
    local Players = game:GetService("Players")
    local UserInputService = game:GetService("UserInputService")
    local RunService = game:GetService("RunService")

    local player = Players.LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()
    local humanoid = character:WaitForChild("Humanoid")

    local flying = false
    local flySpeed = 50
    local bodyVelocity

    local function startFlying()
        flying = true
        humanoid.PlatformStand = true
        
        bodyVelocity = Instance.new("BodyVelocity")
        bodyVelocity.Velocity = Vector3.new(0, 0, 0)
        bodyVelocity.MaxForce = Vector3.new(40000, 40000, 40000)
        bodyVelocity.Parent = character:FindFirstChild("HumanoidRootPart")
    end

    local function stopFlying()
        flying = false
        humanoid.PlatformStand = false
        if bodyVelocity then
            bodyVelocity:Destroy()
        end
    end

    UserInputService.InputBegan:Connect(function(input, gameProcessed)
        if gameProcessed then return end
        
        if input.KeyCode == Enum.KeyCode.F then
            if flying then
                stopFlying()
            else
                startFlying()
            end
        end
    end)

    RunService.Heartbeat:Connect(function()
        if flying and bodyVelocity then
            local root = character.HumanoidRootPart
            local camera = workspace.CurrentCamera
            
            local forward = camera.CFrame.LookVector
            local right = camera.CFrame.RightVector
            local up = Vector3.new(0, 1, 0)
            
            local direction = Vector3.new(0, 0, 0)
            
            if UserInputService:IsKeyDown(Enum.KeyCode.W) then direction = direction + forward end
            if UserInputService:IsKeyDown(Enum.KeyCode.S) then direction = direction - forward end
            if UserInputService:IsKeyDown(Enum.KeyCode.A) then direction = direction - right end
            if UserInputService:IsKeyDown(Enum.KeyCode.D) then direction = direction + right end
            if UserInputService:IsKeyDown(Enum.KeyCode.Space) then direction = direction + up end
            if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then direction = direction - up end
            
            bodyVelocity.Velocity = direction.Unit * flySpeed
        end
    end)
    
    print("Fly Script Loaded! Press F to toggle.")
end
