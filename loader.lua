-- ═══════════════════════════════════════════════════════════════
--  KREIN LOADER — Modern RGB Loader UI
--  loadstring(game:HttpGet("https://raw.githubusercontent.com/liptz341/KreinGuiLibrary/refs/heads/main/loader.lua"))()
-- ═══════════════════════════════════════════════════════════════
if _G.__KreinLoaded then return end
_G.__KreinLoaded = true

repeat task.wait() until game:IsLoaded()

local UIS = game:GetService("UserInputService")
local TS  = game:GetService("TweenService")

-- ── KONFIG ──────────────────────────────────────────────────────
local BASE = "https://raw.githubusercontent.com/liptz341/KreinGuiLibrary/refs/heads/main/"
local GAMES = {
    [123974602339071] = { Name = "Steal a Brainrot", Path = "Games/StealABrainrot.lua" },

}
local entry = GAMES[game.PlaceId]
local supported = entry ~= nil

-- ── BUILD SCREEN GUI ────────────────────────────────────────────
local parent = (gethui and gethui()) or game:GetService("CoreGui")
local oldLoader = parent:FindFirstChild("KreinLoader")
if oldLoader then oldLoader:Destroy() end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "KreinLoader"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.DisplayOrder = 999
ScreenGui.Parent = parent

-- Backdrop
local Backdrop = Instance.new("Frame")
Backdrop.Size = UDim2.new(1, 0, 1, 0)
Backdrop.BackgroundColor3 = Color3.new(0, 0, 0)
Backdrop.BackgroundTransparency = 1
Backdrop.BorderSizePixel = 0
Backdrop.ZIndex = 1
Backdrop.Parent = ScreenGui

-- Card (auto-size Y, centered)
local Card = Instance.new("Frame")
Card.Size = UDim2.new(0, 320, 0, 0)
Card.AutomaticSize = Enum.AutomaticSize.Y
Card.AnchorPoint = Vector2.new(0.5, 0.5)
Card.Position = UDim2.new(0.5, 0, 0.5, 0)
Card.BackgroundColor3 = Color3.fromRGB(6, 6, 10)
Card.BackgroundTransparency = 1
Card.BorderSizePixel = 0
Card.ZIndex = 2
Card.Parent = ScreenGui

-- Auto-resize untuk mobile
if UIS.TouchEnabled and not UIS.KeyboardEnabled then
    local vp = workspace.CurrentCamera.ViewportSize
    if vp.X < 380 then
        Card.Size = UDim2.new(0, vp.X - 32, 0, 0)
    end
end

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 16)
UICorner.Parent = Card

-- RGB Border (2 layer: outer tipis + glow)
local StrokeOuter = Instance.new("UIStroke")
StrokeOuter.Thickness = 1.5
StrokeOuter.Color = Color3.fromRGB(255, 0, 128)
StrokeOuter.LineJoinMode = Enum.LineJoinMode.Round
StrokeOuter.Parent = Card

local StrokeGlow = Instance.new("UIStroke")
StrokeGlow.Thickness = 6
StrokeGlow.Color = Color3.fromRGB(255, 0, 128)
StrokeGlow.Transparency = 0.82
StrokeGlow.LineJoinMode = Enum.LineJoinMode.Round
StrokeGlow.Parent = Card

-- Padding & Layout
local Pad = Instance.new("UIPadding")
Pad.PaddingTop    = UDim.new(0, 26)
Pad.PaddingBottom = UDim.new(0, 26)
Pad.PaddingLeft   = UDim.new(0, 26)
Pad.PaddingRight  = UDim.new(0, 26)
Pad.Parent = Card

local Layout = Instance.new("UIListLayout")
Layout.Padding = UDim.new(0, 12)
Layout.SortOrder = Enum.SortOrder.LayoutOrder
Layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
Layout.Parent = Card

-- Title "KreinLoad" (RGB gradient)
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 44)
Title.BackgroundTransparency = 1
Title.Text = "KreinLoad"
Title.Font = Enum.Font.GothamBold
Title.TextSize = 32
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextTransparency = 1
Title.LayoutOrder = 1
Title.ZIndex = 3
Title.Parent = Card

