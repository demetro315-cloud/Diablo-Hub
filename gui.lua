local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

local player = Players.LocalPlayer

-- Create GUI (Auto shows on mobile)
local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local TopBar = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local CloseButton = Instance.new("TextButton")
local MinimizeButton = Instance.new("TextButton")
local TabButtons = Instance.new("Frame")
local TabContent = Instance.new("Frame")

ScreenGui.Name = "DiabloHub"
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

MinimizeButton = Instance.new("TextButton")
MinimizeButton.Name = "MinimizeButton"
MinimizeButton.Size = UDim2.new(0, 40, 1, 0)
MinimizeButton.Position = UDim2.new(1, -80, 0, 0)
MinimizeButton.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
MinimizeButton.BorderSizePixel = 0
MinimizeButton.Text = "_"
MinimizeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
MinimizeButton.TextSize = 16
MinimizeButton.Font = Enum.Font.GothamBold
MinimizeButton.Parent = TopBar

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
    if input.UserInputType == Enum.UserInputType.Touch then
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
    if input.UserInputType == Enum.UserInputType.Touch then
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

-- Minimize Button
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
    toggleLabel.TextSize = 10
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

-- Add ESP Toggles
createToggle(espTab, "ESP", false, function(state)
    if state then
        -- Simple ESP test
        local character = player.Character
        if character then
            local highlight = Instance.new("Highlight")
            highlight.FillColor = Color3.new(0, 1, 0)
            highlight.OutlineColor = Color3.new(1, 1, 1)
            highlight.FillTransparency = 0.5
            highlight.Parent = character
            print("✅ ESP ON - Green highlight added to yourself")
        end
    else
        -- Remove ESP
        local character = player.Character
        if character then
            for _, item in pairs(character:GetChildren()) do
                if item:IsA("Highlight") then
                    item:Destroy()
                end
            end
            print("❌ ESP OFF")
        end
    end
end)

createToggle(espTab, "Player Names", false, function(state)
    print("Player Names:", state)
end)

createToggle(espTab, "Tools in Hotbar", false, function(state)
    print("Tools in Hotbar:", state)
end)

createToggle(espTab, "Skeletons", false, function(state)
    print("Skeletons:", state)
end)

createToggle(espTab, "Box", false, function(state)
    print("Box:", state)
end)

createToggle(espTab, "Distance", false, function(state)
    print("Distance:", state)
end)

-- Select General tab by default
tabs["General"].Button.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
tabs["General"].Frame.Visible = true
currentTab = tabs["General"]

print("📱 Diablo Hub Mobile Loaded!")
print("👆 Drag the top bar to move")
print("➖ Use _ button to hide/show")
print("❌ Use X button to close")
