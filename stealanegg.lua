local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local StarterGui = game:GetService("StarterGui")
local LocalPlayer = Players.LocalPlayer

local AntiRagdollEnabled = true
local FPSBoostEnabled = false
local frozen = false
local frozenCFrame = nil
local currentCharacter = nil
local currentHumanoid = nil
local currentHRP = nil

local RagdollStates = {
    [Enum.HumanoidStateType.Ragdoll] = true,
    [Enum.HumanoidStateType.FallingDown] = true,
    [Enum.HumanoidStateType.Physics] = true,
}

local function notify(msg)
    pcall(function()
        StarterGui:SetCore("SendNotification", {
            Title = "Amzz Hub",
            Text = msg,
            Duration = 3,
        })
    end)
end

local function ProtectCharacter(character)
    local humanoid = character:WaitForChild("Humanoid", 10)
    local hrp = character:WaitForChild("HumanoidRootPart", 10)
    if not humanoid or not hrp then return end

    currentCharacter = character
    currentHumanoid = humanoid
    currentHRP = hrp

    for state in pairs(RagdollStates) do
        pcall(function() humanoid:SetStateEnabled(state, false) end)
    end

    humanoid.StateChanged:Connect(function(_, newState)
        if not AntiRagdollEnabled then return end
        if RagdollStates[newState] then
            frozen = true
            frozenCFrame = hrp.CFrame
            task.delay(1, function()
                frozen = false
                frozenCFrame = nil
            end)
        end
    end)

    RunService.RenderStepped:Connect(function()
        if not AntiRagdollEnabled then return end
        if not character.Parent or not humanoid.Parent then return end
        pcall(function()
            local s = humanoid:GetState()
            if RagdollStates[s] then
                humanoid:ChangeState(Enum.HumanoidStateType.RunningNoPhysics)
            end
            if humanoid.PlatformStand then
                humanoid.PlatformStand = false
            end

            if frozen and frozenCFrame then
                hrp.CFrame = frozenCFrame
                humanoid.WalkSpeed = 0
                humanoid.JumpPower = 0
            else
                if humanoid.WalkSpeed == 0 and humanoid.Health > 0 then
                    humanoid.WalkSpeed = 16
                end
                if humanoid.JumpPower == 0 and humanoid.Health > 0 then
                    humanoid.JumpPower = 50
                end
            end

            for _, part in ipairs(character:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanCollide = true
                end
            end
        end)
    end)

    task.spawn(function()
        while character.Parent do
            if AntiRagdollEnabled then
                pcall(function()
                    for _, joint in ipairs(character:GetDescendants()) do
                        if joint:IsA("Motor6D") and joint.Enabled == false then
                            joint.Enabled = true
                        end
                    end
                end)
            end
            task.wait()
        end
    end)
end

LocalPlayer.CharacterAdded:Connect(function(char)
    task.wait(0.2)
    ProtectCharacter(char)
end)

if LocalPlayer.Character then
    ProtectCharacter(LocalPlayer.Character)
end

local oldGui = LocalPlayer:FindFirstChild("PlayerGui")
if oldGui then
    local old = oldGui:FindFirstChild("AmzzHub")
    if old then old:Destroy() end
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "AmzzHub"
ScreenGui.ResetOnSpawn = false
ScreenGui.DisplayOrder = 999
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui", 10)

local ToggleBtn = Instance.new("TextButton")
ToggleBtn.Name = "ToggleBtn"
ToggleBtn.Size = UDim2.new(0, 70, 0, 70)
ToggleBtn.Position = UDim2.new(0, 30, 0, 150)
ToggleBtn.BackgroundColor3 = Color3.fromRGB(200, 40, 40)
ToggleBtn.BorderSizePixel = 0
ToggleBtn.Text = "Amzz Hub"
ToggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleBtn.TextScaled = true
ToggleBtn.Font = Enum.Font.GothamBold
ToggleBtn.AutoButtonColor = false
ToggleBtn.Active = true
ToggleBtn.Draggable = true
ToggleBtn.Parent = ScreenGui

local ToggleCorner = Instance.new("UICorner")
ToggleCorner.CornerRadius = UDim.new(1, 0)
ToggleCorner.Parent = ToggleBtn

local ToggleStroke = Instance.new("UIStroke")
ToggleStroke.Color = Color3.fromRGB(0, 120, 255)
ToggleStroke.Thickness = 2
ToggleStroke.Parent = ToggleBtn

local ToggleGradient = Instance.new("UIGradient")
ToggleGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(200, 40, 40)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 120, 255)),
})
ToggleGradient.Rotation = 45
ToggleGradient.Parent = ToggleBtn

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 380, 0, 320)
MainFrame.Position = UDim2.new(0.5, -190, 0.5, -160)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 28)
MainFrame.BorderSizePixel = 0
MainFrame.Visible = false
MainFrame.Active = true
MainFrame.Parent = ScreenGui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 10)
MainCorner.Parent = MainFrame

