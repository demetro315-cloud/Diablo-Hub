return function()
    print("👁️ REAL ESP Loaded - Highlighting ALL players!")
    
    local Players = game:GetService("Players")
    
    -- Highlight all other players
    for _, otherPlayer in pairs(Players:GetPlayers()) do
        if otherPlayer ~= Players.LocalPlayer then  -- Skip yourself
            if otherPlayer.Character then
                local highlight = Instance.new("Highlight")
                highlight.Name = "PlayerESP"
                highlight.FillColor = Color3.fromRGB(255, 0, 0)  -- Red
                highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
                highlight.FillTransparency = 0.5
                highlight.Parent = otherPlayer.Character
            end
        end
    end
    
    print("✅ ESP ON - All other players highlighted in RED!")
end