local TitleGrad = Instance.new("UIGradient")
TitleGrad.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 90, 90)),
    ColorSequenceKeypoint.new(0.25, Color3.fromRGB(255, 230, 90)),
    ColorSequenceKeypoint.new(0.50, Color3.fromRGB(90, 255, 120)),
    ColorSequenceKeypoint.new(0.75, Color3.fromRGB(90, 190, 255)),
    ColorSequenceKeypoint.new(1.00, Color3.fromRGB(255, 90, 230)),
})
TitleGrad.Parent = Title

-- Subtitle
local Subtitle = Instance.new("TextLabel")
Subtitle.Size = UDim2.new(1, 0, 0, 16)
Subtitle.BackgroundTransparency = 1
Subtitle.Font = Enum.Font.Gotham
Subtitle.TextSize = 12
Subtitle.TextTransparency = 1
Subtitle.LayoutOrder = 2
Subtitle.ZIndex = 3
Subtitle.Parent = Card

if supported then
    Subtitle.Text = "Detected: " .. entry.Name
    Subtitle.TextColor3 = Color3.fromRGB(140, 140, 160)
else
    Subtitle.Text = "⚠ Game Not Supported  •  PlaceId: " .. tostring(game.PlaceId)
    Subtitle.TextColor3 = Color3.fromRGB(255, 110, 110)
end

-- Status (hidden default)
local Status = Instance.new("TextLabel")
Status.Size = UDim2.new(1, 0, 0, 14)
Status.BackgroundTransparency = 1
Status.Text = ""
Status.TextColor3 = Color3.fromRGB(110, 110, 130)
Status.Font = Enum.Font.Gotham
Status.TextSize = 11
Status.TextTransparency = 1
Status.LayoutOrder = 3
Status.Visible = false
Status.ZIndex = 3
Status.Parent = Card

-- Button
local Btn = Instance.new("TextButton")
Btn.Size = UDim2.new(1, 0, 0, 46)
Btn.BackgroundColor3 = Color3.fromRGB(18, 18, 28)
Btn.BackgroundTransparency = 1
Btn.BorderSizePixel = 0
Btn.Text = supported and "Load Now!" or "Open Library Anyway"
Btn.TextColor3 = Color3.fromRGB(255, 255, 255)
Btn.Font = Enum.Font.GothamBold
Btn.TextSize = 15
Btn.TextTransparency = 1
Btn.AutoButtonColor = false
Btn.LayoutOrder = 4
Btn.ZIndex = 3
Btn.Parent = Card

local UICornerBtn = Instance.new("UICorner")
UICornerBtn.CornerRadius = UDim.new(0, 10)
UICornerBtn.Parent = Btn

local StrokeBtn = Instance.new("UIStroke")
StrokeBtn.Thickness = 1.5
StrokeBtn.Color = Color3.fromRGB(255, 0, 128)
StrokeBtn.Parent = Btn

-- UIScale untuk pop-in animation
local CardScale = Instance.new("UIScale")
CardScale.Scale = 0.85
CardScale.Parent = Card

-- ═══════════════════════════════════════════════════════════════
--  ANIMASI: FADE IN + RGB LOOP
-- ═══════════════════════════════════════════════════════════════
local rgbRunning = true
local hue, gradOffset, pulse = 0, 0, 0

task.spawn(function()
    while rgbRunning and Card.Parent do
        hue = (hue + 0.008) % 1
        gradOffset = (gradOffset + 0.004) % 1
        pulse = (pulse + 0.05) % (math.pi * 2)
        local c = Color3.fromHSV(hue, 0.85, 1)
        StrokeOuter.Color = c
        StrokeGlow.Color = c
        StrokeBtn.Color = c
        StrokeGlow.Transparency = 0.72 + (math.sin(pulse) * 0.5 + 0.5) * 0.18
        TitleGrad.Offset = Vector2.new(gradOffset, 0)
        task.wait(0.03)
    end
end)

-- Fade in sequence
TS:Create(Backdrop, TweenInfo.new(0.4), {BackgroundTransparency = 0.55}):Play()
TS:Create(Card, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {BackgroundTransparency = 0.02}):Play()
TS:Create(CardScale, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Scale = 1}):Play()