local MainStroke = Instance.new("UIStroke")
MainStroke.Color = Color3.fromRGB(0, 120, 255)
MainStroke.Thickness = 1.5
MainStroke.Parent = MainFrame

local TitleBar = Instance.new("Frame")
TitleBar.Name = "TitleBar"
TitleBar.Size = UDim2.new(1, 0, 0, 38)
TitleBar.BackgroundColor3 = Color3.fromRGB(200, 40, 40)
TitleBar.BorderSizePixel = 0
TitleBar.Parent = MainFrame

local TitleCorner = Instance.new("UICorner")
TitleCorner.CornerRadius = UDim.new(0, 10)
TitleCorner.Parent = TitleBar

local TitleFix = Instance.new("Frame")
TitleFix.Size = UDim2.new(1, 0, 0, 14)
TitleFix.Position = UDim2.new(0, 0, 1, -14)
TitleFix.BackgroundColor3 = Color3.fromRGB(200, 40, 40)
TitleFix.BorderSizePixel = 0
TitleFix.Parent = TitleBar

local TitleLabel = Instance.new("TextLabel")
TitleLabel.Size = UDim2.new(1, -50, 1, 0)
TitleLabel.Position = UDim2.new(0, 12, 0, 0)
TitleLabel.BackgroundTransparency = 1
TitleLabel.Text = "AMZZ HUB"
TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleLabel.TextScaled = true
TitleLabel.Font = Enum.Font.GothamBold
TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
TitleLabel.Parent = TitleBar

local CloseBtn = Instance.new("TextButton")
CloseBtn.Name = "CloseBtn"
CloseBtn.Size = UDim2.new(0, 28, 0, 28)
CloseBtn.Position = UDim2.new(1, -34, 0.5, -14)
CloseBtn.BackgroundColor3 = Color3.fromRGB(255, 60, 60)
CloseBtn.BorderSizePixel = 0
CloseBtn.Text = "X"
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.TextScaled = true
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.AutoButtonColor = false
CloseBtn.Parent = TitleBar

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(1, 0)
CloseCorner.Parent = CloseBtn

local ToolsLabel = Instance.new("TextLabel")
ToolsLabel.Size = UDim2.new(1, -30, 0, 32)
ToolsLabel.Position = UDim2.new(0, 15, 0, 50)
ToolsLabel.BackgroundTransparency = 1
ToolsLabel.Text = "TOOLS"
ToolsLabel.TextColor3 = Color3.fromRGB(0, 170, 255)
ToolsLabel.TextScaled = true
ToolsLabel.Font = Enum.Font.GothamBold
ToolsLabel.TextXAlignment = Enum.TextXAlignment.Left
ToolsLabel.Parent = MainFrame

local AntiRagdollRow = Instance.new("Frame")
AntiRagdollRow.Size = UDim2.new(1, -30, 0, 44)
AntiRagdollRow.Position = UDim2.new(0, 15, 0, 88)
AntiRagdollRow.BackgroundColor3 = Color3.fromRGB(30, 30, 42)
AntiRagdollRow.BorderSizePixel = 0
AntiRagdollRow.Parent = MainFrame

