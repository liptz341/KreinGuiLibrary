local UIS        = game:GetService("UserInputService")
local TS         = game:GetService("TweenService")
local Players    = game:GetService("Players")
local CoreGui    = game:GetService("CoreGui")
local RunService = game:GetService("RunService")

local isMobile = UIS.TouchEnabled and not UIS.KeyboardEnabled

local KreinHub  = {}
KreinHub.__index = KreinHub

local F = {
    Title  = Enum.Font.FredokaOne,
    Header = Enum.Font.FredokaOne,
    Label  = Enum.Font.Gotham,
    Body   = Enum.Font.Gotham,
    Bold   = Enum.Font.GothamBold,
    Medium = Enum.Font.GothamMedium,
    Semi   = Enum.Font.GothamSemibold,
}

local function tw(obj, props, dur, style, dir)
    TS:Create(obj,
        TweenInfo.new(dur or 0.5, style or Enum.EasingStyle.Quint, dir or Enum.EasingDirection.Out),
        props
    ):Play()
end

local function corner(parent, radius)
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, radius or 8)
    c.Parent = parent
    return c
end

local function stroke(parent, color, thickness, transparency)
    local s = Instance.new("UIStroke")
    s.Color = color or Color3.fromRGB(50, 50, 60)
    s.Thickness = thickness or 1
    s.Transparency = transparency or 0.7
    s.Parent = parent
    return s
end

local function listLayout(parent, fillDir, spacing, sortOrder)
    local l = Instance.new("UIListLayout")
    l.FillDirection  = fillDir or Enum.FillDirection.Vertical
    l.Padding        = UDim.new(0, spacing or 5)
    l.SortOrder      = sortOrder or Enum.SortOrder.LayoutOrder
    l.HorizontalAlignment = Enum.HorizontalAlignment.Center
    l.Parent = parent
    return l
end

local function uiPadding(parent, top, bottom, left, right)
    local p = Instance.new("UIPadding")
    p.PaddingTop    = UDim.new(0, top    or 6)
    p.PaddingBottom = UDim.new(0, bottom or 6)
    p.PaddingLeft   = UDim.new(0, left   or 10)
    p.PaddingRight  = UDim.new(0, right  or 10)
    p.Parent = parent
    return p
end

local _tipFrame  = nil
local _tipRSConn = nil

local function showTooltip(text, anchor)
    if _tipFrame  then _tipFrame:Destroy() end
    if _tipRSConn then _tipRSConn:Disconnect() end
    if not text or text == "" then return end
    local screen = anchor:FindFirstAncestorOfClass("ScreenGui")
    if not screen then return end
    local tip = Instance.new("Frame")
    tip.Name = "KreinTooltip"
    tip.Size = UDim2.new(0, 185, 0, 28)
    tip.BackgroundColor3 = Color3.fromRGB(18, 18, 24)
    tip.BackgroundTransparency = 0.04
    tip.BorderSizePixel = 0
    tip.ZIndex = 9999
    tip.Parent = screen
    corner(tip, 6)
    stroke(tip, Color3.fromRGB(65, 65, 82), 1, 0.2)
    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(1, -12, 1, 0)
    lbl.Position = UDim2.new(0, 6, 0, 0)
    lbl.BackgroundTransparency = 1
    lbl.Text = text
    lbl.TextColor3 = Color3.fromRGB(210, 210, 225)
    lbl.Font = F.Body
    lbl.TextSize = 11
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.ZIndex = 9999
    lbl.Parent = tip
    _tipRSConn = UIS.InputChanged:Connect(function(input)
        if not tip or not tip.Parent then return end
        if input.UserInputType == Enum.UserInputType.MouseMovement then
            local mp = input.Position
            tip.Position = UDim2.new(0, mp.X + 14, 0, mp.Y - 36)
        end
    end)
    _tipFrame = tip
end

local function hideTooltip()
    if _tipRSConn then _tipRSConn:Disconnect(); _tipRSConn = nil end
    if _tipFrame then
        tw(_tipFrame, {BackgroundTransparency = 1}, 0.1)
        local t = _tipFrame; _tipFrame = nil
        task.delay(0.11, function() if t and t.Parent then t:Destroy() end end)
    end
end

local function destroyOldGUIs()
    local containers = {CoreGui}
    pcall(function()
        local pg = Players.LocalPlayer:FindFirstChild("PlayerGui")
        if pg then table.insert(containers, pg) end
    end)
    for _, container in ipairs(containers) do
        pcall(function()
            local old = container:FindFirstChild("KreinHub")
            if old then old:Destroy() end
        end)
    end
end

destroyOldGUIs()

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "KreinHub"
ScreenGui.Parent = CoreGui
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.DisplayOrder = 10

local NotifContainer = Instance.new("Frame")
NotifContainer.Name  = "NotifContainer"
NotifContainer.Size  = UDim2.new(0, 300, 1, 0)
NotifContainer.Position = UDim2.new(1, -310, 0, 0)
NotifContainer.BackgroundTransparency = 1
NotifContainer.BorderSizePixel = 0
NotifContainer.ZIndex = 9000
NotifContainer.Parent = ScreenGui

local _notifs    = {}
local _lastNotif = 0
local NOTIF_COOL = 0.3

