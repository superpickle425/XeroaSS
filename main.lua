-- [[ XEROA ADMIN SYSTEM - STABLE CORE ]]
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

-- 1. SETUP PLAYER (Fix for image_a64c1c.png)
local lPlayer = Players.LocalPlayer
if not lPlayer then
    -- If in Studio or running as a Server Script, grab the first available player
    lPlayer = Players:GetPlayers()[1] or Players.PlayerAdded:Wait()
end

-- 2. INTERNAL WHITELIST (Prevents image_a5d8b7.png errors)
local whitelistedIDs = {
    [109062335] = true, -- Replace with your actual UserID
    -- Add more IDs here as needed
}

if not whitelistedIDs[lPlayer.UserId] then
    warn("Xeroa: Unauthorized User ID " .. tostring(lPlayer.UserId))
    return
end

-- 3. UI CONSTRUCTION
local PlayerGui = lPlayer:WaitForChild("PlayerGui")
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "XeroaAdminPanel"
screenGui.ResetOnSpawn = false
screenGui.Parent = PlayerGui

local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 400, 0, 250)
mainFrame.Position = UDim2.new(0.5, -200, 0.5, -125)
mainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
mainFrame.BorderSizePixel = 2
mainFrame.BorderColor3 = Color3.fromRGB(170, 0, 255) -- Purple Theme
mainFrame.Active = true
mainFrame.Draggable = true
mainFrame.Parent = screenGui

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0.15, 0)
title.Text = "XEROA SS - ADMIN PANEL"
title.TextColor3 = Color3.new(1, 1, 1)
title.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
title.Parent = mainFrame

local scriptBox = Instance.new("TextBox")
scriptBox.Size = UDim2.new(0.9, 0, 0.5, 0)
scriptBox.Position = UDim2.new(0.05, 0, 0.2, 0)
scriptBox.MultiLine = true
scriptBox.Text = ""
scriptBox.PlaceholderText = "-- Enter Server-Side Script Here..."
scriptBox.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
scriptBox.TextColor3 = Color3.new(1, 1, 1)
scriptBox.Parent = mainFrame

local execBtn = Instance.new("TextButton")
execBtn.Size = UDim2.new(0.4, 0, 0.15, 0)
execBtn.Position = UDim2.new(0.3, 0, 0.8, 0)
execBtn.Text = "EXECUTE"
execBtn.BackgroundColor3 = Color3.fromRGB(85, 0, 127)
execBtn.TextColor3 = Color3.new(1, 1, 1)
execBtn.Parent = mainFrame

-- 4. REMOTE HANDLER
local ReplicatedStorage = game:GetService("ReplicatedStorage")
-- Marathi Name: डेटा_सिंक_इव्हेंट
local remoteName = "\224\164\161\224\165\135\224\164\159\224\164\190_\224\164\184\224\164\191\224\164\130\224\164\149_\224\164\135\224\164\181\224\165\135\224\164\168\224\165\141\224\164\159"
local remote = ReplicatedStorage:FindFirstChild(remoteName)

execBtn.MouseButton1Click:Connect(function()
    if remote then
        remote:FireServer(scriptBox.Text)
    else
        warn("Xeroa: RemoteEvent not found in ReplicatedStorage!")
    end
end)

print("Xeroa SS Loaded Successfully.")