local AntiRagdollCorner = Instance.new("UICorner")
AntiRagdollCorner.CornerRadius = UDim.new(0, 6)
AntiRagdollCorner.Parent = AntiRagdollRow

local AntiRagdollLabel = Instance.new("TextLabel")
AntiRagdollLabel.Size = UDim2.new(1, -100, 1, 0)
AntiRagdollLabel.Position = UDim2.new(0, 14, 0, 0)
AntiRagdollLabel.BackgroundTransparency = 1
AntiRagdollLabel.Text = "Anti Ragdoll"
AntiRagdollLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
AntiRagdollLabel.TextSize = 16
AntiRagdollLabel.Font = Enum.Font.Gotham
AntiRagdollLabel.TextXAlignment = Enum.TextXAlignment.Left
AntiRagdollLabel.Parent = AntiRagdollRow

local AntiRagdollToggle = Instance.new("TextButton")
AntiRagdollToggle.Size = UDim2.new(0, 70, 0, 30)
AntiRagdollToggle.Position = UDim2.new(1, -84, 0.5, -15)
AntiRagdollToggle.BackgroundColor3 = Color3.fromRGB(0, 200, 100)
AntiRagdollToggle.BorderSizePixel = 0
AntiRagdollToggle.Text = "ON"
AntiRagdollToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
AntiRagdollToggle.TextSize = 15
AntiRagdollToggle.Font = Enum.Font.GothamBold
AntiRagdollToggle.AutoButtonColor = false
AntiRagdollToggle.Parent = AntiRagdollRow

local AntiRagdollToggleCorner = Instance.new("UICorner")
AntiRagdollToggleCorner.CornerRadius = UDim.new(0, 6)
AntiRagdollToggleCorner.Parent = AntiRagdollToggle

AntiRagdollToggle.MouseButton1Click:Connect(function()
    AntiRagdollEnabled = not AntiRagdollEnabled
    if AntiRagdollEnabled then
        AntiRagdollToggle.Text = "ON"
        AntiRagdollToggle.BackgroundColor3 = Color3.fromRGB(0, 200, 100)
        if currentHumanoid then
            for state in pairs(RagdollStates) do
                pcall(function() currentHumanoid:SetStateEnabled(state, false) end)
            end
        end
        notify("Anti Ragdoll ON")
    else
        AntiRagdollToggle.Text = "OFF"
        AntiRagdollToggle.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
        frozen = false
        frozenCFrame = nil
        if currentHumanoid then
            for state in pairs(RagdollStates) do
                pcall(function() currentHumanoid:SetStateEnabled(state, true) end)
            end
            pcall(function()
                currentHumanoid.WalkSpeed = 16
                currentHumanoid.JumpPower = 50
            end)
        end
        notify("Anti Ragdoll OFF")
    end
end)

local FPSBoostRow = Instance.new("Frame")
FPSBoostRow.Size = UDim2.new(1, -30, 0, 44)
FPSBoostRow.Position = UDim2.new(0, 15, 0, 140)
FPSBoostRow.BackgroundColor3 = Color3.fromRGB(30, 30, 42)
FPSBoostRow.BorderSizePixel = 0
FPSBoostRow.Parent = MainFrame

local FPSBoostCorner = Instance.new("UICorner")
FPSBoostCorner.CornerRadius = UDim.new(0, 6)
FPSBoostCorner.Parent = FPSBoostRow

local FPSBoostLabel = Instance.new("TextLabel")
FPSBoostLabel.Size = UDim2.new(1, -100, 1, 0)
FPSBoostLabel.Position = UDim2.new(0, 14, 0, 0)
FPSBoostLabel.BackgroundTransparency = 1
FPSBoostLabel.Text = "Anti Lag / FPS Boost 🚀"
FPSBoostLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
FPSBoostLabel.TextSize = 16
FPSBoostLabel.Font = Enum.Font.Gotham
FPSBoostLabel.TextXAlignment = Enum.TextXAlignment.Left
FPSBoostLabel.Parent = FPSBoostRow

