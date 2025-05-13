local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")

local LocalPlayer = Players.LocalPlayer
local EnchantRemote = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("Enchant")

-- Sorted Enchant and Pickaxe data
local Enchants = {
    "Abnormal Speed",
    "Considerable Luck",
    "Mighty Luck",
    "Mighty Luck++",
    "Incredible Luck",
    "Light Damage",
    "More Damage",
    "Deadly Damage",
    "Deadly Damage++",
    "Incredible Damage",
    "Magic Ores"
}

local Pickaxes = {
    "Iron Pickaxe",
    "Gold Pickaxe",
    "Diamond Pickaxe",
    "Gem Pickaxe",
    "God Pickaxe",
    "Grassy Pickaxe",
    "Ice Pickaxe",
    "Void Pickaxe",
    "Hellfire Pickaxe",
    "Pirate's Pickaxe",
    "Coral Pickaxe",
    "Sharkee Pick",
    "Lava Pickaxe"
}

local PickaxeArgs = {
    ["Iron Pickaxe"] = {1, 1},
    ["Gold Pickaxe"] = {129, 1},
    ["Diamond Pickaxe"] = {128, 1},
    ["Gem Pickaxe"] = {4, 1},
    ["God Pickaxe"] = {130, 1},
    ["Grassy Pickaxe"] = {132, 1},
    ["Ice Pickaxe"] = {131, 1},
    ["Void Pickaxe"] = {6, 1},
    ["Hellfire Pickaxe"] = {133, 1},
    ["Pirate's Pickaxe"] = {8, 1},
    ["Coral Pickaxe"] = {127, 1},
    ["Sharkee Pick"] = {9, 1},
    ["Lava Pickaxe"] = {76, 1}
}

-- Create the UI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "AutoEnchantUI"
ScreenGui.ResetOnSpawn = false

-- Main Frame (smaller size)
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0.7, 0, 0.5, 0) -- Smaller size
MainFrame.Position = UDim2.new(0.15, 0, 0.25, 0) -- Centered position
MainFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

local Title = Instance.new("TextLabel")
Title.Name = "Title"
Title.Size = UDim2.new(1, 0, 0.12, 0) -- Slightly taller for better touch
Title.Position = UDim2.new(0, 0, 0, 0)
Title.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Text = "Auto Enchant"
Title.Font = Enum.Font.SourceSansBold
Title.TextSize = 18 -- Smaller text size
Title.Parent = MainFrame

local MinimizeButton = Instance.new("TextButton")
MinimizeButton.Name = "MinimizeButton"
MinimizeButton.Size = UDim2.new(0.1, 0, 1, 0)
MinimizeButton.Position = UDim2.new(0.9, 0, 0, 0)
MinimizeButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
MinimizeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
MinimizeButton.Text = "_"
MinimizeButton.Font = Enum.Font.SourceSansBold
MinimizeButton.TextSize = 18
MinimizeButton.Parent = Title

-- Enchant Selection
local EnchantLabel = Instance.new("TextLabel")
EnchantLabel.Name = "EnchantLabel"
EnchantLabel.Size = UDim2.new(0.9, 0, 0.1, 0)
EnchantLabel.Position = UDim2.new(0.05, 0, 0.15, 0)
EnchantLabel.BackgroundTransparency = 1
EnchantLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
EnchantLabel.Text = "Select Enchant:"
EnchantLabel.Font = Enum.Font.SourceSans
EnchantLabel.TextSize = 16 -- Smaller text
EnchantLabel.TextXAlignment = Enum.TextXAlignment.Left
EnchantLabel.Parent = MainFrame

local EnchantButton = Instance.new("TextButton")
EnchantButton.Name = "EnchantButton"
EnchantButton.Size = UDim2.new(0.9, 0, 0.1, 0)
EnchantButton.Position = UDim2.new(0.05, 0, 0.25, 0)
EnchantButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
EnchantButton.TextColor3 = Color3.fromRGB(255, 255, 255)
EnchantButton.Text = "Click to select"
EnchantButton.Font = Enum.Font.SourceSans
EnchantButton.TextSize = 16
EnchantButton.Parent = MainFrame

