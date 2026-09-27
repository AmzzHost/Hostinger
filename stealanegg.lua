local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer

local IMAGE_URL = "https://cdn.jsdelivr.net/gh/AmzzHost/Hostinger@main/file_0000000064ac820baf633ea366e9a8ae.png"

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "AmzzHub"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

local ToggleBtn = Instance.new("TextButton")
ToggleBtn.Name = "ToggleBtn"
ToggleBtn.Size = UDim2.new(0, 70, 0, 70)
ToggleBtn.Position = UDim2.new(0, 30, 0, 150)
ToggleBtn.BackgroundColor3 = Color3.fromRGB(200, 40, 40)
ToggleBtn.BorderSizePixel = 0
ToggleBtn.Text = ""
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

local ToggleImage = Instance.new("ImageLabel")
ToggleImage.Name = "ToggleImage"
ToggleImage.Size = UDim2.new(1, 0, 1, 0)
ToggleImage.BackgroundTransparency = 1
ToggleImage.Image = IMAGE_URL
ToggleImage.ScaleType = Enum.ScaleType.Fit
ToggleImage.ZIndex = 2
ToggleImage.Parent = ToggleBtn

local ToggleImageCorner = Instance.new("UICorner")
ToggleImageCorner.CornerRadius = UDim.new(1, 0)
ToggleImageCorner.Parent = ToggleImage

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 380, 0, 280)
MainFrame.Position = UDim2.new(0.5, -190, 0.5, -140)
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

local TitleImage = Instance.new("ImageLabel")
TitleImage.Name = "TitleImage"
TitleImage.Size = UDim2.new(0, 26, 0, 26)
TitleImage.Position = UDim2.new(0, 8, 0.5, -13)
TitleImage.BackgroundTransparency = 1
TitleImage.Image = IMAGE_URL
TitleImage.ScaleType = Enum.ScaleType.Fit
TitleImage.ZIndex = 2
TitleImage.Parent = TitleBar

local TitleImageCorner = Instance.new("UICorner")
TitleImageCorner.CornerRadius = UDim.new(1, 0)
TitleImageCorner.Parent = TitleImage

local TitleLabel = Instance.new("TextLabel")
TitleLabel.Size = UDim2.new(1, -90, 1, 0)
TitleLabel.Position = UDim2.new(0, 42, 0, 0)
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

CloseBtn.MouseEnter:Connect(function()
    CloseBtn.BackgroundColor3 = Color3.fromRGB(255, 100, 100)
end)

CloseBtn.MouseLeave:Connect(function()
    CloseBtn.BackgroundColor3 = Color3.fromRGB(255, 60, 60)
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

CloseBtn.MouseButton1Click:Connect(function()
    ConfirmFrame.Visible = true
end)

YesBtn.MouseButton1Click:Connect(function()
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
