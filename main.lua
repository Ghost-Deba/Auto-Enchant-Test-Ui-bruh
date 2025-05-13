local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local LocalPlayer = Players.LocalPlayer
local EnchantRemote = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("Enchant")

-- Create the UI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "AutoEnchantInputUI"
ScreenGui.ResetOnSpawn = false

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0.3, 0, 0.25, 0)
MainFrame.Position = UDim2.new(0.35, 0, 0.05, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

local Title = Instance.new("TextLabel")
Title.Name = "Title"
Title.Size = UDim2.new(1, 0, 0.2, 0)
Title.Position = UDim2.new(0, 0, 0, 0)
Title.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Text = "Auto Enchant Input"
Title.Font = Enum.Font.SourceSansBold
Title.TextSize = 18
Title.Parent = MainFrame

-- Enchant Input
local EnchantLabel = Instance.new("TextLabel")
EnchantLabel.Name = "EnchantLabel"
EnchantLabel.Size = UDim2.new(0.9, 0, 0.15, 0)
EnchantLabel.Position = UDim2.new(0.05, 0, 0.25, 0)
EnchantLabel.BackgroundTransparency = 1
EnchantLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
EnchantLabel.Text = "Enchant Name:"
EnchantLabel.Font = Enum.Font.SourceSans
EnchantLabel.TextSize = 16
EnchantLabel.TextXAlignment = Enum.TextXAlignment.Left
EnchantLabel.Parent = MainFrame

local EnchantTextBox = Instance.new("TextBox")
EnchantTextBox.Name = "EnchantTextBox"
EnchantTextBox.Size = UDim2.new(0.9, 0, 0.15, 0)
EnchantTextBox.Position = UDim2.new(0.05, 0, 0.4, 0)
EnchantTextBox.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
EnchantTextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
EnchantTextBox.PlaceholderText = "e.g. Magic Ores"
EnchantTextBox.Text = ""
EnchantTextBox.Font = Enum.Font.SourceSans
EnchantTextBox.TextSize = 16
EnchantTextBox.Parent = MainFrame

-- Args Input
local ArgsLabel = Instance.new("TextLabel")
ArgsLabel.Name = "ArgsLabel"
ArgsLabel.Size = UDim2.new(0.9, 0, 0.15, 0)
ArgsLabel.Position = UDim2.new(0.05, 0, 0.6, 0)
ArgsLabel.BackgroundTransparency = 1
ArgsLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
ArgsLabel.Text = "Pickaxe Args (x,y):"
ArgsLabel.Font = Enum.Font.SourceSans
ArgsLabel.TextSize = 16
ArgsLabel.TextXAlignment = Enum.TextXAlignment.Left
ArgsLabel.Parent = MainFrame

local ArgsTextBox = Instance.new("TextBox")
ArgsTextBox.Name = "ArgsTextBox"
ArgsTextBox.Size = UDim2.new(0.9, 0, 0.15, 0)
ArgsTextBox.Position = UDim2.new(0.05, 0, 0.75, 0)
ArgsTextBox.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
ArgsTextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
ArgsTextBox.PlaceholderText = "e.g. 6,1"
ArgsTextBox.Text = ""
ArgsTextBox.Font = Enum.Font.SourceSans
ArgsTextBox.TextSize = 16
ArgsTextBox.Parent = MainFrame

-- Activation Button (separate floating button)
local ActivateButton = Instance.new("TextButton")
ActivateButton.Name = "ActivateButton"
ActivateButton.Size = UDim2.new(0, 150, 0, 50)
ActivateButton.Position = UDim2.new(0.8, 0, 0.8, 0)
ActivateButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
ActivateButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ActivateButton.Text = "Start Auto Enchant"
ActivateButton.Font = Enum.Font.SourceSansBold
ActivateButton.TextSize = 16
ActivateButton.Parent = ScreenGui

-- Make button draggable
local dragging
local dragInput
local dragStart
local startPos

local function update(input)
    local delta = input.Position - dragStart
    ActivateButton.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end

ActivateButton.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = ActivateButton.Position
        
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

ActivateButton.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)

game:GetService("UserInputService").InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        update(input)
    end
end)

-- Auto-enchant function
local running = false

local function CheckEnchant(target)
    local success, result = pcall(function()
        return LocalPlayer.PlayerGui.ScreenGui.Enchant.Content.Slots["1"].EnchantName.ContentText
    end)
    
    if success then
        return result == target
    else
        warn("Error checking enchant:", result)
        return false
    end
end

ActivateButton.MouseButton1Click:Connect(function()
    local targetEnchant = EnchantTextBox.Text
    local argsText = ArgsTextBox.Text
    
    if targetEnchant == "" or argsText == "" then
        ActivateButton.Text = "Fill both fields!"
        task.wait(1)
        ActivateButton.Text = running and "Stop" or "Start Auto Enchant"
        return
    end
    
    -- Parse args (accepts "x,y" or "x, y" or "[x,y]")
    local arg1, arg2 = argsText:match("%[?(%d+)%s?,%s?(%d+)%]?")
    if not arg1 or not arg2 then
        ActivateButton.Text = "Invalid args!"
        task.wait(1)
        ActivateButton.Text = running and "Stop" or "Start Auto Enchant"
        return
    end
    
    local args = {tonumber(arg1), tonumber(arg2)}
    
    running = not running
    
    if running then
        ActivateButton.Text = "Stop Auto Enchant"
        ActivateButton.BackgroundColor3 = Color3.fromRGB(120, 0, 0)
        
        -- Start auto-enchanting
        spawn(function()
            while running do
                if CheckEnchant(targetEnchant) then
                    running = false
                    ActivateButton.Text = "Success! Click to restart"
                    ActivateButton.BackgroundColor3 = Color3.fromRGB(0, 120, 0)
                    break
                end
                
                EnchantRemote:FireServer(unpack(args))
                task.wait(0.5) -- Delay between attempts
            end
        end)
    else
        ActivateButton.Text = "Start Auto Enchant"
        ActivateButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    end
end)

-- Add to player GUI
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

-- Example values (optional)
EnchantTextBox.Text = "Magic Ores"
ArgsTextBox.Text = "6,1"
