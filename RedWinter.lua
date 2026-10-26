--[[
    DARKNES SKRIPT
    Creator: pozkand
    Version: 1.0
    Platform: Roblox Studio
    Location: StarterPlayer > StarterPlayerScripts
]]

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local RED = Color3.fromRGB(255, 20, 45)
local WHITE = Color3.fromRGB(255, 240, 240)
local BLACK = Color3.fromRGB(10, 4, 7)

local settings = {
    ESP = true,
    Names = true,
    Distance = true,
    Snow = true
}

-- Remove an older copy
local previous = playerGui:FindFirstChild("DarknesSkript")
if previous then
    previous:Destroy()
end

-- Screen GUI
local gui = Instance.new("ScreenGui")
gui.Name = "DarknesSkript"
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true
gui.Parent = playerGui

-- Main window
local main = Instance.new("Frame")
main.Name = "Main"
main.Size = UDim2.fromOffset(330, 430)
main.Position = UDim2.new(0.5, -165, 0.5, -215)
main.BackgroundColor3 = BLACK
main.BackgroundTransparency = 0.06
main.BorderSizePixel = 0
main.ClipsDescendants = true
main.Parent = gui

Instance.new("UICorner", main).CornerRadius = UDim.new(0, 16)

local border = Instance.new("UIStroke")
border.Color = RED
border.Thickness = 1.5
border.Parent = main

-- Header
local header = Instance.new("TextLabel")
header.Name = "Title"
header.Size = UDim2.new(1, -60, 0, 42)
header.Position = UDim2.fromOffset(15, 5)
header.BackgroundTransparency = 1
header.Text = "DARKNES SKRIPT"
header.TextColor3 = RED
header.Font = Enum.Font.GothamBlack
header.TextSize = 21
header.TextXAlignment = Enum.TextXAlignment.Left
header.Parent = main

-- Close button
local close = Instance.new("TextButton")
close.Name = "Close"
close.Size = UDim2.fromOffset(34, 34)
close.Position = UDim2.new(1, -44, 0, 9)
close.BackgroundColor3 = Color3.fromRGB(45, 5, 12)
close.Text = "×"
close.TextColor3 = RED
close.Font = Enum.Font.GothamBold
close.TextSize = 25
close.Parent = main

Instance.new("UICorner", close).CornerRadius = UDim.new(0, 9)

-- Image banner
local banner = Instance.new("ImageLabel")
banner.Name = "Banner"
banner.Size = UDim2.new(1, -28, 0, 95)
banner.Position = UDim2.fromOffset(14, 52)
banner.BackgroundColor3 = Color3.fromRGB(35, 5, 10)
banner.Image = "rbxassetid://102984294722507" -- Replace with your image ID
banner.ScaleType = Enum.ScaleType.Crop
banner.Parent = main

Instance.new("UICorner", banner).CornerRadius = UDim.new(0, 10)

local bannerBorder = Instance.new("UIStroke")
bannerBorder.Color = RED
bannerBorder.Parent = banner

-- Status subtitle
local subtitle = Instance.new("TextLabel")
subtitle.Size = UDim2.new(1, -28, 0, 20)
subtitle.Position = UDim2.fromOffset(14, 150)
subtitle.BackgroundTransparency = 1
subtitle.Text = "❄  RED WINTER INTERFACE"
subtitle.TextColor3 = Color3.fromRGB(255, 100, 120)
subtitle.Font = Enum.Font.GothamMedium
subtitle.TextSize = 11
subtitle.TextXAlignment = Enum.TextXAlignment.Left
subtitle.Parent = main

-- Footer
local footer = Instance.new("TextLabel")
footer.Name = "CreatorFooter"
footer.Size = UDim2.new(1, -20, 0, 25)
footer.Position = UDim2.new(0, 10, 1, -30)
footer.BackgroundTransparency = 1
footer.Text = "Player: " .. player.Name .. "  |  Creator: pozkand"
footer.TextColor3 = Color3.fromRGB(255, 90, 110)
footer.Font = Enum.Font.GothamMedium
footer.TextSize = 10
footer.Parent = main

-- Toggle controls
local optionNames = {"ESP", "Names", "Distance", "Snow"}