local FPSBoostToggle = Instance.new("TextButton")
FPSBoostToggle.Size = UDim2.new(0, 70, 0, 30)
FPSBoostToggle.Position = UDim2.new(1, -84, 0.5, -15)
FPSBoostToggle.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
FPSBoostToggle.BorderSizePixel = 0
FPSBoostToggle.Text = "OFF"
FPSBoostToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
FPSBoostToggle.TextSize = 15
FPSBoostToggle.Font = Enum.Font.GothamBold
FPSBoostToggle.AutoButtonColor = false
FPSBoostToggle.Parent = FPSBoostRow

local FPSBoostToggleCorner = Instance.new("UICorner")
FPSBoostToggleCorner.CornerRadius = UDim.new(0, 6)
FPSBoostToggleCorner.Parent = FPSBoostToggle

local originalParts = {}

local function enableFPSBoost()
    pcall(function()
        for _, obj in ipairs(workspace:GetDescendants()) do
            pcall(function()
                if obj:IsA("BasePart") then
                    if not originalParts[obj] then
                        originalParts[obj] = {
                            Material = obj.Material,
                            Reflectance = obj.Reflectance,
                            Transparency = obj.Transparency,
                            CastShadow = obj.CastShadow,
                        }
                    end
                    obj.Material = Enum.Material.SmoothPlastic
                    obj.Reflectance = 0
                    obj.Transparency = 0.5
                    obj.CastShadow = false
                elseif obj:IsA("Decal") then
                    obj.Transparency = 1
                elseif obj:IsA("Texture") then
                    obj.Transparency = 1
                elseif obj:IsA("ParticleEmitter") then
                    obj.Enabled = false
                elseif obj:IsA("Trail") then
                    obj.Enabled = false
                elseif obj:IsA("Smoke") then
                    obj.Enabled = false
                elseif obj:IsA("Fire") then
                    obj.Enabled = false
                elseif obj:IsA("Sparkles") then
                    obj.Enabled = false
                end
            end)
        end

        if currentCharacter then
            local animator = currentCharacter:FindFirstChildOfClass("Animator")
            if animator then
                pcall(function() animator:Destroy() end)
            end
        end
    end)
end

local function disableFPSBoost()
    pcall(function()
        for obj, data in pairs(originalParts) do
            if obj and obj.Parent then
                pcall(function()
                    obj.Material = data.Material
                    obj.Reflectance = data.Reflectance
                    obj.Transparency = data.Transparency
                    obj.CastShadow = data.CastShadow
                end)
            end
        end
        originalParts = {}

        for _, obj in ipairs(workspace:GetDescendants()) do
            pcall(function()
                if obj:IsA("Decal") then
                    obj.Transparency = 0
                elseif obj:IsA("Texture") then
                    obj.Transparency = 0
                elseif obj:IsA("ParticleEmitter") then
                    obj.Enabled = true
                elseif obj:IsA("Trail") then
                    obj.Enabled = true
                elseif obj:IsA("Smoke") then
                    obj.Enabled = true
                elseif obj:IsA("Fire") then
                    obj.Enabled = true
                elseif obj:IsA("Sparkles") then
                    obj.Enabled = true
                end
            end)
        end
    end)
end

FPSBoostToggle.MouseButton1Click:Connect(function()
    FPSBoostEnabled = not FPSBoostEnabled
    if FPSBoostEnabled then
        FPSBoostToggle.Text = "ON"
        FPSBoostToggle.BackgroundColor3 = Color3.fromRGB(0, 200, 100)
        enableFPSBoost()
        notify("FPS Boost ON")
    else
        FPSBoostToggle.Text = "OFF"
        FPSBoostToggle.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
        disableFPSBoost()
        notify("FPS Boost OFF")
    end
end)