task.delay(0.25, function()
    for _, el in ipairs({Title, Subtitle, Status, Btn}) do
        if el and el.Parent then
            TS:Create(el, TweenInfo.new(0.35), {TextTransparency = 0}):Play()
        end
    end
end)

-- Hover button
Btn.MouseEnter:Connect(function()
    if Btn.Text == "Loading..." then return end
    TS:Create(Btn, TweenInfo.new(0.15), {BackgroundColor3 = Color3.fromRGB(26, 26, 40)}):Play()
end)
Btn.MouseLeave:Connect(function()
    if Btn.Text == "Loading..." then return end
    TS:Create(Btn, TweenInfo.new(0.15), {BackgroundColor3 = Color3.fromRGB(18, 18, 28)}):Play()
end)

-- ═══════════════════════════════════════════════════════════════
--  CLICK HANDLER
-- ═══════════════════════════════════════════════════════════════
local loading = false

local function fadeOutLoader()
    rgbRunning = false
    TS:Create(Backdrop, TweenInfo.new(0.35), {BackgroundTransparency = 1}):Play()
    TS:Create(Card, TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {BackgroundTransparency = 1}):Play()
    TS:Create(CardScale, TweenInfo.new(0.35), {Scale = 0.9}):Play()
    for _, el in ipairs({Title, Subtitle, Status, Btn}) do
        if el and el.Parent then
            TS:Create(el, TweenInfo.new(0.3), {TextTransparency = 1}):Play()
        end
    end
    task.delay(0.4, function()
        if ScreenGui and ScreenGui.Parent then ScreenGui:Destroy() end
    end)
end

local function setStatus(text, color)
    Status.Visible = true
    Status.Text = text
    Status.TextColor3 = color or Color3.fromRGB(140, 140, 160)
    TS:Create(Status, TweenInfo.new(0.25), {TextTransparency = 0}):Play()
end

Btn.MouseButton1Click:Connect(function()
    if loading then return end
    loading = true
    Btn.Text = "Loading..."
    TS:Create(Btn, TweenInfo.new(0.15), {BackgroundColor3 = Color3.fromRGB(30, 22, 45)}):Play()

    task.spawn(function()
        setStatus("Memuat library Krein...")

        -- 1. Load library
        local ok, KreinHub = pcall(function()
            local src = game:HttpGet(BASE .. "guilibrary.lua")
            local fn = loadstring(src)
            if not fn then error("Syntax error") end
            return fn()
        end)

        if not ok or type(KreinHub) ~= "table" or not KreinHub.CreateWindow then
            Btn.Text = "Load Failed"
            TS:Create(Btn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(70, 22, 22)}):Play()
            setStatus("Gagal load library: " .. tostring(KreinHub), Color3.fromRGB(255, 100, 100))
            loading = false
            return
        end

        setStatus("Membuat window...")
        task.wait(0.2)

        -- 2. Create Window
        local Window = KreinHub:CreateWindow({
            Title    = "Krein Hub",
            Subtitle = supported and entry.Name or "Universal",
            Size     = UDim2.new(0, 680, 0, 460),
        })

        -- 3. Ekspos ke global untuk game script
        if getgenv then
            getgenv().KreinWindow  = Window
            getgenv().KreinLibrary = KreinHub
        else
            _G.KreinWindow  = Window
            _G.KreinLibrary = KreinHub
        end

        -- 4. Load game script (jika didukung)
        if supported then
            setStatus("Memuat fitur game...")
            task.wait(0.15)

            local ok2, err = pcall(function()
                local src = game:HttpGet(BASE .. entry.Path)
                local fn = loadstring(src)
                if not fn then error("Syntax error di " .. entry.Path) end
                fn()
            end)

            if not ok2 then
                warn("[Krein] Game script error: " .. tostring(err))
            end
        end

        -- 5. Fade out loader → library intro main
        setStatus("Siap! Membuka UI...", Color3.fromRGB(120, 220, 140))
        task.wait(0.3)
        fadeOutLoader()

        task.delay(0.6, function()
            KreinHub:Notify("Krein Hub",
                supported and "Berhasil dimuat!" or "Library terbuka (tanpa fitur game)",
                3, "success")
        end)
    end)
end)
