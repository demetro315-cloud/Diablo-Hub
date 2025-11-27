return function()
    print("👁️ ESP Script Loaded!")
    
    -- Simple ESP test
    local Players = game:GetService("Players")
    local player = Players.LocalPlayer
    
    if player.Character then
        local highlight = Instance.new("Highlight")
        highlight.FillColor = Color3.new(0, 1, 0)
        highlight.OutlineColor = Color3.new(1, 1, 1)
        highlight.FillTransparency = 0.5
        highlight.Parent = player.Character
        print("✅ Green highlight added to your character!")
    end
end