local ConfirmFrame = Instance.new("Frame")
ConfirmFrame.Name = "ConfirmFrame"
ConfirmFrame.Size = UDim2.new(0, 260, 0, 130)
ConfirmFrame.Position = UDim2.new(0.5, -130, 0.5, -65)
ConfirmFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 28)
ConfirmFrame.BorderSizePixel = 0
ConfirmFrame.Visible = false
ConfirmFrame.Active = true
ConfirmFrame.ZIndex = 10
ConfirmFrame.Parent = ScreenGui

local ConfirmCorner = Instance.new("UICorner")
ConfirmCorner.CornerRadius = UDim.new(0, 10)
ConfirmCorner.Parent = ConfirmFrame

local ConfirmStroke = Instance.new("UIStroke")
ConfirmStroke.Color = Color3.fromRGB(0, 120, 255)
ConfirmStroke.Thickness = 1.5
ConfirmStroke.Parent = ConfirmFrame

local ConfirmLabel = Instance.new("TextLabel")
ConfirmLabel.Size = UDim2.new(1, -20, 0, 40)
ConfirmLabel.Position = UDim2.new(0, 10, 0, 15)
ConfirmLabel.BackgroundTransparency = 1
ConfirmLabel.Text = "Out of script?"
ConfirmLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
ConfirmLabel.TextScaled = true
ConfirmLabel.Font = Enum.Font.GothamBold
ConfirmLabel.ZIndex = 11
ConfirmLabel.Parent = ConfirmFrame

local YesBtn = Instance.new("TextButton")
YesBtn.Name = "YesBtn"
YesBtn.Size = UDim2.new(0, 100, 0, 38)
YesBtn.Position = UDim2.new(0, 20, 1, -55)
YesBtn.BackgroundColor3 = Color3.fromRGB(0, 200, 100)
YesBtn.BorderSizePixel = 0
YesBtn.Text = "Yes"
YesBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
YesBtn.TextScaled = true
YesBtn.Font = Enum.Font.GothamBold
YesBtn.AutoButtonColor = false
YesBtn.ZIndex = 11
YesBtn.Parent = ConfirmFrame

local YesCorner = Instance.new("UICorner")
YesCorner.CornerRadius = UDim.new(0, 6)
YesCorner.Parent = YesBtn

local NoBtn = Instance.new("TextButton")
NoBtn.Name = "NoBtn"
NoBtn.Size = UDim2.new(0, 100, 0, 38)
NoBtn.Position = UDim2.new(1, -120, 1, -55)
NoBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
NoBtn.BorderSizePixel = 0
NoBtn.Text = "No"
NoBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
NoBtn.TextScaled = true
NoBtn.Font = Enum.Font.GothamBold
NoBtn.AutoButtonColor = false
NoBtn.ZIndex = 11
NoBtn.Parent = ConfirmFrame

local NoCorner = Instance.new("UICorner")
NoCorner.CornerRadius = UDim.new(0, 6)
NoCorner.Parent = NoBtn

ToggleBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
end)

CloseBtn.MouseEnter:Connect(function()
    CloseBtn.BackgroundColor3 = Color3.fromRGB(255, 100, 100)
end)

CloseBtn.MouseLeave:Connect(function()
    CloseBtn.BackgroundColor3 = Color3.fromRGB(255, 60, 60)
end)

CloseBtn.MouseButton1Click:Connect(function()
    ConfirmFrame.Visible = true
end)

YesBtn.MouseButton1Click:Connect(function()
    if FPSBoostEnabled then
        disableFPSBoost()
    end
    ScreenGui:Destroy()
end)

NoBtn.MouseButton1Click:Connect(function()
    ConfirmFrame.Visible = false
end)

local dragging, dragInput, dragStart, startPos

TitleBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
    or input.UserInputType == Enum.UserInputType.Touch then
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

TitleBar.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement
    or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        local delta = input.Position - dragStart
        MainFrame.Position = UDim2.new(
            startPos.X.Scale, startPos.X.Offset + delta.X,
            startPos.Y.Scale, startPos.Y.Offset + delta.Y
        )
    end
end)