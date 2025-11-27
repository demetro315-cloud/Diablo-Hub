-- gui.lua
return function()
    -- Services
    local Players = game:GetService("Players")
    local UserInputService = game:GetService("UserInputService")
    local TweenService = game:GetService("TweenService")
    local RunService = game:GetService("RunService")
    
    local player = Players.LocalPlayer
    local mouse = player:GetMouse()
    
    -- GUI Creation
    local ScreenGui = Instance.new("ScreenGui")
    local MainFrame = Instance.new("Frame")
    local TopBar = Instance.new("Frame")
    local Title = Instance.new("TextLabel")
    local CloseButton = Instance.new("TextButton")
    local MinimizeButton = Instance.new("TextButton")
    local TabButtons = Instance.new("Frame")
    local TabContent = Instance.new("Frame")
    local UIPadding = Instance.new("UIPadding")
    local UIListLayout = Instance.new("UIListLayout")
    
    -- GUI Properties
    ScreenGui.Name = "HermanosHub"
    ScreenGui.Parent = game.CoreGui
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    
    MainFrame.Name = "MainFrame"
    MainFrame.Size = UDim2.new(0, 450, 0, 350)
    MainFrame.Position = UDim2.new(0.5, -225, 0.5, -175)
    MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    MainFrame.BorderSizePixel = 0
    MainFrame.ClipsDescendants = true
    MainFrame.Parent = ScreenGui
    
    -- Top Bar
    TopBar.Name = "TopBar"
    TopBar.Size = UDim2.new(1, 0, 0, 30)
    TopBar.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    TopBar.BorderSizePixel = 0
    TopBar.Parent = MainFrame
    
    Title.Name = "Title"
    Title.Size = UDim2.new(0, 200, 1, 0)
    Title.BackgroundTransparency = 1
    Title.Text = "Hermanos Hub v1.0"
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.TextSize = 14
    Title.Font = Enum.Font.GothamBold
    Title.TextXAlignment = Enum.TextXAlignment.Left
    Title.Parent = TopBar
    
    UIPadding.Parent = Title
    UIPadding.PaddingLeft = UDim.new(0, 10)
    
    CloseButton.Name = "CloseButton"
    CloseButton.Size = UDim2.new(0, 30, 1, 0)
    CloseButton.Position = UDim2.new(1, -30, 0, 0)
    CloseButton.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    CloseButton.BorderSizePixel = 0
    CloseButton.Text = "X"
    CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    CloseButton.TextSize = 14
    CloseButton.Font = Enum.Font.GothamBold
    CloseButton.Parent = TopBar
    
    MinimizeButton.Name = "MinimizeButton"
    MinimizeButton.Size = UDim2.new(0, 30, 1, 0)
    MinimizeButton.Position = UDim2.new(1, -60, 0, 0)
    MinimizeButton.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    MinimizeButton.BorderSizePixel = 0
    MinimizeButton.Text = "_"
    MinimizeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    MinimizeButton.TextSize = 14
    MinimizeButton.Font = Enum.Font.GothamBold
    MinimizeButton.Parent = TopBar
    
    -- Tab Buttons
    TabButtons.Name = "TabButtons"
    TabButtons.Size = UDim2.new(0, 120, 1, -30)
    TabButtons.Position = UDim2.new(0, 0, 0, 30)
    TabButtons.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    TabButtons.BorderSizePixel = 0
    TabButtons.Parent = MainFrame
    
    UIListLayout.Parent = TabButtons
    UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    UIListLayout.Padding = UDim.new(0, 5)
    
    -- Tab Content
    TabContent.Name = "TabContent"
    TabContent.Size = UDim2.new(1, -120, 1, -30)
    TabContent.Position = UDim2.new(0, 120, 0, 30)
    TabContent.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    TabContent.BorderSizePixel = 0
    TabContent.Parent = MainFrame
    
    -- Dragging Functionality
    local dragging
    local dragInput
    local dragStart
    local startPos
    
    local function update(input)
        local delta = input.Position - dragStart
        MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
    
    TopBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = MainFrame.Position
            
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)
    
    TopBar.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement then
            dragInput = input
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            update(input)
        end
    end)
    
    -- Button Functions
    CloseButton.MouseButton1Click:Connect(function()
        ScreenGui:Destroy()
    end)
    
    MinimizeButton.MouseButton1Click:Connect(function()
        MainFrame.Visible = not MainFrame.Visible
    end)
    
    -- Tabs System
    local tabs = {}
    local currentTab
    
    local function createTab(tabName)
        local tabButton = Instance.new("TextButton")
        local tabFrame = Instance.new("ScrollingFrame")
        local tabUIList = Instance.new("UIListLayout")
        
        -- Tab Button
        tabButton.Name = tabName .. "Tab"
        tabButton.Size = UDim2.new(0.9, 0, 0, 40)
        tabButton.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
        tabButton.BorderSizePixel = 0
        tabButton.Text = tabName
        tabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        tabButton.TextSize = 12
        tabButton.Font = Enum.Font.Gotham
        tabButton.Parent = TabButtons
        
        -- Tab Content Frame
        tabFrame.Name = tabName .. "Content"
        tabFrame.Size = UDim2.new(1, 0, 1, 0)
        tabFrame.BackgroundTransparency = 1
        tabFrame.BorderSizePixel = 0
        tabFrame.ScrollBarThickness = 3
        tabFrame.ScrollBarImageColor3 = Color3.fromRGB(100, 100, 100)
        tabFrame.Visible = false
        tabFrame.Parent = TabContent
        
        tabUIList.Parent = tabFrame
        tabUIList.Padding = UDim.new(0, 5)
        tabUIList.SortOrder = Enum.SortOrder.LayoutOrder
        
        tabButton.MouseButton1Click:Connect(function()
            if currentTab then
                currentTab.Button.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
                currentTab.Frame.Visible = false
            end
            
            tabButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
            tabFrame.Visible = true
            currentTab = {Button = tabButton, Frame = tabFrame}
        end)
        
        tabs[tabName] = {Button = tabButton, Frame = tabFrame}
        return tabFrame
    end
    
    -- Create Tabs
    local combatTab = createTab("Combat")
    local movementTab = createTab("Movement")
    local visualTab = createTab("Visual")
    local miscTab = createTab("Misc")
    
    -- Select first tab by default
    tabs["Combat"].Button.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    tabs["Combat"].Frame.Visible = true
    currentTab = tabs["Combat"]
    
    -- Button Creation Function
    local function createButton(parent, text, callback)
        local button = Instance.new("TextButton")
        local corner = Instance.new("UICorner")
        
        button.Name = text .. "Button"
        button.Size = UDim2.new(0.95, 0, 0, 35)
        button.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
        button.BorderSizePixel = 0
        button.Text = text
        button.TextColor3 = Color3.fromRGB(255, 255, 255)
        button.TextSize = 12
        button.Font = Enum.Font.Gotham
        button.Parent = parent
        
        corner.CornerRadius = UDim.new(0, 4)
        corner.Parent = button
        
        button.MouseButton1Click:Connect(callback)
        
        -- Hover effects
        button.MouseEnter:Connect(function()
            game:GetService("TweenService"):Create(button, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(55, 55, 55)}):Play()
        end)
        
        button.MouseLeave:Connect(function()
            game:GetService("TweenService"):Create(button, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(45, 45, 45)}):Play()
        end)
        
        return button
    end
    
    -- Toggle Creation Function
    local function createToggle(parent, text, default, callback)
        local toggleFrame = Instance.new("Frame")
        local toggleButton = Instance.new("TextButton")
        local toggleLabel = Instance.new("TextLabel")
        local toggleState = Instance.new("Frame")
        local corner1 = Instance.new("UICorner")
        local corner2 = Instance.new("UICorner")
        
        toggleFrame.Name = text .. "Toggle"
        toggleFrame.Size = UDim2.new(0.95, 0, 0, 30)
        toggleFrame.BackgroundTransparency = 1
        toggleFrame.Parent = parent
        
        toggleLabel.Name = "Label"
        toggleLabel.Size = UDim2.new(0.7, 0, 1, 0)
        toggleLabel.BackgroundTransparency = 1
        toggleLabel.Text = text
        toggleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        toggleLabel.TextSize = 12
        toggleLabel.TextXAlignment = Enum.TextXAlignment.Left
        toggleLabel.Font = Enum.Font.Gotham
        toggleLabel.Parent = toggleFrame
        
        toggleButton.Name = "ToggleButton"
        toggleButton.Size = UDim2.new(0, 40, 0, 20)
        toggleButton.Position = UDim2.new(1, -40, 0.5, -10)
        toggleButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
        toggleButton.BorderSizePixel = 0
        toggleButton.Text = ""
        toggleButton.Parent = toggleFrame
        
        toggleState.Name = "ToggleState"
        toggleState.Size = UDim2.new(0, 16, 0, 16)
        toggleState.Position = UDim2.new(0, 2, 0.5, -8)
        toggleState.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
        toggleState.BorderSizePixel = 0
        toggleState.Parent = toggleButton
        
        corner1.CornerRadius = UDim.new(0, 10)
        corner1.Parent = toggleButton
        
        corner2.CornerRadius = UDim.new(0, 8)
        corner2.Parent = toggleState
        
        local isEnabled = default
        
        local function updateToggle()
            if isEnabled then
                game:GetService("TweenService"):Create(toggleState, TweenInfo.new(0.2), {
                    BackgroundColor3 = Color3.fromRGB(50, 255, 50),
                    Position = UDim2.new(1, -18, 0.5, -8)
                }):Play()
            else
                game:GetService("TweenService"):Create(toggleState, TweenInfo.new(0.2), {
                    BackgroundColor3 = Color3.fromRGB(255, 50, 50),
                    Position = UDim2.new(0, 2, 0.5, -8)
                }):Play()
            end
            callback(isEnabled)
        end
        
        toggleButton.MouseButton1Click:Connect(function()
            isEnabled = not isEnabled
            updateToggle()
        end)
        
        updateToggle()
        return {Set = function(state) isEnabled = state; updateToggle() end, Get = function() return isEnabled end}
    end
    
    -- Add Features to Tabs
    
    -- Combat Tab
    createButton(combatTab, "Kill All", function()
        print("Kill All activated!")
        -- Add your kill all script here
    end)
    
    createButton(combatTab, "Aimbot", function()
        print("Aimbot activated!")
        -- Add your aimbot script here
    end)
    
    -- Movement Tab
    local flyToggle = createToggle(movementTab, "Fly", false, function(state)
        if state then
            -- Add fly script activation here
            loadstring(game:HttpGet("https://raw.githubusercontent.com/hermanos-dev/hermanos-hub/main/fly.lua"))()
        else
            -- Add fly script deactivation here
        end
    end)
    
    local speedToggle = createToggle(movementTab, "Speed", false, function(state)
        if state then
            -- Add speed script activation here
            loadstring(game:HttpGet("https://raw.githubusercontent.com/hermanos-dev/hermanos-hub/main/speed.lua"))()
        else
            -- Add speed script deactivation here
        end
    end)
    
    -- Visual Tab
    local espToggle = createToggle(visualTab, "ESP", false, function(state)
        if state then
            -- Add ESP script activation here
            loadstring(game:HttpGet("https://raw.githubusercontent.com/hermanos-dev/hermanos-hub/main/esp.lua"))()
        else
            -- Add ESP removal here
            for _, player in pairs(Players:GetPlayers()) do
                if player.Character then
                    for _, part in pairs(player.Character:GetDescendants()) do
                        if part.Name == "ESPHighlight" or part.Name == "ESPBillboard" then
                            part:Destroy()
                        end
                    end
                end
            end
        end
    end)
    
    -- Misc Tab
    createButton(miscTab, "Infinite Jump", function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/hermanos-dev/hermanos-hub/main/infinitejump.lua"))()
    end)
    
    createButton(miscTab, "No Clip", function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/hermanos-dev/hermanos-hub/main/noclip.lua"))()
    end)
    
    -- Keybind to open/close GUI (Right Control)
    UserInputService.InputBegan:Connect(function(input, gameProcessed)
        if gameProcessed then return end
        
        if input.KeyCode == Enum.KeyCode.RightControl then
            MainFrame.Visible = not MainFrame.Visible
        end
    end)
    
    print("Hermanos Hub GUI Loaded! Press Right Control to toggle.")
end
