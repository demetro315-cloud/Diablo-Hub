return function()
    local Players = game:GetService("Players")
    local RunService = game:GetService("RunService")
    
    local ESP_COLOR = Color3.fromRGB(255, 0, 0)
    local ESP_TRANSPARENCY = 0.5
    local TEXT_COLOR = Color3.fromRGB(255, 255, 255)
    
    local function createESP(player)
        if player ~= Players.LocalPlayer then
            local character = player.Character
            if not character then
                player.CharacterAdded:Wait()
                character = player.Character
            end
            
            local humanoid = character:WaitForChild("Humanoid")
            
            for _, part in pairs(character:GetChildren()) do
                if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
                    local highlight = Instance.new("Highlight")
                    highlight.Name = "ESPHighlight"
                    highlight.Parent = part
                    highlight.Adornee = part
                    highlight.FillColor = ESP_COLOR
                    highlight.FillTransparency = ESP_TRANSPARENCY
                    highlight.OutlineColor = TEXT_COLOR
                    highlight.OutlineTransparency = 0
                    
                    local billboard = Instance.new("BillboardGui")
                    billboard.Name = "ESPBillboard"
                    billboard.Parent = part
                    billboard.Adornee = part
                    billboard.Size = UDim2.new(0, 200, 0, 50)
                    billboard.StudsOffset = Vector3.new(0, 3, 0)
                    billboard.AlwaysOnTop = true
                    
                    local textLabel = Instance.new("TextLabel")
                    textLabel.Parent = billboard
                    textLabel.Size = UDim2.new(1, 0, 1, 0)
                    textLabel.Text = player.Name
                    textLabel.TextColor3 = TEXT_COLOR
                    textLabel.TextScaled = true
                    textLabel.BackgroundTransparency = 1
                    textLabel.Font = Enum.Font.GothamBold
                end
            end
        end
    end
    
    for _, player in pairs(Players:GetPlayers()) do
        createESP(player)
    end
    
    Players.PlayerAdded:Connect(function(player)
        createESP(player)
    end)
    
    Players.PlayerAdded:Connect(function(player)
        player.CharacterAdded:Connect(function(character)
            wait(1)
            createESP(player)
        end)
    end)
    
    print("ESP Loaded Successfully!")
end
