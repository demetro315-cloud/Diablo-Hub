return function()
    local Players = game:GetService("Players")
    local UserInputService = game:GetService("UserInputService")
    local TweenService = game:GetService("TweenService")

    local player = Players.LocalPlayer

    -- Create GUI
    local ScreenGui = Instance.new("ScreenGui")
    local MainFrame = Instance.new("Frame")
    local TopBar = Instance.new("Frame")
    local Title = Instance.new("TextLabel")
    local CloseButton = Instance.new("TextButton")
    local TabButtons = Instance.new("Frame")
    local TabContent = Instance.new("Frame")

    ScreenGui.Name = "DiabloHub"
    ScreenGui.Parent = game.CoreGui
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

    MainFrame.Name = "MainFrame"
    MainFrame.Size = UDim2.new(0, 500, 0, 400)
    MainFrame.Position = UDim2.new(0.5, -250, 0.5, -200)
    MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    MainFrame.BorderSizePixel = 0
    MainFrame.ClipsDescendants = true
    MainFrame.Parent = ScreenGui

    -- Top Bar
    TopBar.Name = "TopBar"
    TopBar.Size = UDim2.new(1, 0, 0, 40)
    TopBar.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    TopBar.BorderSizePixel = 0
    TopBar.Parent = MainFrame

    Title.Name = "Title"
    Title.Size = UDim2.new(0, 200, 1, 0)
    Title.BackgroundTransparency = 1
    Title.Text = "Diablo Hub"
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.TextSize = 16
    Title.Font = Enum.Font.GothamBold
    Title.TextXAlignment = Enum.TextXAlignment.Left
    Title.Parent = TopBar

    local TitlePadding = Instance.new("UIPadding")
    TitlePadding.Parent = Title
    TitlePadding.PaddingLeft = UDim.new(0, 15)

    CloseButton.Name = "CloseButton"
    CloseButton.Size = UDim2.new(0, 40, 1, 0)
    CloseButton.Position = UDim2.new(1, -40, 0, 0)
    CloseButton.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    CloseButton.BorderSizePixel = 0
    CloseButton.Text = "X"
    CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    CloseButton.TextSize = 16
    CloseButton.Font = Enum.Font.GothamBold
    CloseButton.Parent = TopBar

    -- Tab Buttons
    TabButtons.Name = "TabButtons"
    TabButtons.Size = UDim2.new(0, 120, 1, -40)
    TabButtons.Position = UDim2.new(0, 0, 0, 40)
    TabButtons.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    TabButtons.BorderSizePixel = 0
    TabButtons.Parent = MainFrame

    local TabListLayout = Instance.new("UIListLayout")
    TabListLayout.Parent = TabButtons
    TabListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    TabListLayout.Padding = UDim.new(0, 5)

    -- Tab Content
    TabContent.Name = "TabContent"
    TabContent.Size = UDim2.new(1, -120, 1, -40)
    TabContent.Position = UDim2.new(0, 120, 0, 40)
    TabContent.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    TabContent.BorderSizePixel = 0
    TabContent.Parent = MainFrame

    -- Dragging
    local dragging, dragInput, dragStart, startPos

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

    -- Close Button
    CloseButton.MouseButton1Click:Connect(function()
        ScreenGui:Destroy()
    end)

    -- Tabs System
    local tabs = {}
    local currentTab

    local function createTab(tabName)
        local tabButton = Instance.new("TextButton")
        local tabFrame = Instance.new("ScrollingFrame")
        local tabUIList = Instance.new("UIListLayout")
        local tabPadding = Instance.new("UIPadding")
        
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
        
        -- Tab Content
        tabFrame.Name = tabName .. "Content"
        tabFrame.Size = UDim2.new(1, 0, 1, 0)
        tabFrame.BackgroundTransparency = 1
        tabFrame.BorderSizePixel = 0
        tabFrame.ScrollBarThickness = 3
        tabFrame.ScrollBarImageColor3 = Color3.fromRGB(100, 100, 100)
        tabFrame.Visible = false
        tabFrame.Parent = TabContent
        
        tabUIList.Parent = tabFrame
        tabUIList.Padding = UDim.new(0, 8)
        tabUIList.SortOrder = Enum.SortOrder.LayoutOrder
        
        tabPadding.Parent = tabFrame
        tabPadding.PaddingTop = UDim.new(0, 10)
        tabPadding.PaddingLeft = UDim.new(0, 10)
        tabPadding.PaddingRight = UDim.new(0, 10)
        
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

    -- Toggle Function (80% smaller text)
    local function createToggle(parent, text, default, callback)
        local toggleFrame = Instance.new("Frame")
        local toggleButton = Instance.new("TextButton")
        local toggleLabel = Instance.new("TextLabel")
        local toggleState = Instance.new("Frame")
        
        toggleFrame.Name = text .. "Toggle"
        toggleFrame.Size = UDim2.new(1, -20, 0, 25)
        toggleFrame.BackgroundTransparency = 1
        toggleFrame.LayoutOrder = #parent:GetChildren()
        toggleFrame.Parent = parent
        
        toggleLabel.Name = "Label"
        toggleLabel.Size = UDim2.new(0.7, 0, 1, 0)
        toggleLabel.BackgroundTransparency = 1
        toggleLabel.Text = text
        toggleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        toggleLabel.TextSize = 10  -- 80% smaller
        toggleLabel.TextXAlignment = Enum.TextXAlignment.Left
        toggleLabel.Font = Enum.Font.Gotham
        toggleLabel.Parent = toggleFrame
        
        toggleButton.Name = "ToggleButton"
        toggleButton.Size = UDim2.new(0, 35, 0, 16)
        toggleButton.Position = UDim2.new(1, -35, 0.5, -8)
        toggleButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
        toggleButton.BorderSizePixel = 0
        toggleButton.Text = ""
        toggleButton.Parent = toggleFrame
        
        toggleState.Name = "ToggleState"
        toggleState.Size = UDim2.new(0, 12, 0, 12)
        toggleState.Position = UDim2.new(0, 2, 0.5, -6)
        toggleState.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
        toggleState.BorderSizePixel = 0
        toggleState.Parent = toggleButton
        
        local corner1 = Instance.new("UICorner")
        corner1.CornerRadius = UDim.new(0, 8)
        corner1.Parent = toggleButton
        
        local corner2 = Instance.new("UICorner")
        corner2.CornerRadius = UDim.new(0, 6)
        corner2.Parent = toggleState
        
        local isEnabled = default
        
        local function updateToggle()
            if isEnabled then
                toggleState.BackgroundColor3 = Color3.fromRGB(50, 255, 50)
                toggleState.Position = UDim2.new(1, -14, 0.5, -6)
            else
                toggleState.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
                toggleState.Position = UDim2.new(0, 2, 0.5, -6)
            end
            if callback then callback(isEnabled) end
        end
        
        toggleButton.MouseButton1Click:Connect(function()
            isEnabled = not isEnabled
            updateToggle()
        end)
        
        updateToggle()
    end

    -- Create Tabs
    local generalTab = createTab("General")
    local espTab = createTab("ESP")

    -- Add ESP Toggles (Only ESP toggle loads script, others just print)
    createToggle(espTab, "ESP", false, function(state)
        if state then
            local success, err = pcall(function()
                loadstring(game:HttpGet("https://raw.githubusercontent.com/demetro315-cloud/Diablo-Hub/main/esp.lua"))()
            end)
            if not success then
                print("❌ ESP script failed to load:", err)
            end
        end
    end)

    createToggle(espTab, "Player Names", false, function(state)
        print("Player Names:", state, "- Feature coming soon")
    end)

    createToggle(espTab, "Tools in Hotbar", false, function(state)
        print("Tools in Hotbar:", state, "- Feature coming soon")
    end)

    createToggle(espTab, "Skeletons", false, function(state)
        print("Skeletons:", state, "- Feature coming soon")
    end)

    createToggle(espTab, "Box", false, function(state)
        print("Box:", state, "- Feature coming soon")
    end)

    createToggle(espTab, "Distance", false, function(state)
        print("Distance:", state, "- Feature coming soon")
    end)

    -- Select General tab by default
    tabs["General"].Button.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    tabs["General"].Frame.Visible = true
    currentTab = tabs["General"]

    -- Right Control to toggle GUI
    UserInputService.InputBegan:Connect(function(input, gameProcessed)
        if gameProcessed then return end
        if input.KeyCode == Enum.KeyCode.RightControl then
            MainFrame.Visible = not MainFrame.Visible
        end
    end)

    print("🎮 Diablo Hub GUI Loaded!")
    print("🎯 Press Right Control to toggle GUI")
    print("📁 Loaded with 3/6 scripts (ESP, GUI, Loader)")
end
