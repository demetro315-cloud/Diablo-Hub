return function()
    print("GitHub script loaded successfully!")
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "Diablo Hub",
        Text = "Loaded successfully!",
        Duration = 5
    })
end