for i, name in ipairs(optionNames) do
    local row = Instance.new("Frame")
    row.Name = name .. "Row"
    row.Size = UDim2.new(1, -28, 0, 43)
    row.Position = UDim2.fromOffset(14, 177 + (i - 1) * 49)
    row.BackgroundColor3 = Color3.fromRGB(23, 8, 12)
    row.BorderSizePixel = 0
    row.Parent = main

    Instance.new("UICorner", row).CornerRadius = UDim.new(0, 9)

    local rowBorder = Instance.new("UIStroke")
    rowBorder.Color = Color3.fromRGB(90, 15, 28)
    rowBorder.Parent = row

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, -80, 1, 0)
    label.Position = UDim2.fromOffset(12, 0)
    label.BackgroundTransparency = 1
    label.Text = name
    label.TextColor3 = WHITE
    label.Font = Enum.Font.GothamMedium
    label.TextSize = 14
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = row

    local toggle = Instance.new("TextButton")
    toggle.Name = "Toggle"
    toggle.Size = UDim2.fromOffset(48, 26)
    toggle.Position = UDim2.new(1, -60, 0.5, -13)
    toggle.Text = ""
    toggle.BorderSizePixel = 0
    toggle.Parent = row

    Instance.new("UICorner", toggle).CornerRadius = UDim.new(1, 0)

    local knob = Instance.new("Frame")
    knob.Size = UDim2.fromOffset(20, 20)
    knob.Position = UDim2.fromOffset(3, 3)
    knob.BackgroundColor3 = WHITE
    knob.BorderSizePixel = 0
    knob.Parent = toggle

    Instance.new("UICorner", knob).CornerRadius = UDim.new(1, 0)

    local function render(animated)
        local enabled = settings[name]
        local targetColor = enabled and RED or Color3.fromRGB(65, 55, 58)
        local targetPosition = enabled and UDim2.new(1, -23, 0, 3) or UDim2.fromOffset(3, 3)

        if animated then
            TweenService:Create(toggle, TweenInfo.new(0.2), {
                BackgroundColor3 = targetColor
            }):Play()

            TweenService:Create(knob, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {
                Position = targetPosition
            }):Play()
        else
            toggle.BackgroundColor3 = targetColor
            knob.Position = targetPosition
        end
    end

    toggle.Activated:Connect(function()
        settings[name] = not settings[name]
        render(true)
    end)

    render(false)
end

-- Snow animation
local snowflakes = {}

for i = 1, 45 do
    local flake = Instance.new("TextLabel")
    flake.Name = "Snowflake"
    flake.Size = UDim2.fromOffset(24, 24)
    flake.Position = UDim2.new(math.random(), 0, math.random(), 0)
    flake.BackgroundTransparency = 1
    flake.Text = i % 4 == 0 and "❄" or "·"
    flake.TextColor3 = WHITE
    flake.TextTransparency = math.random(0, 4) / 10
    flake.TextSize = math.random(10, 20)
    flake.ZIndex = 5
    flake.Parent = gui

    table.insert(snowflakes, {
        object = flake,
        speed = math.random(15, 55),
        drift = math.random(-12, 12)
    })
end

local snowConnection = RunService.RenderStepped:Connect(function(dt)
    for _, data in ipairs(snowflakes) do
        local flake = data.object
        flake.Visible = settings.Snow

        if settings.Snow then
            local p = flake.Position
            local y = p.Y.Scale + data.speed * dt / 600
            local x = p.X.Scale + data.drift * dt / 1200

            if y > 1.05 then
                y = -0.05
                x = math.random()
            end

            if x > 1 then x = 0 end
            if x < 0 then x = 1 end

            flake.Position = UDim2.new(x, 0, y, 0)
        end
    end
end)

-- Open and close animation
local openSize = main.Size
main.Size = UDim2.fromOffset(0, 0)

TweenService:Create(main, TweenInfo.new(0.45, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
    Size = openSize
}):Play()

local closed = false
local reopenButton

local function openMenu()
    if reopenButton then
        reopenButton:Destroy()
        reopenButton = nil
    end

    main.Visible = true
    main.Size = UDim2.fromOffset(0, 0)
    closed = false

    TweenService:Create(main, TweenInfo.new(0.35, Enum.EasingStyle.Back), {
        Size = openSize
    }):Play()
end

