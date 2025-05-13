local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")

local LocalPlayer = Players.LocalPlayer
local EnchantRemote = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("Enchant")

-- Enchant and Pickaxe data
local Enchants = {
    "Magic Ores",
    "Incredible Damage",
    "Deadly Damage++",
    "Deadly Damage",
    "More Damage",
    "Light Damage",
    "Incredible Luck",
    "Mighty Luck++",
    "Mighty Luck",
    "Considerable Luck",
    "Abnormal Speed"
}

local Pickaxes = {
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

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0.8, 0, 0.7, 0)
MainFrame.Position = UDim2.new(0.1, 0, 0.15, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

local Title = Instance.new("TextLabel")
Title.Name = "Title"
Title.Size = UDim2.new(1, 0, 0.1, 0)
Title.Position = UDim2.new(0, 0, 0, 0)
Title.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Text = "Auto Enchant"
Title.Font = Enum.Font.SourceSansBold
Title.TextSize = 20
Title.Parent = MainFrame

local MinimizeButton = Instance.new("TextButton")
MinimizeButton.Name = "MinimizeButton"
MinimizeButton.Size = UDim2.new(0.1, 0, 0.1, 0)
MinimizeButton.Position = UDim2.new(0.9, 0, 0, 0)
MinimizeButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
MinimizeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
MinimizeButton.Text = "_"
MinimizeButton.Font = Enum.Font.SourceSansBold
MinimizeButton.TextSize = 20
MinimizeButton.Parent = MainFrame

local EnchantLabel = Instance.new("TextLabel")
EnchantLabel.Name = "EnchantLabel"
EnchantLabel.Size = UDim2.new(0.9, 0, 0.1, 0)
EnchantLabel.Position = UDim2.new(0.05, 0, 0.15, 0)
EnchantLabel.BackgroundTransparency = 1
EnchantLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
EnchantLabel.Text = "Select Enchant:"
EnchantLabel.Font = Enum.Font.SourceSans
EnchantLabel.TextSize = 18
EnchantLabel.TextXAlignment = Enum.TextXAlignment.Left
EnchantLabel.Parent = MainFrame

local EnchantDropdown = Instance.new("Frame")
EnchantDropdown.Name = "EnchantDropdown"
EnchantDropdown.Size = UDim2.new(0.9, 0, 0.3, 0)
EnchantDropdown.Position = UDim2.new(0.05, 0, 0.25, 0)
EnchantDropdown.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
EnchantDropdown.ClipsDescendants = true
EnchantDropdown.Visible = false
EnchantDropdown.Parent = MainFrame

local UIListLayout = Instance.new("UIListLayout")
UIListLayout.Parent = EnchantDropdown

local EnchantButton = Instance.new("TextButton")
EnchantButton.Name = "EnchantButton"
EnchantButton.Size = UDim2.new(0.9, 0, 0.1, 0)
EnchantButton.Position = UDim2.new(0.05, 0, 0.15, 0)
EnchantButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
EnchantButton.TextColor3 = Color3.fromRGB(255, 255, 255)
EnchantButton.Text = "Select Enchant"
EnchantButton.Font = Enum.Font.SourceSans
EnchantButton.TextSize = 18
EnchantButton.Parent = MainFrame

local PickaxeLabel = Instance.new("TextLabel")
PickaxeLabel.Name = "PickaxeLabel"
PickaxeLabel.Size = UDim2.new(0.9, 0, 0.1, 0)
PickaxeLabel.Position = UDim2.new(0.05, 0, 0.3, 0)
PickaxeLabel.BackgroundTransparency = 1
PickaxeLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
PickaxeLabel.Text = "Select Pickaxe:"
PickaxeLabel.Font = Enum.Font.SourceSans
PickaxeLabel.TextSize = 18
PickaxeLabel.TextXAlignment = Enum.TextXAlignment.Left
PickaxeLabel.Parent = MainFrame

local PickaxeDropdown = Instance.new("Frame")
PickaxeDropdown.Name = "PickaxeDropdown"
PickaxeDropdown.Size = UDim2.new(0.9, 0, 0.3, 0)
PickaxeDropdown.Position = UDim2.new(0.05, 0, 0.4, 0)
PickaxeDropdown.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
PickaxeDropdown.ClipsDescendants = true
PickaxeDropdown.Visible = false
PickaxeDropdown.Parent = MainFrame

local UIListLayout2 = Instance.new("UIListLayout")
UIListLayout2.Parent = PickaxeDropdown

local PickaxeButton = Instance.new("TextButton")
PickaxeButton.Name = "PickaxeButton"
PickaxeButton.Size = UDim2.new(0.9, 0, 0.1, 0)
PickaxeButton.Position = UDim2.new(0.05, 0, 0.3, 0)
PickaxeButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
PickaxeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
PickaxeButton.Text = "Select Pickaxe"
PickaxeButton.Font = Enum.Font.SourceSans
PickaxeButton.TextSize = 18
PickaxeButton.Parent = MainFrame

local StartButton = Instance.new("TextButton")
StartButton.Name = "StartButton"
StartButton.Size = UDim2.new(0.4, 0, 0.1, 0)
StartButton.Position = UDim2.new(0.3, 0, 0.6, 0)
StartButton.BackgroundColor3 = Color3.fromRGB(0, 120, 0)
StartButton.TextColor3 = Color3.fromRGB(255, 255, 255)
StartButton.Text = "Start"
StartButton.Font = Enum.Font.SourceSansBold
StartButton.TextSize = 20
StartButton.Parent = MainFrame

local StatusLabel = Instance.new("TextLabel")
StatusLabel.Name = "StatusLabel"
StatusLabel.Size = UDim2.new(0.9, 0, 0.1, 0)
StatusLabel.Position = UDim2.new(0.05, 0, 0.75, 0)
StatusLabel.BackgroundTransparency = 1
StatusLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
StatusLabel.Text = "Status: Ready"
StatusLabel.Font = Enum.Font.SourceSans
StatusLabel.TextSize = 18
StatusLabel.TextXAlignment = Enum.TextXAlignment.Left
StatusLabel.Parent = MainFrame

local MinimizedFrame = Instance.new("Frame")
MinimizedFrame.Name = "MinimizedFrame"
MinimizedFrame.Size = UDim2.new(0.2, 0, 0.1, 0)
MinimizedFrame.Position = UDim2.new(0.4, 0, 0, 0)
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
MaximizeButton.TextSize = 16
MaximizeButton.Parent = MinimizedFrame

-- Populate dropdowns
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

for pickaxe, _ in pairs(Pickaxes) do
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
end

local function TogglePickaxeDropdown()
    PickaxeDropdown.Visible = not PickaxeDropdown.Visible
    if EnchantDropdown.Visible then
        EnchantDropdown.Visible = false
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
        StatusLabel.Text = "Status: Please select both enchant and pickaxe"
        return
    end
    
    Running = true
    StatusLabel.Text = "Status: Running..."
    
    spawn(function()
        while Running do
            if CheckEnchant() then
                Running = false
                StatusLabel.Text = "Status: Desired enchant obtained!"
                break
            end
            
            local args = Pickaxes[SelectedPickaxe]
            EnchantRemote:FireServer(unpack(args))
            
            wait(0.5) -- Add delay to prevent crashing
        end
    end)
end

local function StopAutoEnchant()
    Running = false
    StatusLabel.Text = "Status: Stopped"
end

-- Connect events
EnchantButton.MouseButton1Click:Connect(ToggleEnchantDropdown)
PickaxeButton.MouseButton1Click:Connect(TogglePickaxeDropdown)

for _, button in ipairs(EnchantDropdown:GetChildren()) do
    if button:IsA("TextButton") then
        button.MouseButton1Click:Connect(function()
            SelectedEnchant = button.Text
            EnchantButton.Text = "Enchant: " .. SelectedEnchant
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
        StartButton.Text = "Start"
        StartButton.BackgroundColor3 = Color3.fromRGB(0, 120, 0)
    else
        StartAutoEnchant()
        StartButton.Text = "Stop"
        StartButton.BackgroundColor3 = Color3.fromRGB(120, 0, 0)
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
    
    if touchPos.X < framePos.X or touchPos.X > framePos.X + frameSize.X or
       touchPos.Y < framePos.Y or touchPos.Y > framePos.Y + frameSize.Y then
        if EnchantDropdown.Visible then
            EnchantDropdown.Visible = false
        end
        if PickaxeDropdown.Visible then
            PickaxeDropdown.Visible = false
        end
    end
end)

-- Add to player GUI
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

-- Make sure UI is visible
MainFrame.Visible = true
MinimizedFrame.Visible = false