function KreinHub:Notify(title, message, duration, nType)
    local now = tick()
    if now - _lastNotif < NOTIF_COOL then return end
    _lastNotif = now
    duration = duration or 3
    nType    = nType or "info"
    local pal = ({
        info    = {bar = Color3.fromRGB(100, 150, 255), icon = "i"},
        success = {bar = Color3.fromRGB(50,  210, 110), icon = "v"},
        warning = {bar = Color3.fromRGB(255, 189,  46), icon = "!"},
        error   = {bar = Color3.fromRGB(225,  60,  60), icon = "X"},
    })[nType] or {bar = Color3.fromRGB(100, 150, 255), icon = "i"}

    for _, n in ipairs(_notifs) do
        tw(n, {Position = n.Position - UDim2.new(0, 0, 0, 80)}, 0.28)
    end

    local notif = Instance.new("Frame")
    notif.Size = UDim2.new(1, 0, 0, 70)
    notif.Position = UDim2.new(0, 0, 1, 10)
    notif.BackgroundColor3 = Color3.fromRGB(18, 18, 26)
    notif.BackgroundTransparency = 0.06
    notif.BorderSizePixel = 0
    notif.ZIndex = 9001
    notif.ClipsDescendants = true
    notif.Parent = NotifContainer
    corner(notif, 14)
    stroke(notif, Color3.fromRGB(255, 255, 255), 1, 0.88)

    local innerStk = Instance.new("UIStroke")
    innerStk.Color = Color3.fromRGB(55, 55, 75)
    innerStk.Thickness = 1.5
    innerStk.Transparency = 0.45
    innerStk.Parent = notif

    local accent = Instance.new("Frame")
    accent.Size = UDim2.new(0, 3, 0.75, 0)
    accent.Position = UDim2.new(0, 0, 0.125, 0)
    accent.BackgroundColor3 = pal.bar
    accent.BorderSizePixel = 0
    accent.ZIndex = 9002
    accent.Parent = notif
    corner(accent, 3)

    local prog = Instance.new("Frame")
    prog.Size = UDim2.new(1, 0, 0, 2)
    prog.Position = UDim2.new(0, 0, 1, -2)
    prog.BackgroundColor3 = pal.bar
    prog.BackgroundTransparency = 0.4
    prog.BorderSizePixel = 0
    prog.ZIndex = 9002
    prog.Parent = notif
    tw(prog, {Size = UDim2.new(0, 0, 0, 2)}, duration, Enum.EasingStyle.Linear)

    local circle = Instance.new("Frame")
    circle.Size = UDim2.new(0, 30, 0, 30)
    circle.Position = UDim2.new(0, 14, 0, 20)
    circle.BackgroundColor3 = pal.bar
    circle.BackgroundTransparency = 0.78
    circle.BorderSizePixel = 0
    circle.ZIndex = 9002
    circle.Parent = notif
    corner(circle, 15)

    local icoLbl = Instance.new("TextLabel")
    icoLbl.Size = UDim2.new(1, 0, 1, 0)
    icoLbl.BackgroundTransparency = 1
    icoLbl.Text = pal.icon
    icoLbl.TextColor3 = pal.bar
    icoLbl.Font = F.Bold
    icoLbl.TextSize = 13
    icoLbl.ZIndex = 9003
    icoLbl.Parent = circle

    local titleLbl = Instance.new("TextLabel")
    titleLbl.Size = UDim2.new(0, 210, 0, 18)
    titleLbl.Position = UDim2.new(0, 54, 0, 12)
    titleLbl.BackgroundTransparency = 1
    titleLbl.Text = title
    titleLbl.TextColor3 = Color3.fromRGB(245, 245, 255)
    titleLbl.Font = F.Bold
    titleLbl.TextSize = 12
    titleLbl.TextXAlignment = Enum.TextXAlignment.Left
    titleLbl.ZIndex = 9002
    titleLbl.Parent = notif

    local msgLbl = Instance.new("TextLabel")
    msgLbl.Size = UDim2.new(0, 210, 0, 28)
    msgLbl.Position = UDim2.new(0, 54, 0, 30)
    msgLbl.BackgroundTransparency = 1
    msgLbl.Text = message
    msgLbl.TextColor3 = Color3.fromRGB(145, 145, 162)
    msgLbl.Font = F.Body
    msgLbl.TextSize = 10
    msgLbl.TextXAlignment = Enum.TextXAlignment.Left
    msgLbl.TextWrapped = true
    msgLbl.ZIndex = 9002
    msgLbl.Parent = notif

    local closeBtn = Instance.new("TextButton")
    closeBtn.Size = UDim2.new(0, 20, 0, 20)
    closeBtn.Position = UDim2.new(1, -26, 0, 8)
    closeBtn.BackgroundTransparency = 1
    closeBtn.Text = "x"
    closeBtn.TextColor3 = Color3.fromRGB(90, 90, 108)
    closeBtn.Font = F.Bold
    closeBtn.TextSize = 14
    closeBtn.ZIndex = 9003
    closeBtn.Parent = notif

    local function dismiss()
        local idx = table.find(_notifs, notif)
        if idx then table.remove(_notifs, idx) end
        tw(notif, {Position = notif.Position + UDim2.new(0, 310, 0, 0), BackgroundTransparency = 1}, 0.22)
        task.delay(0.23, function()
            if notif and notif.Parent then notif:Destroy() end
        end)
    end

    closeBtn.MouseButton1Click:Connect(dismiss)
    table.insert(_notifs, notif)
    tw(notif, {Position = UDim2.new(0, 0, 1, -84)}, 0.45, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
    task.delay(duration, function()
        if notif and notif.Parent then dismiss() end
    end)
end

function KreinHub:CreateWindow(cfg)
    cfg = cfg or {}
    local winTitle = cfg.Title    or "Krein Hub"
    local winSub   = cfg.Subtitle or "Premium UI Library"
    local winSize  = cfg.Size     or UDim2.new(0, 680, 0, 460)
    local winPos   = cfg.Position or UDim2.new(0.5, -340, 0.5, -230)
    local winMin   = cfg.MinSize  or UDim2.new(0, 280, 0, 45)
    local winMax   = cfg.MaxSize  or UDim2.new(0, 880, 0, 580)

    local _pool = {}
    local function reg(c) table.insert(_pool, c) end
    local function pconn(sig, fn) reg(sig:Connect(fn)) end

    local C = {
        MainBg        = Color3.fromRGB(14, 14, 20),
        TitleBg       = Color3.fromRGB(18, 18, 26),
        SidebarBg     = Color3.fromRGB(15, 15, 22),
        Text          = Color3.fromRGB(232, 232, 245),
        SubText       = Color3.fromRGB(110, 110, 130),
        Stroke        = Color3.fromRGB(255, 255, 255),
        InnerStroke   = Color3.fromRGB(52, 52, 70),
        SectionBg     = Color3.fromRGB(20, 20, 28),
        SectionHdr    = Color3.fromRGB(24, 24, 34),
        ComponentBg   = Color3.fromRGB(21, 21, 30),
        CompStroke    = Color3.fromRGB(38, 38, 54),
        TabActive     = Color3.fromRGB(38, 40, 62),
        TabInactive   = Color3.fromRGB(20, 20, 30),
        TabText       = Color3.fromRGB(128, 128, 148),
        TabTextActive = Color3.fromRGB(255, 255, 255),
        ToggleOff     = Color3.fromRGB(48, 48, 64),
        ToggleOn      = Color3.fromRGB(68, 188, 78),
        SliderBg      = Color3.fromRGB(32, 32, 46),
        SliderFill    = Color3.fromRGB(110, 155, 255),
        DropdownBg    = Color3.fromRGB(17, 17, 24),
        OptionBg      = Color3.fromRGB(22, 22, 32),
        OptionHover   = Color3.fromRGB(42, 42, 60),
        KeybindBg     = Color3.fromRGB(28, 28, 42),
        SearchBg      = Color3.fromRGB(20, 20, 30),
        InputBg       = Color3.fromRGB(26, 26, 36),
        InputStroke   = Color3.fromRGB(44, 44, 62),
        LabelText     = Color3.fromRGB(120, 120, 140),
        BtnGreen      = Color3.fromRGB(38, 130, 65),
        BtnRed        = Color3.fromRGB(180, 45, 45),
        ResetBg       = Color3.fromRGB(18, 18, 26),
        ResetBtnBg    = Color3.fromRGB(14, 14, 20),
        SettingsBg    = Color3.fromRGB(18, 18, 26),
        AccentBlue    = Color3.fromRGB(110, 155, 255),
        AccentGlow    = Color3.fromRGB(80, 120, 220),
        ProgressBg    = Color3.fromRGB(28, 28, 42),
        ProgressFill  = Color3.fromRGB(110, 155, 255),
    }

    local MainFrame = Instance.new("Frame")
    MainFrame.Name  = "KreinMain"
    MainFrame.Size  = UDim2.new(0, 0, 0, 0)
    MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
    MainFrame.BackgroundColor3 = C.MainBg
    MainFrame.BackgroundTransparency = 0.04
    MainFrame.BorderSizePixel = 0
    MainFrame.ClipsDescendants = true
    MainFrame.Parent = ScreenGui
    corner(MainFrame, 16)

    local BgImage = Instance.new("ImageLabel")
    BgImage.Size = UDim2.new(1, 0, 1, 0)
    BgImage.BackgroundTransparency = 1
    BgImage.Image = "rbxassetid://103642217909620"
    BgImage.ImageTransparency = 0.5
    BgImage.ScaleType = Enum.ScaleType.Crop
    BgImage.ZIndex = 0
    BgImage.Parent = MainFrame
    corner(BgImage, 16)

    local MainStroke1 = Instance.new("UIStroke")
    MainStroke1.Name = "MainStroke1"
    MainStroke1.Color = Color3.fromRGB(255, 255, 255)
    MainStroke1.Thickness = 1.5
    MainStroke1.Transparency = 0.6
    MainStroke1.LineJoinMode = Enum.LineJoinMode.Round
    MainStroke1.Parent = MainFrame

    local MainStroke2 = Instance.new("UIStroke")
    MainStroke2.Name = "MainStroke2"
    MainStroke2.Color = Color3.fromRGB(80, 90, 130)
    MainStroke2.Thickness = 3
    MainStroke2.Transparency = 0.72
    MainStroke2.LineJoinMode = Enum.LineJoinMode.Round
    MainStroke2.Parent = MainFrame

    local MainStroke3 = Instance.new("UIStroke")
    MainStroke3.Name = "MainStroke3"
    MainStroke3.Color = Color3.fromRGB(30, 32, 50)
    MainStroke3.Thickness = 6
    MainStroke3.Transparency = 0.78
    MainStroke3.LineJoinMode = Enum.LineJoinMode.Round
    MainStroke3.Parent = MainFrame

    local rainbowRunning = true
    task.spawn(function()
        local hue = 0
        while rainbowRunning and MainFrame and MainFrame.Parent do
            hue = (hue + 0.008) % 1
            MainStroke1.Color = Color3.fromHSV(hue, 0.85, 1)
            task.wait(0.03)
        end
    end)

    local sound = Instance.new("Sound")
    sound.SoundId = "rbxassetid://1626996526"
    sound.Volume = 0.6
    sound.Parent = ScreenGui

    local LogoLabel = Instance.new("TextLabel")
    LogoLabel.Size = UDim2.new(0, 80, 0, 80)
    LogoLabel.Position = UDim2.new(0.5, -40, 0.5, -40)
    LogoLabel.BackgroundTransparency = 1
    LogoLabel.Text = "K"
    LogoLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    LogoLabel.Font = F.Bold
    LogoLabel.TextSize = 65
    LogoLabel.ZIndex = 10000
    LogoLabel.Parent = ScreenGui

    local TypewriterLabel = Instance.new("TextLabel")
    TypewriterLabel.Size = UDim2.new(0, 300, 0, 50)
    TypewriterLabel.Position = UDim2.new(0.5, -150, 0.5, -25)
    TypewriterLabel.BackgroundTransparency = 1
    TypewriterLabel.Text = ""
    TypewriterLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    TypewriterLabel.Font = F.Title
    TypewriterLabel.TextSize = 42
    TypewriterLabel.ZIndex = 10000
    TypewriterLabel.Visible = false
    TypewriterLabel.Parent = ScreenGui

    -- ResetFrame: hidden saat loading, muncul setelah selesai
    local ResetFrame = Instance.new("Frame")
    ResetFrame.Name = "KreinResetFrame"
    ResetFrame.Size = UDim2.new(0, 50, 0, 50)
    ResetFrame.Position = UDim2.new(0, 12, 1, -410)
    ResetFrame.BackgroundColor3 = C.ResetBg
    ResetFrame.BackgroundTransparency = 0.05
    ResetFrame.BorderSizePixel = 0
    ResetFrame.ZIndex = 9999
    ResetFrame.Visible = false
    ResetFrame.Parent = ScreenGui
    corner(ResetFrame, 14)

    local ResetFrameStroke = Instance.new("UIStroke")
    ResetFrameStroke.Color = Color3.fromRGB(255, 100, 150)
    ResetFrameStroke.Thickness = 2
    ResetFrameStroke.Transparency = 0.18
    ResetFrameStroke.LineJoinMode = Enum.LineJoinMode.Round
    ResetFrameStroke.Parent = ResetFrame

    local ResetBtn = Instance.new("TextButton")
    ResetBtn.Name = "KreinReset"
    ResetBtn.Size = UDim2.new(0, 42, 0, 42)
    ResetBtn.AnchorPoint = Vector2.new(0.5, 0.5)
    ResetBtn.Position = UDim2.new(0.5, 0, 0.5, 0)
    ResetBtn.BackgroundColor3 = C.ResetBtnBg
    ResetBtn.BackgroundTransparency = 0.03
    ResetBtn.BorderSizePixel = 0
    ResetBtn.Text = "K"
    ResetBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    ResetBtn.Font = F.Title
    ResetBtn.TextSize = 20
    ResetBtn.AutoButtonColor = false
    ResetBtn.ZIndex = 10000
    ResetBtn.Parent = ResetFrame
    corner(ResetBtn, 10)

    local ResetBtnStroke = Instance.new("UIStroke")
    ResetBtnStroke.Color = Color3.fromRGB(255, 100, 150)
    ResetBtnStroke.Thickness = 2
    ResetBtnStroke.Transparency = 0.18
    ResetBtnStroke.LineJoinMode = Enum.LineJoinMode.Round
    ResetBtnStroke.Parent = ResetBtn

    local _rainbowRunning = true
    task.spawn(function()
        local hue = 0
        while _rainbowRunning and ResetFrame and ResetFrame.Parent do
            hue = (hue + 0.008) % 1
            local c = Color3.fromHSV(hue, 0.85, 1)
            ResetFrameStroke.Color = c
            ResetBtnStroke.Color = c
            task.wait(0.03)
        end
    end)

    local loadDuration = (0.38+0.55+0.32+0.45+0.28) + (0.35+0.18) + (#"KreinHub"*0.10+0.45+0.28)

    task.spawn(function()
        sound:Play()
        tw(LogoLabel, {Rotation = 30},  0.38, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
        task.wait(0.38)
        tw(LogoLabel, {Rotation = -30}, 0.55, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut)
        task.wait(0.55)
        tw(LogoLabel, {Rotation = 18},  0.32, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
        task.wait(0.32)
        tw(LogoLabel, {Rotation = -18}, 0.45, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut)
        task.wait(0.45)
        tw(LogoLabel, {Rotation = 0},   0.28, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
        task.wait(0.28)
        tw(LogoLabel, {TextSize = 0, TextTransparency = 1}, 0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
        task.wait(0.35)
        LogoLabel:Destroy()
        task.wait(0.18)
        TypewriterLabel.Visible = true
        local textToType = "KreinHub"
        for i = 1, #textToType do
            TypewriterLabel.Text = textToType:sub(1, i)
            task.wait(0.10)
        end
        task.wait(0.45)
        tw(TypewriterLabel, {TextTransparency = 1}, 0.28)
        task.delay(0.29, function()
            TypewriterLabel:Destroy()
            if sound then sound:Destroy() end
        end)
    end)

    task.delay(loadDuration, function()
        tw(MainFrame, {Size = winSize, Position = winPos}, 0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
        task.delay(0.5, function()
            ResetFrame.BackgroundTransparency = 1
            ResetBtn.TextTransparency = 1
            ResetFrameStroke.Transparency = 1
            ResetBtnStroke.Transparency = 1
            ResetFrame.Visible = true
            tw(ResetFrame, {BackgroundTransparency = 0.05}, 0.35)
            tw(ResetBtn, {TextTransparency = 0}, 0.35)
            tw(ResetFrameStroke, {Transparency = 0.18}, 0.35)
            tw(ResetBtnStroke, {Transparency = 0.18}, 0.35)
        end)
    end)

    local Titlebar = Instance.new("Frame")
    Titlebar.Size = UDim2.new(1, 0, 0, 48)
    Titlebar.BackgroundColor3 = C.TitleBg
    Titlebar.BackgroundTransparency = 0.02
    Titlebar.BorderSizePixel = 0
    Titlebar.ZIndex = 2
    Titlebar.Parent = MainFrame
    corner(Titlebar, 16)

    local TitleFill = Instance.new("Frame")
    TitleFill.Size = UDim2.new(1, 0, 0, 16)
    TitleFill.Position = UDim2.new(0, 0, 1, -16)
    TitleFill.BackgroundColor3 = C.TitleBg
    TitleFill.BackgroundTransparency = 0.02
    TitleFill.BorderSizePixel = 0
    TitleFill.ZIndex = 2
    TitleFill.Parent = Titlebar

    local TitleSep = Instance.new("Frame")
    TitleSep.Size = UDim2.new(1, 0, 0, 1)
    TitleSep.Position = UDim2.new(0, 0, 1, -1)
    TitleSep.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    TitleSep.BackgroundTransparency = 0.88
    TitleSep.BorderSizePixel = 0
    TitleSep.ZIndex = 3
    TitleSep.Parent = Titlebar

    local TitleGlow = Instance.new("Frame")
    TitleGlow.Size = UDim2.new(0.5, 0, 0, 1)
    TitleGlow.Position = UDim2.new(0.25, 0, 1, -1)
    TitleGlow.BackgroundColor3 = C.AccentBlue
    TitleGlow.BackgroundTransparency = 0.55
    TitleGlow.BorderSizePixel = 0
    TitleGlow.ZIndex = 4
    TitleGlow.Parent = Titlebar
    corner(TitleGlow, 1)

    local TitleInfo = Instance.new("Frame")
    TitleInfo.Size = UDim2.new(1, -160, 0, 44)
    TitleInfo.Position = UDim2.new(0, 80, 0, 2)
    TitleInfo.BackgroundTransparency = 1
    TitleInfo.ZIndex = 3
    TitleInfo.Parent = Titlebar

    local TitleLbl = Instance.new("TextLabel")
    TitleLbl.Size = UDim2.new(1, 0, 0, 24)
    TitleLbl.BackgroundTransparency = 1
    TitleLbl.Text = winTitle
    TitleLbl.TextColor3 = C.Text
    TitleLbl.Font = F.Title
    TitleLbl.TextSize = 16
    TitleLbl.TextXAlignment = Enum.TextXAlignment.Center
    TitleLbl.TextTruncate = Enum.TextTruncate.AtEnd
    TitleLbl.ZIndex = 3
    TitleLbl.Parent = TitleInfo

    local SubLbl = Instance.new("TextLabel")
    SubLbl.Size = UDim2.new(1, 0, 0, 14)
    SubLbl.Position = UDim2.new(0, 0, 0, 25)
    SubLbl.BackgroundTransparency = 1
    SubLbl.Text = winSub
    SubLbl.TextColor3 = C.SubText
    SubLbl.Font = F.Body
    SubLbl.TextSize = 10
    SubLbl.TextXAlignment = Enum.TextXAlignment.Center
    SubLbl.TextTruncate = Enum.TextTruncate.AtEnd
    SubLbl.ZIndex = 3
    SubLbl.Parent = TitleInfo

    local BtnHolder = Instance.new("Frame")
    BtnHolder.Size = UDim2.new(0, 52, 0, 14)
    BtnHolder.Position = UDim2.new(0, 14, 0, 17)
    BtnHolder.BackgroundTransparency = 1
    BtnHolder.ZIndex = 3
    BtnHolder.Parent = Titlebar

    local function makeLight(baseColor, xOff, iconChar, iconColor)
        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(0, 14, 0, 14)
        btn.Position = UDim2.new(0, xOff, 0, 0)
        btn.BackgroundColor3 = baseColor
        btn.BorderSizePixel = 0
        btn.Text = ""
        btn.AutoButtonColor = false
        btn.ZIndex = 4
        btn.Parent = BtnHolder
        corner(btn, 7)
        local ic = Instance.new("TextLabel")
        ic.Size = UDim2.new(1, 0, 1, 0)
        ic.BackgroundTransparency = 1
        ic.Text = iconChar
        ic.TextColor3 = iconColor
        ic.Font = F.Bold
        ic.TextSize = 9
        ic.Visible = false
        ic.ZIndex = 5
        ic.Parent = btn
        local hov = Color3.new(
            math.min(baseColor.R + 0.1, 1),
            math.min(baseColor.G + 0.1, 1),
            math.min(baseColor.B + 0.1, 1)
        )
        btn.MouseEnter:Connect(function() tw(btn, {BackgroundColor3 = hov}, 0.12); ic.Visible = true end)
        btn.MouseLeave:Connect(function() tw(btn, {BackgroundColor3 = baseColor}, 0.12); ic.Visible = false end)
        return btn
    end

    local CloseBtn = makeLight(Color3.fromRGB(255, 95,  86),  0,  "X", Color3.fromRGB(130, 18, 18))
    local MinBtn   = makeLight(Color3.fromRGB(255, 189, 46),  20, "-", Color3.fromRGB(130, 90, 18))
    local MaxBtn   = makeLight(Color3.fromRGB(39,  201, 63),  40, "+", Color3.fromRGB(18,  105, 18))

    local Body = Instance.new("Frame")
    Body.Size = UDim2.new(1, 0, 1, -48)
    Body.Position = UDim2.new(0, 0, 0, 48)
    Body.BackgroundTransparency = 1
    Body.BorderSizePixel = 0
    Body.ClipsDescendants = true
    Body.Parent = MainFrame

    local Sidebar = Instance.new("Frame")
    Sidebar.Size = UDim2.new(0, 176, 1, 0)
    Sidebar.BackgroundColor3 = C.SidebarBg
    Sidebar.BackgroundTransparency = 0.01
    Sidebar.BorderSizePixel = 0
    Sidebar.Parent = Body
    corner(Sidebar, 16)

    local SideSep = Instance.new("Frame")
    SideSep.Size = UDim2.new(0, 1, 1, -24)
    SideSep.Position = UDim2.new(1, 0, 0, 12)
    SideSep.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    SideSep.BackgroundTransparency = 0.88
    SideSep.BorderSizePixel = 0
    SideSep.Parent = Sidebar

    local SideSepGlow = Instance.new("Frame")
    SideSepGlow.Size = UDim2.new(0, 1, 0.4, 0)
    SideSepGlow.Position = UDim2.new(1, 0, 0.3, 0)
    SideSepGlow.BackgroundColor3 = C.AccentBlue
    SideSepGlow.BackgroundTransparency = 0.6
    SideSepGlow.BorderSizePixel = 0
    SideSepGlow.Parent = Sidebar

    local SearchHolder = Instance.new("Frame")
    SearchHolder.Size = UDim2.new(1, -16, 0, 32)
    SearchHolder.Position = UDim2.new(0, 8, 0, 8)
    SearchHolder.BackgroundColor3 = C.SearchBg
    SearchHolder.BackgroundTransparency = 0.02
    SearchHolder.BorderSizePixel = 0
    SearchHolder.ZIndex = 3
    SearchHolder.Parent = Sidebar
    corner(SearchHolder, 10)
    stroke(SearchHolder, Color3.fromRGB(255, 255, 255), 1, 0.9)

    local SearchInner = Instance.new("UIStroke")
    SearchInner.Color = Color3.fromRGB(50, 52, 72)
    SearchInner.Thickness = 1.5
    SearchInner.Transparency = 0.5
    SearchInner.Parent = SearchHolder

    local SearchIcon = Instance.new("TextLabel")
    SearchIcon.Size = UDim2.new(0, 18, 1, 0)
    SearchIcon.Position = UDim2.new(0, 7, 0, 0)
    SearchIcon.BackgroundTransparency = 1
    SearchIcon.Text = "S"
    SearchIcon.TextSize = 10
    SearchIcon.ZIndex = 4
    SearchIcon.Parent = SearchHolder

    local SearchBox = Instance.new("TextBox")
    SearchBox.Size = UDim2.new(1, -28, 1, 0)
    SearchBox.Position = UDim2.new(0, 24, 0, 0)
    SearchBox.BackgroundTransparency = 1
    SearchBox.BorderSizePixel = 0
    SearchBox.Text = ""
    SearchBox.PlaceholderText = "Search tabs..."
    SearchBox.PlaceholderColor3 = Color3.fromRGB(72, 72, 92)
    SearchBox.TextColor3 = Color3.fromRGB(215, 215, 230)
    SearchBox.Font = F.Body
    SearchBox.TextSize = 11
    SearchBox.ClearTextOnFocus = false
    SearchBox.ZIndex = 4
    SearchBox.Parent = SearchHolder

    local SearchSep = Instance.new("Frame")
    SearchSep.Size = UDim2.new(1, -16, 0, 1)
    SearchSep.Position = UDim2.new(0, 8, 0, 46)
    SearchSep.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    SearchSep.BackgroundTransparency = 0.88
    SearchSep.BorderSizePixel = 0
    SearchSep.Parent = Sidebar

    local TabScroll = Instance.new("ScrollingFrame")
    TabScroll.Size = UDim2.new(1, -2, 1, -54)
    TabScroll.Position = UDim2.new(0, 0, 0, 54)
    TabScroll.BackgroundTransparency = 1
    TabScroll.BorderSizePixel = 0
    TabScroll.ScrollBarThickness = 2
    TabScroll.ScrollBarImageColor3 = Color3.fromRGB(60, 62, 82)
    TabScroll.ScrollingDirection = Enum.ScrollingDirection.Y
    TabScroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
    TabScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
    TabScroll.Selectable = false
    TabScroll.Parent = Sidebar

    local TabLL = listLayout(TabScroll, Enum.FillDirection.Vertical, 4)
    TabLL.HorizontalAlignment = Enum.HorizontalAlignment.Center
    uiPadding(TabScroll, 4, 44, 0, 0)

    local SettingsSmallBtn = Instance.new("TextButton")
    SettingsSmallBtn.Size = UDim2.new(0, 18, 0, 18)
    SettingsSmallBtn.Position = UDim2.new(0, 6, 1, -26)
    SettingsSmallBtn.BackgroundColor3 = Color3.fromRGB(24, 24, 34)
    SettingsSmallBtn.BackgroundTransparency = 0.04
    SettingsSmallBtn.BorderSizePixel = 0
    SettingsSmallBtn.Text = "S"
    SettingsSmallBtn.TextColor3 = C.TabText
    SettingsSmallBtn.Font = F.Medium
    SettingsSmallBtn.TextSize = 9
    SettingsSmallBtn.AutoButtonColor = false
    SettingsSmallBtn.ZIndex = 3
    SettingsSmallBtn.Parent = Sidebar
    corner(SettingsSmallBtn, 5)

    SettingsSmallBtn.MouseEnter:Connect(function()
        tw(SettingsSmallBtn, {BackgroundColor3 = Color3.fromRGB(44, 44, 62)}, 0.12)
    end)
    SettingsSmallBtn.MouseLeave:Connect(function()
        tw(SettingsSmallBtn, {BackgroundColor3 = C.TabInactive}, 0.12)
    end)

    local SidebarInfo = Instance.new("TextLabel")
    SidebarInfo.Size = UDim2.new(1, -30, 0, 18)
    SidebarInfo.Position = UDim2.new(0, 28, 1, -26)
    SidebarInfo.BackgroundTransparency = 1
    SidebarInfo.Text = "M = Minimize"
    SidebarInfo.TextColor3 = Color3.fromRGB(88, 88, 108)
    SidebarInfo.Font = F.Body
    SidebarInfo.TextSize = 9
    SidebarInfo.TextXAlignment = Enum.TextXAlignment.Left
    SidebarInfo.ZIndex = 2
    SidebarInfo.Parent = Sidebar

    local ContentArea = Instance.new("Frame")
    ContentArea.Size = UDim2.new(1, -194, 1, -12)
    ContentArea.Position = UDim2.new(0, 188, 0, 6)
    ContentArea.BackgroundTransparency = 1
    ContentArea.BorderSizePixel = 0
    ContentArea.ClipsDescendants = true
    ContentArea.Parent = Body

    local PagesHolder = Instance.new("Frame")
    PagesHolder.Size = UDim2.new(1, 0, 1, 0)
    PagesHolder.BackgroundTransparency = 1
    PagesHolder.Parent = ContentArea

    local _tabs      = {}
    local _curTab    = nil
    local _switching = false
    local _tabIdx    = 0
    local _minimized = false
    local _maximized = false

    SearchBox:GetPropertyChangedSignal("Text"):Connect(function()
        local q = SearchBox.Text:lower()
        for name, data in pairs(_tabs) do
            data.btn.Visible = (q == "") or (name:lower():find(q, 1, true) ~= nil)
        end
    end)

    local function switchTab(name)
        if _switching or _curTab == name then return end
        _switching = true
        for n, data in pairs(_tabs) do
            local a = (n == name)
            tw(data.btn, {BackgroundColor3 = a and C.TabActive or C.TabInactive}, 0.22)
            tw(data.btn, {TextColor3 = a and C.TabTextActive or C.TabText}, 0.22)
            local ind = data.btn:FindFirstChild("Indicator")
            if ind then tw(ind, {BackgroundTransparency = a and 0 or 1}, 0.22) end
        end
        local nd = _tabs[name]
        local od = _tabs[_curTab]
        if nd and od then
            nd.frame.Visible = true
            local right = nd.index > od.index
            nd.frame.Position = UDim2.new(right and 1 or -1, 0, 0, 0)
            tw(od.frame, {Position = UDim2.new(right and -1 or 1, 0, 0, 0)}, 0.3)
            tw(nd.frame,  {Position = UDim2.new(0, 0, 0, 0)}, 0.3)
            task.delay(0.3, function()
                if od.frame then od.frame.Visible = false end
            end)
        end
        _curTab = name
        task.delay(0.3, function() _switching = false end)
    end

    local WindowObj = {}
    local savedKeybind = Enum.KeyCode.M

    local SettingsPanel = Instance.new("Frame")
    SettingsPanel.Size = UDim2.new(0, 290, 0, 140)
    SettingsPanel.Position = UDim2.new(0.5, -145, 0.5, -70)
    SettingsPanel.BackgroundColor3 = C.SettingsBg
    SettingsPanel.BackgroundTransparency = 1
    SettingsPanel.BorderSizePixel = 0
    SettingsPanel.Visible = false
    SettingsPanel.ZIndex = 100
    SettingsPanel.Parent = Body
    corner(SettingsPanel, 14)
    stroke(SettingsPanel, Color3.fromRGB(255, 255, 255), 1, 0.84)

    local SettingsClose = Instance.new("TextButton")
    SettingsClose.Size = UDim2.new(0, 22, 0, 22)
    SettingsClose.Position = UDim2.new(1, -28, 0, 8)
    SettingsClose.BackgroundColor3 = Color3.fromRGB(200, 60, 60)
    SettingsClose.BackgroundTransparency = 0.08
    SettingsClose.BorderSizePixel = 0
    SettingsClose.Text = "x"
    SettingsClose.TextColor3 = Color3.fromRGB(255, 255, 255)
    SettingsClose.Font = F.Bold
    SettingsClose.TextSize = 13
    SettingsClose.AutoButtonColor = false
    SettingsClose.ZIndex = 101
    SettingsClose.Parent = SettingsPanel
    corner(SettingsClose, 6)

    local _settingsBindConn = nil

    local function closeSettings()
        if _settingsBindConn then _settingsBindConn:Disconnect(); _settingsBindConn = nil end
        tw(SettingsPanel, {BackgroundTransparency = 1}, 0.18)
        task.delay(0.19, function()
            SettingsPanel.Visible = false
            SettingsPanel.BackgroundTransparency = 0.04
            for _, c in ipairs(SettingsPanel:GetChildren()) do
                if c ~= SettingsClose then c:Destroy() end
            end
        end)
    end
    SettingsClose.MouseButton1Click:Connect(closeSettings)

    local function setLabel(text, x, y, sz, bold, col)
        local lbl = Instance.new("TextLabel")
        lbl.Size = UDim2.new(0, 250, 0, sz or 20)
        lbl.Position = UDim2.new(0, x or 15, 0, y or 0)
        lbl.BackgroundTransparency = 1
        lbl.Text = text
        lbl.TextColor3 = col or Color3.fromRGB(180, 180, 198)
        lbl.Font = bold and F.Header or F.Body
        lbl.TextSize = sz or 12
        lbl.TextXAlignment = Enum.TextXAlignment.Left
        lbl.ZIndex = 101
        lbl.Parent = SettingsPanel
        return lbl
    end

    local function buildSettingsPanel()
        for _, c in ipairs(SettingsPanel:GetChildren()) do
            if c ~= SettingsClose then c:Destroy() end
        end
        setLabel("Settings", 15, 10, 17, true, C.Text)
        setLabel("Minimize Keybind", 15, 42, 12, false, C.SubText)

        local kbBtn = Instance.new("TextButton")
        kbBtn.Size = UDim2.new(0, 84, 0, 30)
        kbBtn.Position = UDim2.new(0, 15, 0, 65)
        kbBtn.BackgroundColor3 = C.KeybindBg
        kbBtn.BackgroundTransparency = 0.03
        kbBtn.BorderSizePixel = 0
        kbBtn.Text = savedKeybind.Name
        kbBtn.TextColor3 = C.TabTextActive
        kbBtn.Font = F.Bold
        kbBtn.TextSize = 11
        kbBtn.AutoButtonColor = false
        kbBtn.ZIndex = 101
        kbBtn.Parent = SettingsPanel
        corner(kbBtn, 8)
        stroke(kbBtn, C.CompStroke, 1, 0.25)

        local isBinding = false
        kbBtn.MouseButton1Click:Connect(function()
            if isBinding then return end
            if _settingsBindConn then _settingsBindConn:Disconnect(); _settingsBindConn = nil end
            isBinding = true
            kbBtn.Text = "..."
            _settingsBindConn = UIS.InputBegan:Connect(function(inp, gp)
                if isBinding and not gp and inp.KeyCode ~= Enum.KeyCode.Unknown then
                    savedKeybind = inp.KeyCode
                    kbBtn.Text = savedKeybind.Name
                    isBinding = false
                    if _settingsBindConn then _settingsBindConn:Disconnect(); _settingsBindConn = nil end
                end
            end)
        end)

        SettingsPanel.BackgroundTransparency = 1
        SettingsPanel.Visible = true
        tw(SettingsPanel, {BackgroundTransparency = 0.04}, 0.22)
    end

    SettingsSmallBtn.MouseButton1Click:Connect(buildSettingsPanel)

    local ResizeHandle = Instance.new("TextButton")
    ResizeHandle.Size = UDim2.new(0, 18, 0, 18)
    ResizeHandle.Position = UDim2.new(1, -18, 1, -18)
    ResizeHandle.BackgroundTransparency = 1
    ResizeHandle.Text = ""
    ResizeHandle.ZIndex = 10
    ResizeHandle.Parent = MainFrame

    local ResizeIcon = Instance.new("TextLabel")
    ResizeIcon.Size = UDim2.new(0, 12, 0, 12)
    ResizeIcon.Position = UDim2.new(0, 3, 0, 3)
    ResizeIcon.BackgroundTransparency = 1
    ResizeIcon.Text = "+"
    ResizeIcon.TextColor3 = C.SubText
    ResizeIcon.Font = F.Body
    ResizeIcon.TextSize = 10
    ResizeIcon.Rotation = 45
    ResizeIcon.ZIndex = 11
    ResizeIcon.Parent = ResizeHandle

    local _resizing = false
    local _rsStart, _rsSize = nil, nil

    ResizeHandle.InputBegan:Connect(function(inp)
        if inp.UserInputType == Enum.UserInputType.MouseButton1 or inp.UserInputType == Enum.UserInputType.Touch then
            if _minimized then return end
            _resizing = true
            _rsStart = inp.Position
            _rsSize = MainFrame.AbsoluteSize
        end
    end)

    pconn(UIS.InputChanged, function(inp)
        if _resizing and (inp.UserInputType == Enum.UserInputType.MouseMovement or inp.UserInputType == Enum.UserInputType.Touch) then
            local delta = inp.Position - _rsStart
            local newW = math.clamp(_rsSize.X + delta.X, 400, 1000)
            local newH = math.clamp(_rsSize.Y + delta.Y, 300, 700)
            MainFrame.Size = UDim2.new(0, newW, 0, newH)
        end
    end)

    pconn(UIS.InputEnded, function(inp)
        if inp.UserInputType == Enum.UserInputType.MouseButton1 or inp.UserInputType == Enum.UserInputType.Touch then
            _resizing = false
        end
    end)

    local function doMinimize()
        _minimized = true
        _maximized = false
        Body.Visible = false
        TitleFill.Visible = false
        TitleSep.Visible = false
        TitleGlow.Visible = false
        ResizeHandle.Visible = false
        MainFrame.ClipsDescendants = true
        tw(MainStroke1, {Thickness = 0}, 0.28)
        tw(MainStroke2, {Thickness = 0}, 0.28)
        tw(MainStroke3, {Thickness = 0}, 0.28)
        tw(MainFrame, {
            Size = UDim2.new(0, 280, 0, 45),
            Position = UDim2.new(0, 20, 0, 20)
        }, 0.32, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
    end

    local function doRestore()
        _minimized = false
        Body.Visible = true
        TitleFill.Visible = true
        TitleSep.Visible = true
        TitleGlow.Visible = true
        ResizeHandle.Visible = true
        MainFrame.ClipsDescendants = false
        tw(MainStroke1, {Thickness = 1.5}, 0.3)
        tw(MainStroke2, {Thickness = 3}, 0.3)
        tw(MainStroke3, {Thickness = 6}, 0.3)
        local s = _maximized and winMax or winSize
        local p = _maximized
            and UDim2.new(0.5, -winMax.X.Offset/2, 0.5, -winMax.Y.Offset/2)
            or winPos
        tw(MainFrame, {Size = s, Position = p}, 0.32, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
    end

    local _keybindConn
    _keybindConn = UIS.InputBegan:Connect(function(inp, gp)
        if gp then return end
        if inp.KeyCode == savedKeybind then
            if _minimized then doRestore() else doMinimize() end
        end
    end)
    reg(_keybindConn)

    ResetBtn.MouseButton1Click:Connect(function()
        if _minimized then doRestore() else doMinimize() end
    end)
    ResetBtn.MouseEnter:Connect(function()
        tw(ResetBtn, {BackgroundColor3 = Color3.fromRGB(26, 26, 38)}, 0.12)
        tw(ResetFrameStroke, {Thickness = 3}, 0.12)
        tw(ResetBtnStroke, {Thickness = 3}, 0.12)
    end)
    ResetBtn.MouseLeave:Connect(function()
        tw(ResetBtn, {BackgroundColor3 = C.ResetBtnBg}, 0.12)
        tw(ResetFrameStroke, {Thickness = 2}, 0.12)
        tw(ResetBtnStroke, {Thickness = 2}, 0.12)
    end)

    function WindowObj:Destroy()
        _rainbowRunning = false
        rainbowRunning = false
        if ResetFrame and ResetFrame.Parent then ResetFrame:Destroy() end
        for _, c in ipairs(_pool) do pcall(function() c:Disconnect() end) end
        hideTooltip()
        tw(MainFrame, {Size = UDim2.new(0, 0, 0, 0), BackgroundTransparency = 1}, 0.2)
        task.delay(0.21, function()
            if ScreenGui and ScreenGui.Parent then ScreenGui:Destroy() end
        end)
    end

    function WindowObj:GetFrame() return MainFrame end

    function WindowObj:CreateTab(name, icon)
        local first = (_tabIdx == 0)
        local myIdx = _tabIdx
        _tabIdx = _tabIdx + 1

        local TabBtn = Instance.new("TextButton")
        TabBtn.Name  = name
        TabBtn.Size  = UDim2.new(0.9, 0, 0, 36)
        TabBtn.BackgroundColor3 = first and C.TabActive or C.TabInactive
        TabBtn.BackgroundTransparency = 0.02
        TabBtn.BorderSizePixel = 0
        TabBtn.Text = "  " .. (icon and icon .. "  " or "") .. name
        TabBtn.TextColor3 = first and C.TabTextActive or C.TabText
        TabBtn.Font = F.Medium
        TabBtn.TextSize = 12
        TabBtn.TextXAlignment = Enum.TextXAlignment.Left
        TabBtn.AutoButtonColor = false
        TabBtn.LayoutOrder = myIdx
        TabBtn.Parent = TabScroll
        corner(TabBtn, 10)

        if first then stroke(TabBtn, Color3.fromRGB(255, 255, 255), 1, 0.88) end

        local Ind = Instance.new("Frame")
        Ind.Name = "Indicator"
        Ind.Size = UDim2.new(0, 3, 0, 18)
        Ind.Position = UDim2.new(0, 0, 0.5, -9)
        Ind.BackgroundColor3 = C.AccentBlue
        Ind.BackgroundTransparency = first and 0 or 1
        Ind.BorderSizePixel = 0
        corner(Ind, 2)
        Ind.Parent = TabBtn

        TabBtn.MouseEnter:Connect(function()
            if _curTab ~= name then tw(TabBtn, {BackgroundColor3 = Color3.fromRGB(30, 30, 46)}, 0.14) end
        end)
        TabBtn.MouseLeave:Connect(function()
            if _curTab ~= name then tw(TabBtn, {BackgroundColor3 = C.TabInactive}, 0.14) end
        end)

        local PageFrame = Instance.new("Frame")
        PageFrame.Size = UDim2.new(1, 0, 1, 0)
        PageFrame.Position = UDim2.new(first and 0 or 1, 0, 0, 0)
        PageFrame.BackgroundTransparency = 1
        PageFrame.Visible = first
        PageFrame.Parent = PagesHolder

        local SF = Instance.new("ScrollingFrame")
        SF.Size = UDim2.new(1, 0, 1, 0)
        SF.BackgroundTransparency = 1
        SF.BorderSizePixel = 0
        SF.ScrollBarThickness = 2
        SF.ScrollBarImageColor3 = Color3.fromRGB(55, 58, 80)
        SF.ScrollingDirection = Enum.ScrollingDirection.Y
        SF.AutomaticCanvasSize = Enum.AutomaticSize.Y
        SF.CanvasSize = UDim2.new(0, 0, 0, 0)
        SF.Selectable = false
        SF.Parent = PageFrame

        local SFLL = listLayout(SF, Enum.FillDirection.Vertical, 6)
        SFLL.HorizontalAlignment = Enum.HorizontalAlignment.Center
        uiPadding(SF, 10, 10, 0, 0)

        _tabs[name] = {frame = PageFrame, btn = TabBtn, index = myIdx}
        if first then _curTab = name end

        pconn(TabBtn.MouseButton1Click, function()
            switchTab(name)
            local stk = TabBtn:FindFirstChildOfClass("UIStroke")
            if not stk then stroke(TabBtn, Color3.fromRGB(255, 255, 255), 1, 0.88) end
            for n, data in pairs(_tabs) do
                if n ~= name then
                    local s = data.btn:FindFirstChildOfClass("UIStroke")
                    if s then s:Destroy() end
                end
            end
        end)

        local TabObj = {}

        function TabObj:CreateSection(sTitle, collapsed)
            collapsed = collapsed ~= false

            local sectionWrap = Instance.new("Frame")
            sectionWrap.Name = "Section_" .. sTitle
            sectionWrap.Size = UDim2.new(0.97, 0, 0, 36)
            sectionWrap.BackgroundTransparency = 1
            sectionWrap.BorderSizePixel = 0
            sectionWrap.LayoutOrder = 0
            sectionWrap.AutomaticSize = Enum.AutomaticSize.None
            sectionWrap.ClipsDescendants = true
            sectionWrap.Parent = SF

            local sectionLL = listLayout(sectionWrap, Enum.FillDirection.Vertical, 0)
            sectionLL.HorizontalAlignment = Enum.HorizontalAlignment.Center

            local SHdr = Instance.new("Frame")
            SHdr.Name = "SectionHeader"
            SHdr.Size = UDim2.new(1, 0, 0, 36)
            SHdr.BackgroundColor3 = C.SectionHdr
            SHdr.BackgroundTransparency = 0.03
            SHdr.BorderSizePixel = 0
            SHdr.LayoutOrder = 0
            SHdr.Parent = sectionWrap
            corner(SHdr, 11)
            stroke(SHdr, Color3.fromRGB(255, 255, 255), 1, 0.9)

            local SHdrAccent = Instance.new("Frame")
            SHdrAccent.Size = UDim2.new(0, 3, 0.55, 0)
            SHdrAccent.Position = UDim2.new(0, 9, 0.225, 0)
            SHdrAccent.BackgroundColor3 = C.AccentBlue
            SHdrAccent.BackgroundTransparency = 0.2
            SHdrAccent.BorderSizePixel = 0
            SHdrAccent.Parent = SHdr
            corner(SHdrAccent, 2)

            local SHdrLbl = Instance.new("TextLabel")
            SHdrLbl.Size = UDim2.new(1, -60, 1, 0)
            SHdrLbl.Position = UDim2.new(0, 20, 0, 0)
            SHdrLbl.BackgroundTransparency = 1
            SHdrLbl.Text = sTitle
            SHdrLbl.TextColor3 = C.Text
            SHdrLbl.Font = F.Header
            SHdrLbl.TextSize = 13
            SHdrLbl.TextXAlignment = Enum.TextXAlignment.Left
            SHdrLbl.Parent = SHdr

            local ArrowLbl = Instance.new("TextLabel")
            ArrowLbl.Size = UDim2.new(0, 28, 0, 28)
            ArrowLbl.Position = UDim2.new(1, -34, 0, 4)
            ArrowLbl.BackgroundTransparency = 1
            ArrowLbl.Text = ">"
            ArrowLbl.TextColor3 = C.AccentBlue
            ArrowLbl.Font = F.Bold
            ArrowLbl.TextSize = 10
            ArrowLbl.Rotation = collapsed and 0 or 90
            ArrowLbl.Parent = SHdr

            local SC = Instance.new("Frame")
            SC.Name = "SectionContainer"
            SC.Size = UDim2.new(1, 0, 0, 0)
            SC.AutomaticSize = Enum.AutomaticSize.None
            SC.BackgroundColor3 = C.SectionBg
            SC.BackgroundTransparency = 0.04
            SC.BorderSizePixel = 0
            SC.LayoutOrder = 1
            SC.ClipsDescendants = false
            SC.Visible = not collapsed
            SC.Parent = sectionWrap
            corner(SC, 11)
            stroke(SC, Color3.fromRGB(255, 255, 255), 1, 0.92)

            local SCLL = listLayout(SC, Enum.FillDirection.Vertical, 5)
            SCLL.HorizontalAlignment = Enum.HorizontalAlignment.Center
            uiPadding(SC, 6, 6, 0, 0)

            local _isCollapsed = collapsed
            local _dropdownOpen = false

            local function calcSCHeight()
                local totalH = 12
                for _, child in ipairs(SC:GetChildren()) do
                    if child:IsA("Frame") or child:IsA("ScrollingFrame") then
                        if child.Visible then
                            local h = child.AbsoluteSize.Y > 0 and child.AbsoluteSize.Y or child.Size.Y.Offset
                            totalH = totalH + h + 5
                        end
                    end
                end
                return math.max(totalH, 12)
            end

            local function recalcHeight()
                task.wait()
                if _isCollapsed then
                    SC.Size = UDim2.new(1, 0, 0, 0)
                    tw(sectionWrap, {Size = UDim2.new(0.97, 0, 0, 36)}, 0.26, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
                else
                    if _dropdownOpen then return end
                    local contentH = calcSCHeight()
                    SC.Size = UDim2.new(1, 0, 0, contentH)
                    tw(sectionWrap, {Size = UDim2.new(0.97, 0, 0, 36 + contentH + 4)}, 0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
                end
            end

            local SHdrBtn = Instance.new("TextButton")
            SHdrBtn.Size = UDim2.new(1, 0, 1, 0)
            SHdrBtn.BackgroundTransparency = 1
            SHdrBtn.Text = ""
            SHdrBtn.ZIndex = 5
            SHdrBtn.Parent = SHdr

            local _sectionBusy = false
            SHdrBtn.MouseButton1Click:Connect(function()
                if _sectionBusy then return end
                _sectionBusy = true
                _isCollapsed = not _isCollapsed
                if not _isCollapsed then
                    SC.Visible = true
                    tw(ArrowLbl, {Rotation = 90}, 0.24)
                    recalcHeight()
                    task.delay(0.32, function() _sectionBusy = false end)
                else
                    tw(ArrowLbl, {Rotation = 0}, 0.24)
                    tw(sectionWrap, {Size = UDim2.new(0.97, 0, 0, 36)}, 0.26, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
                    task.delay(0.27, function()
                        if _isCollapsed then SC.Visible = false end
                        _sectionBusy = false
                    end)
                end
            end)

            SHdr.MouseEnter:Connect(function()
                tw(SHdr, {BackgroundColor3 = Color3.fromRGB(28, 28, 40)}, 0.14)
                tw(SHdrAccent, {Size = UDim2.new(0, 4, 0.55, 0)}, 0.14)
            end)
            SHdr.MouseLeave:Connect(function()
                tw(SHdr, {BackgroundColor3 = C.SectionHdr}, 0.14)
                tw(SHdrAccent, {Size = UDim2.new(0, 3, 0.55, 0)}, 0.14)
            end)

            if not collapsed then task.delay(0.05, recalcHeight) end

            local SObj = {}
            local _ord = 0
            local function no() _ord = _ord + 1; return _ord end

            local function bf(h)
                local f = Instance.new("Frame")
                f.Size = UDim2.new(0.96, 0, 0, h)
                f.BackgroundColor3 = C.ComponentBg
                f.BackgroundTransparency = 0.03
                f.BorderSizePixel = 0
                f.LayoutOrder = no()
                f.Parent = SC
                corner(f, 10)
                stroke(f, Color3.fromRGB(255, 255, 255), 1, 0.92)
                local innerS = Instance.new("UIStroke")
                innerS.Color = Color3.fromRGB(48, 50, 70)
                innerS.Thickness = 1.5
                innerS.Transparency = 0.6
                innerS.Parent = f
                return f
            end

            function SObj:CreateLabel(text)
                local f = Instance.new("Frame")
                f.Size = UDim2.new(0.96, 0, 0, 0)
                f.AutomaticSize = Enum.AutomaticSize.Y
                f.BackgroundTransparency = 1
                f.BorderSizePixel = 0
                f.LayoutOrder = no()
                f.Parent = SC
                uiPadding(f, 6, 6, 8, 8)
                f:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
                    if not _isCollapsed then recalcHeight() end
                end)
                local lbl = Instance.new("TextLabel")
                lbl.Size = UDim2.new(1, 0, 0, 0)
                lbl.AutomaticSize = Enum.AutomaticSize.Y
                lbl.BackgroundTransparency = 1
                lbl.Text = text
                lbl.TextColor3 = C.LabelText
                lbl.Font = F.Body
                lbl.TextSize = 11
                lbl.TextXAlignment = Enum.TextXAlignment.Left
                lbl.TextWrapped = true
                lbl.Parent = f
                local obj = {}
                function obj:SetText(t) lbl.Text = t; task.defer(function() if not _isCollapsed then recalcHeight() end end) end
                function obj:SetVisible(v) f.Visible = v; recalcHeight() end
                function obj:Destroy() f:Destroy(); recalcHeight() end
                function obj:UpdateCallback() end
                return obj
            end

            local function buildBtn(text, cb, bg, accentColor, confirm)
                local f = bf(48)
                local accentBar = Instance.new("Frame")
                accentBar.Size = UDim2.new(0, 3, 0.6, 0)
                accentBar.Position = UDim2.new(0, 6, 0.2, 0)
                accentBar.BackgroundColor3 = accentColor
                accentBar.BorderSizePixel = 0
                accentBar.Name = "Accent"
                accentBar.Parent = f
                corner(accentBar, 2)
                local lbl = Instance.new("TextLabel")
                lbl.Size = UDim2.new(1, -96, 0, 18)
                lbl.Position = UDim2.new(0, 18, 0, 8)
                lbl.BackgroundTransparency = 1
                lbl.Text = text
                lbl.TextColor3 = C.Text
                lbl.Font = F.Bold
                lbl.TextSize = 12
                lbl.TextXAlignment = Enum.TextXAlignment.Left
                lbl.TextTruncate = Enum.TextTruncate.AtEnd
                lbl.Parent = f
                local sub = Instance.new("TextLabel")
                sub.Size = UDim2.new(1, -96, 0, 14)
                sub.Position = UDim2.new(0, 18, 0, 26)
                sub.BackgroundTransparency = 1
                sub.Text = ""
                sub.TextColor3 = C.SubText
                sub.Font = F.Body
                sub.TextSize = 9
                sub.TextXAlignment = Enum.TextXAlignment.Left
                sub.Visible = false
                sub.Name = "SubLabel"
                sub.Parent = f
                local action = Instance.new("TextButton")
                action.Size = UDim2.new(0, 74, 0, 30)
                action.Position = UDim2.new(1, -82, 0, 9)
                action.BackgroundColor3 = bg
                action.BackgroundTransparency = 0.02
                action.BorderSizePixel = 0
                action.Text = "CLICK"
                action.TextColor3 = Color3.fromRGB(255, 255, 255)
                action.Font = F.Bold
                action.TextSize = 11
                action.AutoButtonColor = false
                action.Parent = f
                corner(action, 8)
                stroke(action, bg, 1, 0.3)
                local _conf = false
                local _orig = "CLICK"
                local _enabled = true
                f.MouseEnter:Connect(function()
                    if not _enabled then return end
                    tw(accentBar, {Size = UDim2.new(0, 5, 0.6, 0)}, 0.12)
                    tw(f, {BackgroundColor3 = Color3.fromRGB(24, 24, 36)}, 0.12)
                end)
                f.MouseLeave:Connect(function()
                    if not _enabled then return end
                    tw(accentBar, {Size = UDim2.new(0, 3, 0.6, 0)}, 0.12)
                    tw(f, {BackgroundColor3 = C.ComponentBg}, 0.12)
                end)
                action.MouseEnter:Connect(function()
                    if not _enabled then return end
                    tw(action, {BackgroundColor3 = Color3.new(math.min(bg.R+0.1,1), math.min(bg.G+0.1,1), math.min(bg.B+0.1,1))}, 0.12)
                end)
                action.MouseLeave:Connect(function()
                    if not _enabled then return end
                    tw(action, {BackgroundColor3 = bg}, 0.12)
                end)
                action.MouseButton1Click:Connect(function()
                    if not _enabled then return end
                    if confirm then
                        if not _conf then
                            _conf = true; action.Text = "SURE?"
                            tw(action, {BackgroundColor3 = Color3.fromRGB(210, 145, 0)}, 0.18)
                            task.delay(2.5, function()
                                if _conf then _conf = false; action.Text = _orig; tw(action, {BackgroundColor3 = bg}, 0.18) end
                            end)
                        else
                            _conf = false; action.Text = _orig
                            tw(action, {BackgroundColor3 = bg}, 0.18); cb()
                        end
                    else
                        tw(action, {Size = UDim2.new(0, 70, 0, 28)}, 0.06)
                        task.delay(0.06, function() tw(action, {Size = UDim2.new(0, 74, 0, 30)}, 0.1) end)
                        cb()
                    end
                end)
                local obj = {}
                function obj:SetText(t, s) lbl.Text = t; if s then sub.Text = s; sub.Visible = true end end
                function obj:SetActionText(t) action.Text = t; _orig = t end
                function obj:SetEnabled(e)
                    _enabled = e; action.Active = e
                    f.BackgroundTransparency = e and 0.03 or 0.5
                    lbl.TextColor3 = e and C.Text or C.SubText
                    action.TextColor3 = e and Color3.fromRGB(255,255,255) or Color3.fromRGB(105,105,118)
                end
                function obj:SetVisible(v) f.Visible = v; recalcHeight() end
                function obj:Destroy() f:Destroy(); recalcHeight() end
                function obj:UpdateCallback(newCb) cb = newCb end
                return obj
            end

            function SObj:CreateButton(text, cb) return buildBtn(text, cb, C.BtnGreen, C.BtnGreen, false) end
            function SObj:CreateDangerButton(text, cb) return buildBtn(text, cb, C.BtnRed, C.BtnRed, true) end

            function SObj:CreateToggle(text, default, cb)
                default = default == true
                local _v = default
                local f = bf(44)
                local lbl = Instance.new("TextLabel")
                lbl.Size = UDim2.new(1, -76, 1, 0)
                lbl.Position = UDim2.new(0, 14, 0, 0)
                lbl.BackgroundTransparency = 1
                lbl.Text = text
                lbl.TextColor3 = C.Text
                lbl.Font = F.Medium
                lbl.TextSize = 12
                lbl.TextXAlignment = Enum.TextXAlignment.Left
                lbl.TextTruncate = Enum.TextTruncate.AtEnd
                lbl.Parent = f
                local track = Instance.new("Frame")
                track.Size = UDim2.new(0, 46, 0, 26)
                track.Position = UDim2.new(1, -56, 0, 9)
                track.BackgroundColor3 = _v and C.ToggleOn or C.ToggleOff
                track.BorderSizePixel = 0
                track.Parent = f
                corner(track, 13)
                local trackStroke = Instance.new("UIStroke")
                trackStroke.Color = _v and C.ToggleOn or Color3.fromRGB(42,42,58)
                trackStroke.Thickness = 1
                trackStroke.Transparency = _v and 0.5 or 0.2
                trackStroke.Parent = track
                local dot = Instance.new("Frame")
                dot.Size = UDim2.new(0, 19, 0, 19)
                dot.Position = _v and UDim2.new(0,24,0,3) or UDim2.new(0,3,0,3)
                dot.BackgroundColor3 = Color3.fromRGB(255,255,255)
                dot.BorderSizePixel = 0
                dot.Parent = track
                corner(dot, 10)
                local hb = Instance.new("TextButton")
                hb.Size = UDim2.new(1,0,1,0)
                hb.BackgroundTransparency = 1
                hb.Text = ""
                hb.ZIndex = 5
                hb.Parent = f
                local function apply(v, anim)
                    if anim then
                        tw(track, {BackgroundColor3 = v and C.ToggleOn or C.ToggleOff}, 0.2)
                        tw(dot, {Position = v and UDim2.new(0,24,0,3) or UDim2.new(0,3,0,3)}, 0.2)
                        tw(trackStroke, {Color = v and C.ToggleOn or Color3.fromRGB(42,42,58), Transparency = v and 0.5 or 0.2}, 0.2)
                        if v then
                            tw(dot, {Size = UDim2.new(0,21,0,21), Position = UDim2.new(0,23,0,2)}, 0.08)
                            task.delay(0.08, function() tw(dot, {Size = UDim2.new(0,19,0,19), Position = UDim2.new(0,24,0,3)}, 0.14) end)
                        end
                    else
                        track.BackgroundColor3 = v and C.ToggleOn or C.ToggleOff
                        dot.Position = v and UDim2.new(0,24,0,3) or UDim2.new(0,3,0,3)
                        trackStroke.Color = v and C.ToggleOn or Color3.fromRGB(42,42,58)
                        trackStroke.Transparency = v and 0.5 or 0.2
                    end
                end
                hb.MouseButton1Click:Connect(function() _v = not _v; apply(_v, true); cb(_v) end)
                local obj = {}
                function obj:SetValue(v) _v = v==true; apply(_v, true); cb(_v) end
                function obj:GetValue() return _v end
                function obj:SetEnabled(e) hb.Active = e; f.BackgroundTransparency = e and 0.03 or 0.5 end
                function obj:SetVisible(v) f.Visible = v; recalcHeight() end
                function obj:Destroy() f:Destroy(); recalcHeight() end
                function obj:UpdateCallback(newCb) cb = newCb end
                return obj
            end

            function SObj:CreateSlider(text, mn, mx, def, cb, float)
                mn = mn or 0; mx = mx or 100
                -- FIX: guard division by zero
                if mn == mx then mx = mn + 1 end
                def = math.clamp(def or mn, mn, mx); float = float or false
                local _v = def
                local f = bf(62)
                local lbl = Instance.new("TextLabel")
                lbl.Size = UDim2.new(1, -88, 0, 18); lbl.Position = UDim2.new(0,14,0,8)
                lbl.BackgroundTransparency = 1; lbl.Text = text; lbl.TextColor3 = C.Text
                lbl.Font = F.Medium; lbl.TextSize = 12; lbl.TextXAlignment = Enum.TextXAlignment.Left
                lbl.TextTruncate = Enum.TextTruncate.AtEnd; lbl.Parent = f
                local valBg = Instance.new("Frame")
                valBg.Size = UDim2.new(0,54,0,22); valBg.Position = UDim2.new(1,-64,0,6)
                valBg.BackgroundColor3 = Color3.fromRGB(26,26,38); valBg.BackgroundTransparency = 0.03
                valBg.BorderSizePixel = 0; valBg.Parent = f
                corner(valBg, 7)
                local valStroke = stroke(valBg, C.CompStroke, 1, 0.3)
                local function fmtVal(v)
                    if not float then return tostring(v) end
                    local range = mx - mn
                    if range <= 0.01 then return string.format("%.4f", v)
                    elseif range <= 1 then return string.format("%.3f", v)
                    else return string.format("%.2f", v) end
                end
                local valBox = Instance.new("TextBox")
                valBox.Size = UDim2.new(1,-6,1,0); valBox.Position = UDim2.new(0,3,0,0)
                valBox.BackgroundTransparency = 1; valBox.BorderSizePixel = 0
                valBox.Text = fmtVal(def)
                valBox.TextColor3 = C.SliderFill; valBox.Font = F.Bold; valBox.TextSize = 11
                valBox.TextXAlignment = Enum.TextXAlignment.Center; valBox.ClearTextOnFocus = true; valBox.Parent = valBg
                valBox.Focused:Connect(function() valStroke.Color = C.SliderFill; valStroke.Transparency = 0.1; tw(valBg,{BackgroundColor3=Color3.fromRGB(28,30,48)},0.14) end)
                local bar = Instance.new("Frame")
                bar.Size = UDim2.new(1,-26,0,6); bar.Position = UDim2.new(0,14,0,40)
                bar.BackgroundColor3 = C.SliderBg; bar.BorderSizePixel = 0; bar.ClipsDescendants = true; bar.Parent = f
                corner(bar, 3)
                local fPct = (def-mn)/(mx-mn)
                local fill = Instance.new("Frame")
                fill.Size = UDim2.new(fPct,0,1,0); fill.BackgroundColor3 = C.SliderFill; fill.BorderSizePixel = 0; fill.Parent = bar
                corner(fill, 3)
                local knob = Instance.new("TextButton")
                knob.Size = UDim2.new(0,16,0,16); knob.Position = UDim2.new(fPct,-8,0,-5)
                knob.BackgroundColor3 = Color3.fromRGB(240,242,255); knob.BorderSizePixel = 0
                knob.Text = ""; knob.AutoButtonColor = false; knob.ZIndex = 5; knob.Parent = bar
                corner(knob, 8); stroke(knob, C.SliderFill, 1.5, 0.1)
                local function roundToStep(val)
                    if not float then return math.floor(val+0.5) end
                    local range = mx - mn
                    local decimals = range <= 0.01 and 4 or range <= 1 and 3 or 2
                    local factor = 10^decimals
                    return math.floor(val * factor + 0.5) / factor
                end
                local function setPct(pct)
                    pct = math.clamp(pct,0,1)
                    _v = math.clamp(roundToStep(mn+(mx-mn)*pct), mn, mx)
                    fill.Size = UDim2.new(pct,0,1,0); knob.Position = UDim2.new(pct,-8,0,-5)
                    valBox.Text = fmtVal(_v); cb(_v)
                end
                valBox.FocusLost:Connect(function()
                    valStroke.Color = C.CompStroke; valStroke.Transparency = 0.3
                    tw(valBg,{BackgroundColor3=Color3.fromRGB(26,26,38)},0.14)
                    local typed = tonumber(valBox.Text)
                    if typed then
                        _v = math.clamp(roundToStep(typed), mn, mx)
                        local p = (_v-mn)/(mx-mn)
                        fill.Size=UDim2.new(p,0,1,0); knob.Position=UDim2.new(p,-8,0,-5)
                        valBox.Text=fmtVal(_v); cb(_v)
                    else valBox.Text=fmtVal(_v) end
                end)
                local _sliderDragging = false
                local function drag(inp)
                if _sliderDragging then return end
                _sliderDragging = true
                tw(knob, {Size = UDim2.new(0,20,0,20)}, 0.1)
                local isTouch = inp.UserInputType == Enum.UserInputType.Touch

                -- FIX: Matikan scroll ScrollingFrame biar touch gak dicuri di mobile
                local parentScroll = bar:FindFirstAncestorOfClass("ScrollingFrame")
                if parentScroll then parentScroll.ScrollingEnabled = false end

                local function calcPct(pos)
                    local bx = bar.AbsoluteSize.X
                    if bx <= 0 then return end
                    setPct((pos.X - bar.AbsolutePosition.X) / bx)
                end

                calcPct(inp.Position)

                local mc, ec
                mc = UIS.InputChanged:Connect(function(mi)
                    if isTouch then
                        if mi.UserInputType == Enum.UserInputType.Touch then
                            calcPct(mi.Position)
                        end
                    else
                        if mi.UserInputType == Enum.UserInputType.MouseMovement then
                            calcPct(mi.Position)
                        end
                    end
                end)
                ec = UIS.InputEnded:Connect(function(ei)
                    local ended = (isTouch and ei.UserInputType == Enum.UserInputType.Touch)
                        or (not isTouch and ei.UserInputType == Enum.UserInputType.MouseButton1)
                    if ended then
                        _sliderDragging = false
                        tw(knob, {Size = UDim2.new(0,16,0,16)}, 0.1)
                        -- FIX: Nyalain lagi scroll ScrollingFrame
                        if parentScroll then parentScroll.ScrollingEnabled = true end
                        mc:Disconnect(); ec:Disconnect()
                    end
                end)
            end
                knob.InputBegan:Connect(function(i)
                    if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
                        drag(i)
                    end
                end)
                bar.InputBegan:Connect(function(i)
                    if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then drag(i) end
                end)
                local obj = {}
                function obj:SetValue(v)
                    _v=math.clamp(roundToStep(v),mn,mx)
                    local p=(_v-mn)/(mx-mn); fill.Size=UDim2.new(p,0,1,0); knob.Position=UDim2.new(p,-8,0,-5)
                    valBox.Text=fmtVal(_v); cb(_v)
                end
                function obj:GetValue() return _v end
                function obj:SetEnabled(e) knob.Active=e; f.BackgroundTransparency=e and 0.03 or 0.5 end
                function obj:SetVisible(v) f.Visible=v; recalcHeight() end
                function obj:Destroy() f:Destroy(); recalcHeight() end
                function obj:UpdateCallback(newCb) cb=newCb end
                return obj
            end

            function SObj:CreateDropdown(config, _legacyOpts, _legacyCb, _legacyMulti)
                if type(config) == "string" then
                    config = {Text=config, Options=_legacyOpts or {"Option 1"}, Callback=_legacyCb or function() end, MultiSelect=_legacyMulti or false}
                end
                local text=config.Text or "Dropdown"; local opts=config.Options or {"Option 1"}
                local cb=config.Callback or function() end; local multi=config.MultiSelect or false
                local _sel={}; local _open=false; local optH=32; local maxV=5; local pad=8
                if multi then _sel={}; if opts[1] then _sel[opts[1]]=true end else _sel=opts[1] end
                local function calcListH() return math.min(#opts,maxV)*optH+pad end
                local wrap=Instance.new("Frame")
                wrap.Name="DD_"..text; wrap.Size=UDim2.new(0.96,0,0,38); wrap.BackgroundColor3=C.ComponentBg
                wrap.BackgroundTransparency=0.03; wrap.BorderSizePixel=0; wrap.LayoutOrder=no()
                wrap.ClipsDescendants=true; wrap.ZIndex=2; wrap.Parent=SC
                corner(wrap,10); stroke(wrap,Color3.fromRGB(255,255,255),1,0.92)
                local wrapInner=Instance.new("UIStroke"); wrapInner.Color=Color3.fromRGB(48,50,70)
                wrapInner.Thickness=1.5; wrapInner.Transparency=0.6; wrapInner.Parent=wrap
                local lbl=Instance.new("TextLabel"); lbl.Size=UDim2.new(1,-160,0,38); lbl.Position=UDim2.new(0,14,0,0)
                lbl.BackgroundTransparency=1; lbl.Text=text; lbl.TextColor3=C.Text; lbl.Font=F.Medium
                lbl.TextSize=12; lbl.TextXAlignment=Enum.TextXAlignment.Left
                lbl.TextTruncate=Enum.TextTruncate.AtEnd; lbl.ZIndex=3; lbl.Parent=wrap
                local selLbl=Instance.new("TextLabel"); selLbl.Size=UDim2.new(0,108,0,38); selLbl.Position=UDim2.new(1,-144,0,0)
                selLbl.BackgroundTransparency=1; selLbl.TextColor3=C.SubText; selLbl.Font=F.Medium
                selLbl.TextSize=11; selLbl.TextXAlignment=Enum.TextXAlignment.Right; selLbl.TextTruncate=Enum.TextTruncate.AtEnd
                selLbl.ZIndex=3; selLbl.Parent=wrap
                local arrow=Instance.new("TextLabel"); arrow.Size=UDim2.new(0,20,0,38); arrow.Position=UDim2.new(1,-24,0,0)
                arrow.BackgroundTransparency=1; arrow.Text="v"; arrow.TextColor3=C.AccentBlue
                arrow.Font=F.Body; arrow.TextSize=9; arrow.ZIndex=3; arrow.Parent=wrap
                local sep=Instance.new("Frame"); sep.Size=UDim2.new(1,0,0,1); sep.Position=UDim2.new(0,0,0,38)
                sep.BackgroundColor3=Color3.fromRGB(255,255,255); sep.BackgroundTransparency=0.88
                sep.BorderSizePixel=0; sep.ZIndex=3; sep.Visible=false; sep.Parent=wrap
                local listH=calcListH(); local fullH=#opts*optH+pad
                local optSF=Instance.new("ScrollingFrame"); optSF.Size=UDim2.new(1,0,0,listH)
                optSF.Position=UDim2.new(0,0,0,39); optSF.BackgroundColor3=C.DropdownBg
                optSF.BackgroundTransparency=0.03; optSF.BorderSizePixel=0; optSF.ScrollBarThickness=2
                optSF.ScrollBarImageColor3=Color3.fromRGB(58,60,80); optSF.ScrollingDirection=Enum.ScrollingDirection.Y
                optSF.CanvasSize=UDim2.new(0,0,0,fullH); optSF.Selectable=false; optSF.ZIndex=3
                optSF.Visible=false; optSF.Parent=wrap
                local function updateSelText()
                    if multi then
                        local count=0; for _,v in pairs(_sel) do if v then count=count+1 end end
                        selLbl.Text=count.." selected"
                    else selLbl.Text=_sel or "" end
                end
                updateSelText()
                local _outsideClickConn=nil; local _openTick=0; local _heightBeforeOpen=0
                local function closeDropdown()
                    if not _open then return end
                    _open=false; _dropdownOpen=false
                    tw(wrap,{Size=UDim2.new(0.96,0,0,38)},0.22,Enum.EasingStyle.Quart,Enum.EasingDirection.In)
                    tw(arrow,{Rotation=0},0.18)
                    SC.Size=UDim2.new(1,0,0,_heightBeforeOpen)
                    tw(sectionWrap,{Size=UDim2.new(0.97,0,0,36+_heightBeforeOpen+4)},0.22,Enum.EasingStyle.Quart,Enum.EasingDirection.In)
                    task.delay(0.23,function()
                        if not _open then sep.Visible=false; optSF.Visible=false; wrap.ClipsDescendants=true end
                    end)
                    if _outsideClickConn then _outsideClickConn:Disconnect(); _outsideClickConn=nil end
                end
                local function openDropdown()
                    _open=true; _dropdownOpen=true; _openTick=tick(); _heightBeforeOpen=calcSCHeight()
                    listH=calcListH(); fullH=#opts*optH+pad
                    optSF.Size=UDim2.new(1,0,0,listH); optSF.CanvasSize=UDim2.new(0,0,0,fullH)
                    wrap.ClipsDescendants=false; sep.Visible=true; optSF.Visible=true
                    tw(wrap,{Size=UDim2.new(0.96,0,0,38+1+listH)},0.22,Enum.EasingStyle.Quart,Enum.EasingDirection.Out)
                    tw(arrow,{Rotation=180},0.18)
                    local newSCH=_heightBeforeOpen+listH+1
                    SC.Size=UDim2.new(1,0,0,newSCH)
                    tw(sectionWrap,{Size=UDim2.new(0.97,0,0,36+newSCH+4)},0.22,Enum.EasingStyle.Quart,Enum.EasingDirection.Out)
                end
                local function buildOpts(list)
                    for _,c in ipairs(optSF:GetChildren()) do if c:IsA("TextButton") then c:Destroy() end end
                    for i,opt in ipairs(list) do
                        local ob=Instance.new("TextButton")
                        ob.Size=UDim2.new(0.92,0,0,optH-4); ob.Position=UDim2.new(0.04,0,0,pad/2+(i-1)*optH)
                        ob.BackgroundColor3=(multi and _sel[opt]) and C.SliderFill or C.OptionBg
                        ob.BackgroundTransparency=0.03; ob.BorderSizePixel=0
                        ob.Text="  "..opt; ob.TextColor3=C.Text; ob.Font=F.Body; ob.TextSize=12
                        ob.TextXAlignment=Enum.TextXAlignment.Left; ob.TextTruncate=Enum.TextTruncate.AtEnd
                        ob.AutoButtonColor=false; ob.ZIndex=4; ob.Parent=optSF; corner(ob,7)
                        ob.MouseEnter:Connect(function() if not(multi and _sel[opt]) then tw(ob,{BackgroundColor3=C.OptionHover},0.1) end end)
                        ob.MouseLeave:Connect(function() tw(ob,{BackgroundColor3=(multi and _sel[opt]) and C.SliderFill or C.OptionBg},0.1) end)
                        ob.MouseButton1Click:Connect(function()
                            if multi then
                                _sel[opt]=not _sel[opt]; tw(ob,{BackgroundColor3=_sel[opt] and C.SliderFill or C.OptionBg},0.12)
                                updateSelText(); local sel={}
                                for o,v in pairs(_sel) do if v then table.insert(sel,o) end end; cb(_sel,sel)
                            else _sel=opt; selLbl.Text=opt; closeDropdown(); cb(opt) end
                        end)
                    end
                end
                buildOpts(opts)
                local trig=Instance.new("TextButton"); trig.Size=UDim2.new(1,0,0,38)
                trig.BackgroundTransparency=1; trig.Text=""; trig.ZIndex=10; trig.Parent=wrap
                local _ddBusy=false
                trig.MouseButton1Click:Connect(function()
                    if _ddBusy then return end
                    _ddBusy=true
                    if _open then
                        closeDropdown()
                        task.delay(0.25, function() _ddBusy=false end)
                    else
                        openDropdown()
                        task.delay(0.25, function() _ddBusy=false end)
                    end
                end)
                local obj={}
                function obj:SetValue(v)
                    if multi then
                        if type(v)=="table" then _sel=v else _sel[v]=not _sel[v] end
                        updateSelText(); buildOpts(opts)
                        local sel={}; for o,val in pairs(_sel) do if val then table.insert(sel,o) end end; cb(_sel,sel)
                    else if table.find(opts,v) then _sel=v; selLbl.Text=v; cb(v) end end
                end
                function obj:GetValue()
                    if multi then local sel={}; for o,v in pairs(_sel) do if v then table.insert(sel,o) end end; return _sel,sel
                    else return _sel end
                end
                function obj:SetOptions(newOpts)
                    opts=newOpts
                    if multi then _sel={}; if newOpts[1] then _sel[newOpts[1]]=true end else _sel=newOpts[1] or "" end
                    if _open then closeDropdown() end; updateSelText(); buildOpts(newOpts)
                end
                function obj:Close() closeDropdown() end
                function obj:SetEnabled(e) trig.Active=e; wrap.BackgroundTransparency=e and 0.03 or 0.5; if not e then closeDropdown() end end
                function obj:SetVisible(v) wrap.Visible=v; if not v then closeDropdown() end; recalcHeight() end
                function obj:Destroy() closeDropdown(); wrap:Destroy(); recalcHeight() end
                function obj:UpdateCallback(newCb) cb=newCb end
                return obj
            end

            function SObj:CreateKeybind(text, defKey, cb)
                defKey=defKey or Enum.KeyCode.F
                local _key=defKey; local _bind=false; local _kconn=nil
                local f=bf(44)
                local lbl=Instance.new("TextLabel"); lbl.Size=UDim2.new(1,-96,1,0); lbl.Position=UDim2.new(0,14,0,0)
                lbl.BackgroundTransparency=1; lbl.Text=text; lbl.TextColor3=C.Text
                lbl.Font=F.Medium; lbl.TextSize=12; lbl.TextXAlignment=Enum.TextXAlignment.Left
                lbl.TextTruncate=Enum.TextTruncate.AtEnd; lbl.Parent=f
                local kBtn=Instance.new("TextButton"); kBtn.Size=UDim2.new(0,68,0,30); kBtn.Position=UDim2.new(1,-78,0,7)
                kBtn.BackgroundColor3=C.KeybindBg; kBtn.BackgroundTransparency=0.02; kBtn.BorderSizePixel=0
                kBtn.Text=defKey.Name; kBtn.TextColor3=C.TabTextActive; kBtn.Font=F.Bold; kBtn.TextSize=10
                kBtn.AutoButtonColor=false; kBtn.Parent=f; corner(kBtn,8); stroke(kBtn,C.CompStroke,1,0.24)
                local function stopBind() if _kconn then _kconn:Disconnect(); _kconn=nil end end
                kBtn.MouseButton1Click:Connect(function()
                    if _bind then stopBind(); _bind=false; kBtn.Text=_key.Name; tw(kBtn,{BackgroundColor3=C.KeybindBg},0.12); return end
                    _bind=true; kBtn.Text="..."; tw(kBtn,{BackgroundColor3=Color3.fromRGB(58,58,86)},0.12)
                    _kconn=UIS.InputBegan:Connect(function(inp,gp)
                        if not _bind then return end; if gp then return end
                        if inp.KeyCode==Enum.KeyCode.Unknown then return end
                        _key=inp.KeyCode; kBtn.Text=_key.Name; _bind=false
                        tw(kBtn,{BackgroundColor3=C.KeybindBg},0.12); stopBind(); cb(_key)
                    end)
                    reg(_kconn)
                end)
                local obj={}
                function obj:SetValue(k) _key=k; kBtn.Text=k.Name; cb(k) end
                function obj:GetValue() return _key end
                function obj:SetEnabled(e) kBtn.Active=e; f.BackgroundTransparency=e and 0.03 or 0.5 end
                function obj:SetVisible(v) f.Visible=v; recalcHeight() end
                function obj:Destroy() stopBind(); f:Destroy(); recalcHeight() end
                function obj:UpdateCallback(newCb) cb=newCb end
                return obj
            end

            -- GRADIENT COLOR PICKER (replaces old RGB slider picker)
            function SObj:CreateColorPicker(text, defColor, cb)
                defColor = defColor or Color3.fromRGB(255, 255, 255)
                local _h, _s, _v2 = Color3.toHSV(defColor)
                local _open = false
                local PANEL_H = 198

                local wrapper = Instance.new("Frame")
                wrapper.Size = UDim2.new(0.96, 0, 0, 44)
                wrapper.BackgroundColor3 = C.ComponentBg
                wrapper.BackgroundTransparency = 0.03
                wrapper.BorderSizePixel = 0
                wrapper.LayoutOrder = no()
                wrapper.ClipsDescendants = true
                wrapper.Parent = SC
                corner(wrapper, 10)
                stroke(wrapper, Color3.fromRGB(255, 255, 255), 1, 0.92)
                local wrapInner = Instance.new("UIStroke")
                wrapInner.Color = Color3.fromRGB(48, 50, 70)
                wrapInner.Thickness = 1.5; wrapInner.Transparency = 0.6; wrapInner.Parent = wrapper

                local lbl = Instance.new("TextLabel")
                lbl.Size = UDim2.new(1, -60, 0, 44); lbl.Position = UDim2.new(0, 14, 0, 0)
                lbl.BackgroundTransparency = 1; lbl.Text = text; lbl.TextColor3 = C.Text
                lbl.Font = F.Medium; lbl.TextSize = 12; lbl.TextXAlignment = Enum.TextXAlignment.Left
                lbl.TextTruncate = Enum.TextTruncate.AtEnd; lbl.ZIndex = 3; lbl.Parent = wrapper

                local prev = Instance.new("Frame")
                prev.Size = UDim2.new(0, 28, 0, 28); prev.Position = UDim2.new(1, -40, 0, 8)
                prev.BackgroundColor3 = defColor; prev.BorderSizePixel = 0; prev.ZIndex = 3; prev.Parent = wrapper
                corner(prev, 8); stroke(prev, Color3.fromRGB(255, 255, 255), 1.5, 0.75)

                local arrowLbl = Instance.new("TextLabel")
                arrowLbl.Size = UDim2.new(0, 14, 0, 44); arrowLbl.Position = UDim2.new(1, -14, 0, 0)
                arrowLbl.BackgroundTransparency = 1; arrowLbl.Text = "v"
                arrowLbl.TextColor3 = C.AccentBlue; arrowLbl.Font = F.Body; arrowLbl.TextSize = 9
                arrowLbl.ZIndex = 3; arrowLbl.Parent = wrapper

                local panel = Instance.new("Frame")
                panel.Size = UDim2.new(1, 0, 0, PANEL_H); panel.Position = UDim2.new(0, 0, 0, 44)
                panel.BackgroundColor3 = Color3.fromRGB(17, 17, 26); panel.BackgroundTransparency = 0.03
                panel.BorderSizePixel = 0; panel.ZIndex = 4; panel.Visible = false; panel.Parent = wrapper

                local panelSep = Instance.new("Frame")
                panelSep.Size = UDim2.new(1, 0, 0, 1); panelSep.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                panelSep.BackgroundTransparency = 0.88; panelSep.BorderSizePixel = 0
                panelSep.ZIndex = 4; panelSep.Parent = panel

                -- SV grid
                local SV_H = 120
                local svFrame = Instance.new("Frame")
                svFrame.Size = UDim2.new(1, -16, 0, SV_H); svFrame.Position = UDim2.new(0, 8, 0, 8)
                svFrame.BackgroundColor3 = Color3.fromHSV(_h, 1, 1); svFrame.BorderSizePixel = 0
                svFrame.ClipsDescendants = true; svFrame.ZIndex = 5; svFrame.Parent = panel
                corner(svFrame, 6)

                local svWhite = Instance.new("Frame")
                svWhite.Size = UDim2.new(1, 0, 1, 0); svWhite.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                svWhite.ZIndex = 5; svWhite.Parent = svFrame
                local svWhiteGrad = Instance.new("UIGradient")
                svWhiteGrad.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(1, 1)})
                svWhiteGrad.Rotation = 0; svWhiteGrad.Parent = svWhite

                local svBlack = Instance.new("Frame")
                svBlack.Size = UDim2.new(1, 0, 1, 0); svBlack.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
                svBlack.ZIndex = 6; svBlack.Parent = svFrame
                local svBlackGrad = Instance.new("UIGradient")
                svBlackGrad.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(1, 0)})
                svBlackGrad.Rotation = 90; svBlackGrad.Parent = svBlack

                local svKnob = Instance.new("Frame")
                svKnob.Size = UDim2.new(0, 14, 0, 14); svKnob.AnchorPoint = Vector2.new(0.5, 0.5)
                svKnob.Position = UDim2.new(_s, 0, 1 - _v2, 0); svKnob.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                svKnob.BorderSizePixel = 0; svKnob.ZIndex = 8; svKnob.Parent = svFrame
                corner(svKnob, 7); stroke(svKnob, Color3.fromRGB(255, 255, 255), 2, 0.2)

                local svBtn = Instance.new("TextButton")
                svBtn.Size = UDim2.new(1, 0, 1, 0); svBtn.BackgroundTransparency = 1
                svBtn.Text = ""; svBtn.ZIndex = 9; svBtn.Parent = svFrame

                -- Hue bar
                local hueBarH = 14
                local hueBar = Instance.new("Frame")
                hueBar.Size = UDim2.new(1, -16, 0, hueBarH); hueBar.Position = UDim2.new(0, 8, 0, SV_H + 14)
                hueBar.BorderSizePixel = 0; hueBar.ZIndex = 5; hueBar.ClipsDescendants = true; hueBar.Parent = panel
                corner(hueBar, 7)
                local hueGrad = Instance.new("UIGradient")
                hueGrad.Color = ColorSequence.new({
                    ColorSequenceKeypoint.new(0,    Color3.fromHSV(0,    1, 1)),
                    ColorSequenceKeypoint.new(0.167, Color3.fromHSV(0.167,1, 1)),
                    ColorSequenceKeypoint.new(0.333, Color3.fromHSV(0.333,1, 1)),
                    ColorSequenceKeypoint.new(0.5,  Color3.fromHSV(0.5,  1, 1)),
                    ColorSequenceKeypoint.new(0.667, Color3.fromHSV(0.667,1, 1)),
                    ColorSequenceKeypoint.new(0.833, Color3.fromHSV(0.833,1, 1)),
                    ColorSequenceKeypoint.new(1,    Color3.fromHSV(0,    1, 1)),
                })
                hueGrad.Parent = hueBar

                local hueKnob = Instance.new("Frame")
                hueKnob.Size = UDim2.new(0, 12, 1, 4); hueKnob.AnchorPoint = Vector2.new(0.5, 0.5)
                hueKnob.Position = UDim2.new(_h, 0, 0.5, 0); hueKnob.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                hueKnob.BorderSizePixel = 0; hueKnob.ZIndex = 7; hueKnob.Parent = hueBar
                corner(hueKnob, 4); stroke(hueKnob, Color3.fromRGB(200, 200, 200), 1.5, 0.3)

                local hueBtn = Instance.new("TextButton")
                hueBtn.Size = UDim2.new(1, 0, 1, 0); hueBtn.BackgroundTransparency = 1
                hueBtn.Text = ""; hueBtn.ZIndex = 8; hueBtn.Parent = hueBar

                -- Hex input
                local hexY = SV_H + 14 + hueBarH + 10
                local hexBg = Instance.new("Frame")
                hexBg.Size = UDim2.new(1, -16, 0, 28); hexBg.Position = UDim2.new(0, 8, 0, hexY)
                hexBg.BackgroundColor3 = C.InputBg; hexBg.BackgroundTransparency = 0.03
                hexBg.BorderSizePixel = 0; hexBg.ZIndex = 5; hexBg.Parent = panel
                corner(hexBg, 7)
                local hexStroke = stroke(hexBg, C.CompStroke, 1, 0.3)

                local hexPrefix = Instance.new("TextLabel")
                hexPrefix.Size = UDim2.new(0, 20, 1, 0); hexPrefix.Position = UDim2.new(0, 6, 0, 0)
                hexPrefix.BackgroundTransparency = 1; hexPrefix.Text = "#"; hexPrefix.TextColor3 = C.SubText
                hexPrefix.Font = F.Bold; hexPrefix.TextSize = 11; hexPrefix.ZIndex = 6; hexPrefix.Parent = hexBg

                local hexBox = Instance.new("TextBox")
                hexBox.Size = UDim2.new(1, -28, 1, 0); hexBox.Position = UDim2.new(0, 22, 0, 0)
                hexBox.BackgroundTransparency = 1; hexBox.BorderSizePixel = 0
                hexBox.PlaceholderText = "RRGGBB"; hexBox.PlaceholderColor3 = Color3.fromRGB(70, 70, 90)
                hexBox.TextColor3 = C.Text; hexBox.Font = F.Bold; hexBox.TextSize = 11
                hexBox.ClearTextOnFocus = true; hexBox.ZIndex = 6; hexBox.Parent = hexBg

                local function getColor() return Color3.fromHSV(_h, _s, _v2) end
                local function colorToHex(c)
                    return string.format("%02X%02X%02X", math.floor(c.R*255+0.5), math.floor(c.G*255+0.5), math.floor(c.B*255+0.5))
                end
                local function applyColor(skipHex)
                    local c = getColor()
                    prev.BackgroundColor3 = c
                    svFrame.BackgroundColor3 = Color3.fromHSV(_h, 1, 1)
                    svKnob.Position = UDim2.new(_s, 0, 1 - _v2, 0)
                    hueKnob.Position = UDim2.new(_h, 0, 0.5, 0)
                    if not skipHex then hexBox.Text = colorToHex(c) end
                    cb(c)
                end

                local function dragSV(inp)
                    _s = math.clamp((inp.Position.X - svFrame.AbsolutePosition.X) / svFrame.AbsoluteSize.X, 0, 1)
                    _v2 = 1 - math.clamp((inp.Position.Y - svFrame.AbsolutePosition.Y) / svFrame.AbsoluteSize.Y, 0, 1)
                    applyColor()
                end
                local function dragHue(inp)
                    _h = math.clamp((inp.Position.X - hueBar.AbsolutePosition.X) / hueBar.AbsoluteSize.X, 0, 1)
                    applyColor()
                end

                svBtn.InputBegan:Connect(function(inp)
                    if inp.UserInputType == Enum.UserInputType.MouseButton1 or inp.UserInputType == Enum.UserInputType.Touch then
                        local isTouch = inp.UserInputType == Enum.UserInputType.Touch
                        dragSV(inp)
                        local mc, ec
                        mc = UIS.InputChanged:Connect(function(mi)
                            if isTouch then
                                if mi.UserInputType == Enum.UserInputType.Touch then dragSV(mi) end
                            else
                                if mi.UserInputType == Enum.UserInputType.MouseMovement then dragSV(mi) end
                            end
                        end)
                        ec = UIS.InputEnded:Connect(function(ei)
                            local ended = (isTouch and ei.UserInputType == Enum.UserInputType.Touch)
                                or (not isTouch and ei.UserInputType == Enum.UserInputType.MouseButton1)
                            if ended then mc:Disconnect(); ec:Disconnect() end
                        end)
                    end
                end)

                hueBtn.InputBegan:Connect(function(inp)
                    if inp.UserInputType == Enum.UserInputType.MouseButton1 or inp.UserInputType == Enum.UserInputType.Touch then
                        local isTouch = inp.UserInputType == Enum.UserInputType.Touch
                        dragHue(inp)
                        local mc, ec
                        mc = UIS.InputChanged:Connect(function(mi)
                            if isTouch then
                                if mi.UserInputType == Enum.UserInputType.Touch then dragHue(mi) end
                            else
                                if mi.UserInputType == Enum.UserInputType.MouseMovement then dragHue(mi) end
                            end
                        end)
                        ec = UIS.InputEnded:Connect(function(ei)
                            local ended = (isTouch and ei.UserInputType == Enum.UserInputType.Touch)
                                or (not isTouch and ei.UserInputType == Enum.UserInputType.MouseButton1)
                            if ended then mc:Disconnect(); ec:Disconnect() end
                        end)
                    end
                end)

                hexBox.Focused:Connect(function() hexStroke.Color = C.SliderFill; hexStroke.Transparency = 0.1 end)
                hexBox.FocusLost:Connect(function()
                    hexStroke.Color = C.CompStroke; hexStroke.Transparency = 0.3
                    local hex = hexBox.Text:gsub("#",""):upper()
                    if #hex == 6 then
                        local r=tonumber(hex:sub(1,2),16); local g=tonumber(hex:sub(3,4),16); local b=tonumber(hex:sub(5,6),16)
                        if r and g and b then
                            _h,_s,_v2 = Color3.toHSV(Color3.fromRGB(r,g,b)); applyColor(true)
                        end
                    end
                    hexBox.Text = colorToHex(getColor())
                end)

                local trig = Instance.new("TextButton")
                trig.Size = UDim2.new(1, 0, 0, 44); trig.BackgroundTransparency = 1
                trig.Text = ""; trig.ZIndex = 10; trig.Parent = wrapper

                trig.MouseButton1Click:Connect(function()
                    _open = not _open
                    tw(arrowLbl, {Rotation = _open and 180 or 0}, 0.18)
                    if _open then
                        panel.Visible = true; wrapper.ClipsDescendants = false
                        hexBox.Text = colorToHex(getColor())
                        tw(wrapper, {Size = UDim2.new(0.96, 0, 0, 44 + PANEL_H)}, 0.22, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
                        local newH = calcSCHeight() + PANEL_H
                        SC.Size = UDim2.new(1, 0, 0, newH)
                        tw(sectionWrap, {Size = UDim2.new(0.97, 0, 0, 36 + newH + 4)}, 0.22, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
                    else
                        tw(wrapper, {Size = UDim2.new(0.96, 0, 0, 44)}, 0.22, Enum.EasingStyle.Quart, Enum.EasingDirection.In)
                        local newH = calcSCHeight() - PANEL_H
                        SC.Size = UDim2.new(1, 0, 0, newH)
                        tw(sectionWrap, {Size = UDim2.new(0.97, 0, 0, 36 + newH + 4)}, 0.22, Enum.EasingStyle.Quart, Enum.EasingDirection.In)
                        task.delay(0.23, function()
                            if not _open then panel.Visible = false; wrapper.ClipsDescendants = true end
                        end)
                    end
                end)

                applyColor(true); hexBox.Text = colorToHex(getColor())

                local obj = {}
                function obj:SetValue(c) _h,_s,_v2 = Color3.toHSV(c); applyColor() end
                function obj:GetValue() return getColor() end
                function obj:SetEnabled(e) trig.Active=e; wrapper.BackgroundTransparency=e and 0.03 or 0.5 end
                function obj:SetVisible(v)
                    wrapper.Visible=v
                    if not v and _open then _open=false; panel.Visible=false; wrapper.ClipsDescendants=true; wrapper.Size=UDim2.new(0.96,0,0,44) end
                    recalcHeight()
                end
                function obj:Destroy()
                    if _open then _open=false; panel.Visible=false end
                    wrapper:Destroy(); recalcHeight()
                end
                function obj:UpdateCallback(newCb) cb=newCb end
                return obj
            end

            function SObj:CreateTextBox(labelText, ph, cb, config)
                config=config or {}
                local maxLen=config.MaxLength or 200; local numOnly=config.NumberOnly or false; local realTime=config.RealTime or false
                local f=bf(44)
                local lbl=Instance.new("TextLabel"); lbl.Size=UDim2.new(1,-168,1,0); lbl.Position=UDim2.new(0,14,0,0)
                lbl.BackgroundTransparency=1; lbl.Text=labelText; lbl.TextColor3=C.Text
                lbl.Font=F.Medium; lbl.TextSize=12; lbl.TextXAlignment=Enum.TextXAlignment.Left
                lbl.TextTruncate=Enum.TextTruncate.AtEnd; lbl.Parent=f
                local ih=Instance.new("Frame"); ih.Size=UDim2.new(0,144,0,30); ih.Position=UDim2.new(1,-154,0,7)
                ih.BackgroundColor3=C.InputBg; ih.BackgroundTransparency=0.03; ih.BorderSizePixel=0; ih.Parent=f
                corner(ih,8); local ihStroke=stroke(ih,C.InputStroke,1,0.24)
                local inp=Instance.new("TextBox"); inp.Size=UDim2.new(1,-10,1,0); inp.Position=UDim2.new(0,5,0,0)
                inp.BackgroundTransparency=1; inp.BorderSizePixel=0; inp.Text=""
                inp.PlaceholderText=ph or "Enter text..."; inp.PlaceholderColor3=Color3.fromRGB(80,80,100)
                inp.TextColor3=C.Text; inp.Font=F.Body; inp.TextSize=11; inp.ClearTextOnFocus=false; inp.Parent=ih
                local _filtering=false
                inp:GetPropertyChangedSignal("Text"):Connect(function()
                    if _filtering then return end; _filtering=true
                    local t=inp.Text
                    if numOnly then local cleaned=t:match("^%-?%d*%.?%d*") or ""; if cleaned~=t then t=cleaned; inp.Text=t end end
                    if #t>maxLen then t=t:sub(1,maxLen); inp.Text=t end
                    _filtering=false; if realTime then cb(inp.Text) end
                end)
                inp.Focused:Connect(function() tw(ih,{BackgroundColor3=Color3.fromRGB(28,30,48)},0.14); ihStroke.Color=C.SliderFill; ihStroke.Transparency=0.1 end)
                inp.FocusLost:Connect(function(enterPressed)
                    tw(ih,{BackgroundColor3=C.InputBg},0.14); ihStroke.Color=C.InputStroke; ihStroke.Transparency=0.24
                    if not realTime or enterPressed then cb(inp.Text) end
                end)
                local obj={}
                function obj:SetValue(v) inp.Text=tostring(v) end
                function obj:GetValue() return inp.Text end
                function obj:Clear() inp.Text="" end
                function obj:SetEnabled(e) inp.Editable=e; f.BackgroundTransparency=e and 0.03 or 0.5 end
                function obj:SetVisible(v) f.Visible=v; recalcHeight() end
                function obj:Destroy() f:Destroy(); recalcHeight() end
                function obj:UpdateCallback(newCb) cb=newCb end
                return obj
            end

            function SObj:CreateSeparator()
                local s=Instance.new("Frame"); s.Size=UDim2.new(0.88,0,0,1)
                s.BackgroundColor3=Color3.fromRGB(255,255,255); s.BackgroundTransparency=0.88
                s.BorderSizePixel=0; s.LayoutOrder=no(); s.Parent=SC
                recalcHeight()
                local obj={}
                function obj:SetVisible(v) s.Visible=v; recalcHeight() end
                function obj:Destroy() s:Destroy(); recalcHeight() end
                return obj
            end

            function SObj:CreateProgressBar(text, defVal, maxVal)
                defVal=math.clamp(defVal or 0,0,maxVal or 100); maxVal=maxVal or 100
                local _v=defVal; local f=bf(52)
                local lbl=Instance.new("TextLabel"); lbl.Size=UDim2.new(1,-62,0,18); lbl.Position=UDim2.new(0,14,0,8)
                lbl.BackgroundTransparency=1; lbl.Text=text; lbl.TextColor3=C.Text
                lbl.Font=F.Medium; lbl.TextSize=12; lbl.TextXAlignment=Enum.TextXAlignment.Left
                lbl.TextTruncate=Enum.TextTruncate.AtEnd; lbl.Parent=f
                local pctLbl=Instance.new("TextLabel"); pctLbl.Size=UDim2.new(0,44,0,18); pctLbl.Position=UDim2.new(1,-54,0,8)
                pctLbl.BackgroundTransparency=1; pctLbl.Text=math.floor((defVal/maxVal)*100).."%"
                pctLbl.TextColor3=C.SliderFill; pctLbl.Font=F.Bold; pctLbl.TextSize=11
                pctLbl.TextXAlignment=Enum.TextXAlignment.Right; pctLbl.Parent=f
                local bar=Instance.new("Frame"); bar.Size=UDim2.new(1,-26,0,8); bar.Position=UDim2.new(0,14,0,34)
                bar.BackgroundColor3=C.ProgressBg; bar.BorderSizePixel=0; bar.ClipsDescendants=true; bar.Parent=f
                corner(bar,4)
                local fill=Instance.new("Frame"); fill.Size=UDim2.new(defVal/maxVal,0,1,0)
                fill.BackgroundColor3=C.ProgressFill; fill.BorderSizePixel=0; fill.Parent=bar
                corner(fill,4)
                local obj={}
                function obj:SetValue(v)
                    _v=math.clamp(v,0,maxVal); local pct=_v/maxVal
                    tw(fill,{Size=UDim2.new(pct,0,1,0)},0.3,Enum.EasingStyle.Quart,Enum.EasingDirection.Out)
                    pctLbl.Text=math.floor(pct*100).."%"
                end
                function obj:GetValue() return _v end
                function obj:SetVisible(v) f.Visible=v; recalcHeight() end
                function obj:Destroy() f:Destroy(); recalcHeight() end
                return obj
            end

            function SObj:CreateRadioGroup(config, _legacyDefault, _legacyCb, _legacyMulti)
                if type(config)=="table" and config[1]~=nil then
                    config={Options=config,Default=_legacyDefault or 1,Callback=_legacyCb or function() end,MultiSelect=_legacyMulti or false}
                end
                local options=config.Options or {"Option 1"}; local defaultIndex=config.Default or 1
                local cb=config.Callback or function() end; local multi=config.MultiSelect or false
                local _selected={}; local _buttons={}
                if multi then _selected={}; _selected[defaultIndex]=true else _selected=defaultIndex end
                local rowH=32
                local container=Instance.new("Frame"); container.Size=UDim2.new(0.96,0,0,#options*rowH+8)
                container.BackgroundColor3=C.ComponentBg; container.BackgroundTransparency=0.03
                container.BorderSizePixel=0; container.LayoutOrder=no(); container.Parent=SC
                corner(container,10); stroke(container,Color3.fromRGB(255,255,255),1,0.92)
                for i,option in ipairs(options) do
                    local isSelected=multi and (_selected[i] or false) or (i==defaultIndex)
                    local row=Instance.new("Frame"); row.Size=UDim2.new(0.92,0,0,28)
                    row.Position=UDim2.new(0.04,0,0,4+(i-1)*rowH); row.BackgroundTransparency=1; row.Parent=container
                    local circle=Instance.new("Frame"); circle.Size=UDim2.new(0,18,0,18); circle.Position=UDim2.new(0,0,0,5)
                    circle.BackgroundColor3=isSelected and C.SliderFill or C.ToggleOff; circle.BorderSizePixel=0; circle.Parent=row
                    corner(circle,9)
                    local dot=Instance.new("Frame"); dot.Size=UDim2.new(0,8,0,8); dot.Position=UDim2.new(0,5,0,5)
                    dot.BackgroundColor3=Color3.fromRGB(255,255,255); dot.BorderSizePixel=0; dot.Visible=isSelected; dot.Parent=circle
                    corner(dot,4)
                    local label=Instance.new("TextLabel"); label.Size=UDim2.new(1,-26,1,0); label.Position=UDim2.new(0,24,0,0)
                    label.BackgroundTransparency=1; label.Text=option; label.TextColor3=C.Text
                    label.Font=F.Medium; label.TextSize=12; label.TextXAlignment=Enum.TextXAlignment.Left; label.Parent=row
                    local btn=Instance.new("TextButton"); btn.Size=UDim2.new(1,0,1,0); btn.BackgroundTransparency=1; btn.Text=""; btn.Parent=row
                    btn.MouseButton1Click:Connect(function()
                        if multi then
                            _selected[i]=not _selected[i]; local isSel=_selected[i]
                            tw(_buttons[i].circle,{BackgroundColor3=isSel and C.SliderFill or C.ToggleOff},0.18)
                            _buttons[i].dot.Visible=isSel
                            local selectedOpts={}
                            for idx,sel in pairs(_selected) do if sel then table.insert(selectedOpts,options[idx]) end end
                            cb(_selected,selectedOpts)
                        else
                            _selected=i
                            for j,data in ipairs(_buttons) do
                                local isSel=(j==i)
                                tw(data.circle,{BackgroundColor3=isSel and C.SliderFill or C.ToggleOff},0.18)
                                data.dot.Visible=isSel
                            end
                            cb(i,options[i])
                        end
                    end)
                    table.insert(_buttons,{circle=circle,dot=dot})
                end
                local obj={}
                function obj:SetValue(index)
                    if multi then
                        if type(index)=="table" then _selected=index else _selected[index]=not _selected[index] end
                        for i,data in ipairs(_buttons) do
                            local isSel=_selected[i]; tw(data.circle,{BackgroundColor3=isSel and C.SliderFill or C.ToggleOff},0.18); data.dot.Visible=isSel
                        end
                        local selectedOpts={}
                        for idx,sel in pairs(_selected) do if sel then table.insert(selectedOpts,options[idx]) end end
                        cb(_selected,selectedOpts)
                    else
                        _selected=index
                        for i,data in ipairs(_buttons) do
                            local isSel=(i==index); tw(data.circle,{BackgroundColor3=isSel and C.SliderFill or C.ToggleOff},0.18); data.dot.Visible=isSel
                        end
                        cb(index,options[index])
                    end
                end
                function obj:GetValue() return _selected end
                function obj:SetEnabled(e) container.BackgroundTransparency=e and 0.03 or 0.5 end
                function obj:SetVisible(v) container.Visible=v; recalcHeight() end
                function obj:Destroy() container:Destroy(); recalcHeight() end
                function obj:UpdateCallback(newCb) cb=newCb end
                return obj
            end

            function SObj:Collapse()
                if not _isCollapsed then
                    _isCollapsed=true; tw(ArrowLbl,{Rotation=0},0.24)
                    tw(sectionWrap,{Size=UDim2.new(0.97,0,0,36)},0.26,Enum.EasingStyle.Quart,Enum.EasingDirection.Out)
                    task.delay(0.27,function() SC.Visible=false end)
                end
            end
            function SObj:Expand()
                if _isCollapsed then _isCollapsed=false; SC.Visible=true; tw(ArrowLbl,{Rotation=90},0.24); recalcHeight() end
            end
            function SObj:SetTitle(t) SHdrLbl.Text=t end
            function SObj:Destroy() sectionWrap:Destroy() end
            return SObj
        end

        return TabObj
    end

    CloseBtn.MouseButton1Click:Connect(function() WindowObj:Destroy() end)

    MinBtn.MouseButton1Click:Connect(function()
        if _minimized then doRestore() else doMinimize() end
    end)

    MaxBtn.MouseButton1Click:Connect(function()
        if _minimized then
            _minimized=false; Body.Visible=true; TitleFill.Visible=true; TitleSep.Visible=true
            TitleGlow.Visible=true; ResizeHandle.Visible=true
            MainFrame.ClipsDescendants = false
            tw(MainStroke1,{Thickness=1.5},0.3); tw(MainStroke2,{Thickness=3},0.3); tw(MainStroke3,{Thickness=6},0.3)
        end
        _maximized=not _maximized
        local s=_maximized and winMax or winSize
        local p=_maximized and UDim2.new(0.5,-winMax.X.Offset/2,0.5,-winMax.Y.Offset/2) or winPos
        tw(MainFrame,{Size=s,Position=p},0.32)
    end)

    local _drag=false; local _ds,_fs=nil,nil

    pconn(Titlebar.InputBegan,function(inp)
        if inp.UserInputType==Enum.UserInputType.MouseButton1 or inp.UserInputType==Enum.UserInputType.Touch then
            _drag=true; _ds=inp.Position; _fs=MainFrame.Position
        end
    end)
    pconn(UIS.InputChanged,function(inp)
        if _drag and (inp.UserInputType==Enum.UserInputType.MouseMovement or inp.UserInputType==Enum.UserInputType.Touch) then
            local d=inp.Position-_ds
            MainFrame.Position=UDim2.new(_fs.X.Scale,_fs.X.Offset+d.X,_fs.Y.Scale,_fs.Y.Offset+d.Y)
        end
    end)
    pconn(UIS.InputEnded,function(inp)
        if inp.UserInputType==Enum.UserInputType.MouseButton1 or inp.UserInputType==Enum.UserInputType.Touch then _drag=false end
    end)

    return WindowObj
end

return KreinHub