close.Activated:Connect(function()
    if closed then return end
    closed = true

    local tween = TweenService:Create(main, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
        Size = UDim2.fromOffset(0, 0)
    })

    tween:Play()
    tween.Completed:Wait()

    if not gui.Parent then return end
    main.Visible = false

    reopenButton = Instance.new("TextButton")
    reopenButton.Size = UDim2.fromOffset(145, 40)
    reopenButton.Position = UDim2.new(0, 15, 0.5, 0)
    reopenButton.BackgroundColor3 = BLACK
    reopenButton.Text = "❄ DARKNES SKRIPT"
    reopenButton.TextColor3 = RED
    reopenButton.Font = Enum.Font.GothamBold
    reopenButton.TextSize = 12
    reopenButton.Parent = gui

    Instance.new("UICorner", reopenButton).CornerRadius = UDim.new(0, 10)

    local outline = Instance.new("UIStroke")
    outline.Color = RED
    outline.Parent = reopenButton

    reopenButton.Activated:Connect(openMenu)
end)

-- ESP preview for your own Roblox Studio experience.
-- Use only in experiences you own or are authorized to develop.
local espObjects = {}

local function addPlayerESP(target)
    if target == player then return end

    local function setupCharacter(character)
        if espObjects[target] then
            local old = espObjects[target]
            if old.connection then old.connection:Disconnect() end
            if old.highlight then old.highlight:Destroy() end
            if old.billboard then old.billboard:Destroy() end
        end

        local highlight = Instance.new("Highlight")
        highlight.Name = "DarknesPlayerHighlight"
        highlight.FillColor = RED
        highlight.OutlineColor = WHITE
        highlight.FillTransparency = 0.55
        highlight.Adornee = character
        highlight.Parent = character

        local head = character:WaitForChild("Head", 5)
        local billboard

        if head then
            billboard = Instance.new("BillboardGui")
            billboard.Name = "DarknesPlayerInfo"
            billboard.Size = UDim2.fromOffset(200, 30)
            billboard.StudsOffset = Vector3.new(0, 3, 0)
            billboard.AlwaysOnTop = true
            billboard.Adornee = head
            billboard.Parent = playerGui

            local textLabel = Instance.new("TextLabel")
            textLabel.Name = "Info"
            textLabel.Size = UDim2.fromScale(1, 1)
            textLabel.BackgroundTransparency = 1
            textLabel.TextColor3 = WHITE
            textLabel.TextStrokeTransparency = 0.2
            textLabel.TextStrokeColor3 = BLACK
            textLabel.Font = Enum.Font.GothamBold
            textLabel.TextSize = 13
            textLabel.Parent = billboard
        end

        local connection
        connection = RunService.RenderStepped:Connect(function()
            if not character.Parent then
                connection:Disconnect()
                return
            end

            local myCharacter = player.Character
            local root = character:FindFirstChild("HumanoidRootPart")
            local myRoot = myCharacter and myCharacter:FindFirstChild("HumanoidRootPart")

            local distance = root and myRoot and math.floor((root.Position - myRoot.Position).Magnitude)

            highlight.Enabled = settings.ESP and distance ~= nil

            if billboard then
                billboard.Enabled = settings.ESP and distance ~= nil
                local parts = {}

                if settings.Names then
                    table.insert(parts, target.DisplayName)
                end

                if settings.Distance and distance then
                    table.insert(parts, distance .. " studs")
                end

                billboard.Info.Text = table.concat(parts, " | ")
            end
        end)

        espObjects[target] = {
            highlight = highlight,
            billboard = billboard,
            connection = connection
        }
    end

    target.CharacterAdded:Connect(setupCharacter)

    if target.Character then
        task.spawn(setupCharacter, target.Character)
    end
end

for _, target in ipairs(Players:GetPlayers()) do
    addPlayerESP(target)
end

Players.PlayerAdded:Connect(addPlayerESP)

Players.PlayerRemoving:Connect(function(target)
    local data = espObjects[target]

    if data then
        if data.connection then data.connection:Disconnect() end
        if data.highlight then data.highlight:Destroy() end
        if data.billboard then data.billboard:Destroy() end
        espObjects[target] = nil
    end
end)

gui.Destroying:Connect(function()
    snowConnection:Disconnect()

    for _, data in pairs(espObjects) do
        if data.connection then data.connection:Disconnect() end
        if data.highlight then data.highlight:Destroy() end
        if data.billboard then data.billboard:Destroy() end
    end
end)

print("DARKNES SKRIPT loaded | Creator: pozkand")
