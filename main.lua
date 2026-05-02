local Players = game:GetService("Players")
-- This fix ensures it works even if LocalPlayer is slow to load
local lPlayer = Players.LocalPlayer or Players:GetPlayers()[1] 
local PlayerGui = lPlayer:WaitForChild("PlayerGui")

-- 1. SILENT WHITELIST CHECK
-- Update the URL below to your RAW GitHub link for whitelist.lua
local whitelistURL = "https://raw.githubusercontent.com/YourName/Repo/main/whitelist.lua"
local success, data = pcall(function() return game:HttpGet(whitelistURL) end)

if not success or not string.find(data, tostring(lPlayer.UserId)) then
    lPlayer:Kick("\n\nXeroa: System Error 403\nUnauthorized Administrator ID\n\n")
    return
end

-- 2. THE UI (Converted Programmatically)
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "AdminPanel_Internal"
screenGui.ResetOnSpawn = true
screenGui.Parent = PlayerGui

local scrollingFrame = Instance.new("ScrollingFrame")
scrollingFrame.Name = "MainFrame"
scrollingFrame.Size = UDim2.new(0.4, 0, 0.586, 0)
scrollingFrame.Position = UDim2.new(0, 279, 0, 145)
scrollingFrame.BackgroundColor3 = Color3.new(0, 0, 0)
scrollingFrame.BorderSizePixel = 2
scrollingFrame.BorderColor3 = Color3.fromRGB(85, 0, 127)
scrollingFrame.Parent = screenGui

local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(0, 200, 0, 50)
titleLabel.Position = UDim2.new(0.28, 0, 0, 0)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = "Xeroa SS"
titleLabel.TextColor3 = Color3.new(1, 1, 1)
titleLabel.TextSize = 20
titleLabel.Parent = scrollingFrame

local scriptFrame = Instance.new("Frame")
scriptFrame.Size = UDim2.new(0, 344, 0, 248)
scriptFrame.Position = UDim2.new(0.12, 0, 0.035, 0)
scriptFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
scriptFrame.Parent = scrollingFrame

local scriptTextBox = Instance.new("TextBox")
scriptTextBox.Size = UDim2.new(1, 0, 1, 0)
scriptTextBox.BackgroundTransparency = 1
scriptTextBox.Text = ""
scriptTextBox.TextColor3 = Color3.new(1, 1, 1)
scriptTextBox.TextSize = 25
scriptTextBox.TextWrapped = true
scriptTextBox.TextYAlignment = Enum.TextYAlignment.Top
scriptTextBox.MultiLine = true -- Set this to true for multi-line scripts!
scriptTextBox.Parent = scriptFrame

local executeButton = Instance.new("TextButton")
executeButton.Size = UDim2.new(0, 95, 0, 20)
executeButton.Position = UDim2.new(0.72, 0, 1.1, 0)
executeButton.BackgroundColor3 = Color3.fromRGB(2, 70, 1)
executeButton.Text = "Execute"
executeButton.TextColor3 = Color3.new(1, 1, 1)
executeButton.Parent = scriptFrame

-- 3. INTERACTION LOGIC
local ReplicatedStorage = game:GetService("ReplicatedStorage")
-- Using your Marathi Remote name
local remoteEvent = ReplicatedStorage:FindFirstChild("\224\164\161\224\165\135\224\164\159\224\164\190_\224\164\184\224\164\191\224\164\130\224\164\149_\224\164\135\224\164\181\224\165\135\224\164\168\224\165\141\224\164\159")

executeButton.MouseButton1Click:Connect(function()
	local codeToSend = scriptTextBox.Text
	if codeToSend ~= "" and remoteEvent then
		remoteEvent:FireServer(codeToSend)
	end
end)

-- Clear Button logic (Add back if you want the button created above)
-- Drag Detector is already a great touch for usability!