local EnchantDropdown = Instance.new("ScrollingFrame") -- Changed to ScrollingFrame
EnchantDropdown.Name = "EnchantDropdown"
EnchantDropdown.Size = UDim2.new(0.9, 0, 0.3, 0)
EnchantDropdown.Position = UDim2.new(0.05, 0, 0.25, 0)
EnchantDropdown.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
EnchantDropdown.ScrollBarThickness = 6 -- Scrollbar thickness
EnchantDropdown.CanvasSize = UDim2.new(0, 0, 0, #Enchants * 30) -- Dynamic canvas size
EnchantDropdown.Visible = false
EnchantDropdown.Parent = MainFrame

local EnchantListLayout = Instance.new("UIListLayout")
EnchantListLayout.Parent = EnchantDropdown

-- Pickaxe Selection
local PickaxeLabel = Instance.new("TextLabel")
PickaxeLabel.Name = "PickaxeLabel"
PickaxeLabel.Size = UDim2.new(0.9, 0, 0.1, 0)
PickaxeLabel.Position = UDim2.new(0.05, 0, 0.4, 0)
PickaxeLabel.BackgroundTransparency = 1
PickaxeLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
PickaxeLabel.Text = "Select Pickaxe:"
PickaxeLabel.Font = Enum.Font.SourceSans
PickaxeLabel.TextSize = 16
PickaxeLabel.TextXAlignment = Enum.TextXAlignment.Left
PickaxeLabel.Parent = MainFrame

local PickaxeButton = Instance.new("TextButton")
PickaxeButton.Name = "PickaxeButton"
PickaxeButton.Size = UDim2.new(0.9, 0, 0.1, 0)
PickaxeButton.Position = UDim2.new(0.05, 0, 0.5, 0)
PickaxeButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
PickaxeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
PickaxeButton.Text = "Click to select"
PickaxeButton.Font = Enum.Font.SourceSans
PickaxeButton.TextSize = 16
PickaxeButton.Parent = MainFrame

local PickaxeDropdown = Instance.new("ScrollingFrame") -- Changed to ScrollingFrame
PickaxeDropdown.Name = "PickaxeDropdown"
PickaxeDropdown.Size = UDim2.new(0.9, 0, 0.3, 0)
PickaxeDropdown.Position = UDim2.new(0.05, 0, 0.5, 0)
PickaxeDropdown.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
PickaxeDropdown.ScrollBarThickness = 6
PickaxeDropdown.CanvasSize = UDim2.new(0, 0, 0, #Pickaxes * 30)
PickaxeDropdown.Visible = false
PickaxeDropdown.Parent = MainFrame

local PickaxeListLayout = Instance.new("UIListLayout")
PickaxeListLayout.Parent = PickaxeDropdown

-- Start/Stop Button
local StartButton = Instance.new("TextButton")
StartButton.Name = "StartButton"
StartButton.Size = UDim2.new(0.4, 0, 0.1, 0)
StartButton.Position = UDim2.new(0.3, 0, 0.65, 0)
StartButton.BackgroundColor3 = Color3.fromRGB(0, 120, 0)
StartButton.TextColor3 = Color3.fromRGB(255, 255, 255)
StartButton.Text = "Start"
StartButton.Font = Enum.Font.SourceSansBold
StartButton.TextSize = 18
StartButton.Parent = MainFrame

-- Status Label
local StatusLabel = Instance.new("TextLabel")
StatusLabel.Name = "StatusLabel"
StatusLabel.Size = UDim2.new(0.9, 0, 0.1, 0)
StatusLabel.Position = UDim2.new(0.05, 0, 0.8, 0)
StatusLabel.BackgroundTransparency = 1
StatusLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
StatusLabel.Text = "Status: Ready"
StatusLabel.Font = Enum.Font.SourceSans
StatusLabel.TextSize = 16
StatusLabel.TextXAlignment = Enum.TextXAlignment.Left
StatusLabel.Parent = MainFrame

-- Minimized Frame
local MinimizedFrame = Instance.new("Frame")
MinimizedFrame.Name = "MinimizedFrame"
MinimizedFrame.Size = UDim2.new(0.15, 0, 0.06, 0) -- Smaller minimized frame
MinimizedFrame.Position = UDim2.new(0.425, 0, 0, 0)
MinimizedFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
MinimizedFrame.BorderSizePixel = 0
MinimizedFrame.Active = true
MinimizedFrame.Draggable = true
MinimizedFrame.Visible = false
MinimizedFrame.Parent = ScreenGui

local MaximizeButton = Instance.new("TextButton")
MaximizeButton.Name = "MaximizeButton"
MaximizeButton.Size = UDim2.new(1, 0, 1, 0)
MaximizeButton.Position = UDim2.new(0, 0, 0, 0)
MaximizeButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
MaximizeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
MaximizeButton.Text = "Auto Enchant"
MaximizeButton.Font = Enum.Font.SourceSansBold
MaximizeButton.TextSize = 14 -- Smaller text
MaximizeButton.Parent = MinimizedFrame

-- Populate dropdowns with scrolling
for _, enchant in ipairs(Enchants) do
    local button = Instance.new("TextButton")
    button.Name = enchant
    button.Size = UDim2.new(1, 0, 0, 30)
    button.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.Text = enchant
    button.Font = Enum.Font.SourceSans
    button.TextSize = 16
    button.Parent = EnchantDropdown
end

for _, pickaxe in ipairs(Pickaxes) do
    local button = Instance.new("TextButton")
    button.Name = pickaxe
    button.Size = UDim2.new(1, 0, 0, 30)
    button.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.Text = pickaxe
    button.Font = Enum.Font.SourceSans
    button.TextSize = 16
    button.Parent = PickaxeDropdown
end

-- Variables
local SelectedEnchant = nil
local SelectedPickaxe = nil
local Running = false

-- Functions
local function ToggleEnchantDropdown()
    EnchantDropdown.Visible = not EnchantDropdown.Visible
    if PickaxeDropdown.Visible then
        PickaxeDropdown.Visible = false
    end
    -- Bring to front when opened
    if EnchantDropdown.Visible then
        EnchantDropdown.ZIndex = 10
    else
        EnchantDropdown.ZIndex = 1
    end
end

local function TogglePickaxeDropdown()
    PickaxeDropdown.Visible = not PickaxeDropdown.Visible
    if EnchantDropdown.Visible then
        EnchantDropdown.Visible = false
    end
    -- Bring to front when opened
    if PickaxeDropdown.Visible then
        PickaxeDropdown.ZIndex = 10
    else
        PickaxeDropdown.ZIndex = 1
    end
end

local function MinimizeUI()
    MainFrame.Visible = false
    MinimizedFrame.Visible = true
end

local function MaximizeUI()
    MainFrame.Visible = true
    MinimizedFrame.Visible = false
end

local function CheckEnchant()
    local success, result = pcall(function()
        return LocalPlayer.PlayerGui.ScreenGui.Enchant.Content.Slots["1"].EnchantName.ContentText
    end)
    
    if success then
        return result == SelectedEnchant
    else
        StatusLabel.Text = "Status: Error checking enchant"
        return false
    end
end

local function StartAutoEnchant()
    if not SelectedEnchant or not SelectedPickaxe then
        StatusLabel.Text = "Status: Please select both"
        return
    end
    
    Running = true
    StatusLabel.Text = "Status: Running..."
    StartButton.Text = "Stop"
    StartButton.BackgroundColor3 = Color3.fromRGB(120, 0, 0)
    
    spawn(function()
        while Running do
            if CheckEnchant() then
                Running = false
                StatusLabel.Text = "Status: Success!"
                StartButton.Text = "Start"
                StartButton.BackgroundColor3 = Color3.fromRGB(0, 120, 0)
                break
            end
            
            local args = PickaxeArgs[SelectedPickaxe]
            EnchantRemote:FireServer(unpack(args))
            
            wait(0.5) -- Safer delay
        end
    end)
end

local function StopAutoEnchant()
    Running = false
    StatusLabel.Text = "Status: Stopped"
    StartButton.Text = "Start"
    StartButton.BackgroundColor3 = Color3.fromRGB(0, 120, 0)
end

-- Connect events
EnchantButton.MouseButton1Click:Connect(ToggleEnchantDropdown)
PickaxeButton.MouseButton1Click:Connect(TogglePickaxeDropdown)

for _, button in ipairs(EnchantDropdown:GetChildren()) do
    if button:IsA("TextButton") then
        button.MouseButton1Click:Connect(function()
            SelectedEnchant = button.Text
            EnchantButton.Text = "Enchant: " .. (string.len(SelectedEnchant) > 15 
                and string.sub(SelectedEnchant, 1, 15) .. "..." 
                or SelectedEnchant)
            EnchantDropdown.Visible = false
        end)
    end
end

for _, button in ipairs(PickaxeDropdown:GetChildren()) do
    if button:IsA("TextButton") then
        button.MouseButton1Click:Connect(function()
            SelectedPickaxe = button.Text
            PickaxeButton.Text = "Pickaxe: " .. SelectedPickaxe
            PickaxeDropdown.Visible = false
        end)
    end
end

StartButton.MouseButton1Click:Connect(function()
    if Running then
        StopAutoEnchant()
    else
        StartAutoEnchant()
    end
end)

MinimizeButton.MouseButton1Click:Connect(MinimizeUI)
MaximizeButton.MouseButton1Click:Connect(MaximizeUI)

-- Handle mobile input
UserInputService.TouchStarted:Connect(function(touch, gameProcessed)
    if gameProcessed then return end
    
    if not MainFrame.Visible and not MinimizedFrame.Visible then return end
    
    local frame = MainFrame.Visible and MainFrame or MinimizedFrame
    local touchPos = touch.Position
    local framePos = frame.AbsolutePosition
    local frameSize = frame.AbsoluteSize
    
    -- Close dropdowns if tapping outside
    if (EnchantDropdown.Visible or PickaxeDropdown.Visible) and
       (touchPos.X < framePos.X or touchPos.X > framePos.X + frameSize.X or
        touchPos.Y < framePos.Y or touchPos.Y > framePos.Y + frameSize.Y) then
        EnchantDropdown.Visible = false
        PickaxeDropdown.Visible = false
    end
end)

-- Add to player GUI
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

-- Initial state
MainFrame.Visible = true
MinimizedFrame.Visible = false
