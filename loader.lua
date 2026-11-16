-- ═══════════════════════════════════════════════════════════════
--  KREIN LOADER v2.0 — Modern RGB + Game Browser
-- ═══════════════════════════════════════════════════════════════
if _G.__KreinLoaded then return end
_G.__KreinLoaded = true

repeat task.wait() until game:IsLoaded()

local UIS = game:GetService("UserInputService")
local TS  = game:GetService("TweenService")
local MPS = game:GetService("MarketplaceService")
local TPS = game:GetService("TeleportService")
local GS  = game:GetService("GuiService")
local Players = game:GetService("Players")

-- ── KONFIG ──
local BASE    = "https://raw.githubusercontent.com/liptz341/KreinGuiLibrary/refs/heads/main/"
local VERSION = "1.1.0"
local CREATOR = "liptz341"

-- ✏️ TAMBAH GAME DI SINI SAJA — GUI otomatis render
local GAMES = {
    [109983668079237] = { Name = "Steal a Brainrot", Path = "Games/StealABrainrot.lua" },
    -- [1234567890] = { Name = "Game Lain", Path = "Games/GameLain.lua" },
}

local entry = GAMES[game.PlaceId]
local supported = entry ~= nil

-- ── FONTS MODERN ──
local function tryFont(name, fallback)
    local ok, f = pcall(function() return Enum.Font[name] end)
    return (ok and f) or fallback
end
local F = {
    Title  = tryFont("BuilderSansExtraBold", Enum.Font.GothamBlack),
    Header = tryFont("BuilderSansBold",       Enum.Font.GothamBold),
    Body   = tryFont("BuilderSansMedium",     Enum.Font.GothamMedium),
    Reg    = tryFont("BuilderSans",           Enum.Font.Gotham),
    Code   = tryFont("RobotoMono",            Enum.Font.Code),
}

-- ── PALET ──
local C = {
    Bg        = Color3.fromRGB(6, 6, 10),
    BgSoft    = Color3.fromRGB(12, 12, 18),
    SidebarBg = Color3.fromRGB(10, 10, 15),
    CardBg    = Color3.fromRGB(18, 18, 26),
    CardHover = Color3.fromRGB(24, 24, 36),
    Border    = Color3.fromRGB(45, 45, 65),
    Text      = Color3.fromRGB(240, 240, 250),
    TextSub   = Color3.fromRGB(130, 130, 150),
    TextDim   = Color3.fromRGB(80, 80, 100),
    Accent    = Color3.fromRGB(110, 155, 255),
    Success   = Color3.fromRGB(68, 200, 100),
    Danger    = Color3.fromRGB(220, 70, 70),
}

-- ── HELPERS ──
local function corner(parent, r)
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, r or 10)
    c.Parent = parent
    return c
end
local function stroke(parent, color, thick, trans)
    local s = Instance.new("UIStroke")
    s.Color = color or C.Border
    s.Thickness = thick or 1
    s.Transparency = trans or 0.7
    s.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    s.Parent = parent
    return s
end
local function tw(obj, props, dur, style, dir)
    TS:Create(obj, TweenInfo.new(dur or 0.3, style or Enum.EasingStyle.Quart, dir or Enum.EasingDirection.Out), props):Play()
end

-- ── PARENT & GUI ──
local parent = (gethui and gethui()) or game:GetService("CoreGui")
local old = parent:FindFirstChild("KreinLoader")
if old then old:Destroy() end

local gui = Instance.new("ScreenGui")
gui.Name = "KreinLoader"
gui.ResetOnSpawn = false
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
gui.DisplayOrder = 999
gui.Parent = parent

local backdrop = Instance.new("Frame")
backdrop.Size = UDim2.new(1, 0, 1, 0)
backdrop.BackgroundColor3 = Color3.new(0, 0, 0)
backdrop.BackgroundTransparency = 1
backdrop.BorderSizePixel = 0
backdrop.ZIndex = 1
backdrop.Parent = gui
tw(backdrop, {BackgroundTransparency = 0.55}, 0.4)

local rgbRunning = true

-- ═══════════════════════════════════════════════════════════════
--  LOAD LIBRARY FUNCTION
-- ═══════════════════════════════════════════════════════════════
local function loadLibrary(fromGUI, callback)
    task.spawn(function()
        if fromGUI then fromGUI.Text = "Loading..." end
        local ok, KreinHub = pcall(function()
            local src = game:HttpGet(BASE .. "guilibrary.lua")
            local fn = loadstring(src)
            if not fn then error("Syntax error") end
            return fn()
        end)
        if not ok or type(KreinHub) ~= "table" or not KreinHub.CreateWindow then
            warn("[Krein] Load failed: " .. tostring(KreinHub))
            if fromGUI then fromGUI.Text = "Failed"; fromGUI.TextColor3 = C.Danger end
            return
        end
        local Window = KreinHub:CreateWindow({
            Title    = "Krein Hub",
            Subtitle = supported and entry.Name or "Universal",
            Size     = UDim2.new(0, 680, 0, 460),
        })
        if getgenv then
            getgenv().KreinWindow  = Window
            getgenv().KreinLibrary = KreinHub
        else
            _G.KreinWindow  = Window
            _G.KreinLibrary = KreinHub
        end
        if supported then
            task.wait(0.1)
            local ok2, err = pcall(function()
                local src = game:HttpGet(BASE .. entry.Path)
                local fn = loadstring(src)
                if not fn then error("Syntax error di " .. entry.Path) end
                fn()
            end)
            if not ok2 then warn("[Krein] Game script error: " .. tostring(err)) end
        end
        if callback then callback(KreinHub, Window) end
    end)
end

local function fadeOutLoader()
    rgbRunning = false
    tw(backdrop, {BackgroundTransparency = 1}, 0.35)
    for _, c in ipairs(gui:GetDescendants()) do
        if c:IsA("Frame") or c:IsA("TextButton") or c:IsA("ImageLabel") then
            pcall(function() tw(c, {BackgroundTransparency = 1}, 0.3) end)
        end
        if c:IsA("TextLabel") or c:IsA("TextBox") then
            pcall(function() tw(c, {TextTransparency = 1}, 0.3) end)
        end
        if c:IsA("UIStroke") then
            pcall(function() tw(c, {Transparency = 1}, 0.3) end)
        end
    end
    task.delay(0.4, function()
        if gui and gui.Parent then gui:Destroy() end
    end)
end

-- ═══════════════════════════════════════════════════════════════
--  MODE A: GAME SUPPORTED → Small "Load Now" Card
-- ═══════════════════════════════════════════════════════════════
local function buildSupportedCard()
    local Card = Instance.new("Frame")
    Card.Size = UDim2.new(0, 340, 0, 0)
    Card.AutomaticSize = Enum.AutomaticSize.Y
    Card.AnchorPoint = Vector2.new(0.5, 0.5)
    Card.Position = UDim2.new(0.5, 0, 0.5, 0)
    Card.BackgroundColor3 = C.Bg
    Card.BackgroundTransparency = 1
    Card.BorderSizePixel = 0
    Card.ZIndex = 2
    Card.Parent = gui
    corner(Card, 16)

    local s1 = stroke(Card, C.Accent, 1.5, 0.4)
    local s2 = stroke(Card, C.Accent, 6, 0.8)

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

    local Title = Instance.new("TextLabel")
    Title.Size = UDim2.new(1, 0, 0, 44)
    Title.BackgroundTransparency = 1
    Title.Text = "KreinLoad"
    Title.Font = F.Title
    Title.TextSize = 34
    Title.TextColor3 = Color3.new(1,1,1)
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

    local Sub = Instance.new("TextLabel")
    Sub.Size = UDim2.new(1, 0, 0, 16)
    Sub.BackgroundTransparency = 1
    Sub.Text = "Detected: " .. entry.Name
    Sub.TextColor3 = C.TextSub
    Sub.Font = F.Reg
    Sub.TextSize = 12
    Sub.TextTransparency = 1
    Sub.LayoutOrder = 2
    Sub.ZIndex = 3
    Sub.Parent = Card

    local Btn = Instance.new("TextButton")
    Btn.Size = UDim2.new(1, 0, 0, 46)
    Btn.BackgroundColor3 = C.CardBg
    Btn.BackgroundTransparency = 1
    Btn.BorderSizePixel = 0
    Btn.Text = "Load Now!"
    Btn.TextColor3 = Color3.new(1,1,1)
    Btn.Font = F.Header
    Btn.TextSize = 15
    Btn.TextTransparency = 1
    Btn.AutoButtonColor = false
    Btn.LayoutOrder = 3
    Btn.ZIndex = 3
    Btn.Parent = Card
    corner(Btn, 10)
    local sBtn = stroke(Btn, C.Accent, 1.5, 0.2)

    local CardScale = Instance.new("UIScale")
    CardScale.Scale = 0.85
    CardScale.Parent = Card

    -- RGB loop
    task.spawn(function()
        local hue, gradOff, pulse = 0, 0, 0
        while rgbRunning and Card.Parent do
            hue = (hue + 0.008) % 1
            gradOff = (gradOff + 0.004) % 1
            pulse = (pulse + 0.05) % (math.pi * 2)
            local col = Color3.fromHSV(hue, 0.85, 1)
            s1.Color = col; s2.Color = col; sBtn.Color = col
            s2.Transparency = 0.72 + (math.sin(pulse) * 0.5 + 0.5) * 0.15
            TitleGrad.Offset = Vector2.new(gradOff, 0)
            task.wait(0.03)
        end
    end)

    -- Fade in
    tw(Card, {BackgroundTransparency = 0.02}, 0.5, Enum.EasingStyle.Back)
    tw(CardScale, {Scale = 1}, 0.5, Enum.EasingStyle.Back)
    task.delay(0.25, function()
        for _, el in ipairs({Title, Sub, Btn}) do
            if el and el.Parent then tw(el, {TextTransparency = 0}, 0.35) end
        end
    end)

    Btn.MouseEnter:Connect(function()
        if Btn.Text == "Loading..." then return end
        tw(Btn, {BackgroundColor3 = C.CardHover}, 0.15)
    end)
    Btn.MouseLeave:Connect(function()
        if Btn.Text == "Loading..." then return end
        tw(Btn, {BackgroundColor3 = C.CardBg}, 0.15)
    end)

    Btn.MouseButton1Click:Connect(function()
        if Btn.Text == "Loading..." then return end
        Btn.Text = "Loading..."
        loadLibrary(Btn, function(KreinHub)
            task.wait(0.2)
            fadeOutLoader()
            task.delay(0.6, function()
                KreinHub:Notify("Krein Hub", "Berhasil dimuat!", 3, "success")
            end)
        end)
    end)
end

-- ═══════════════════════════════════════════════════════════════
--  MODE B: GAME UNSUPPORTED → Full Menu Window
-- ═══════════════════════════════════════════════════════════════
local function buildMenuWindow()
    local W = Instance.new("Frame")
    W.Name = "KreinMenu"
    W.Size = UDim2.new(0, 720, 0, 500)
    W.AnchorPoint = Vector2.new(0.5, 0.5)
    W.Position = UDim2.new(0.5, 0, 0.5, 0)
    W.BackgroundColor3 = C.Bg
    W.BackgroundTransparency = 1
    W.BorderSizePixel = 0
    W.ClipsDescendants = true
    W.ZIndex = 2
    W.Parent = gui
    corner(W, 16)

    if UIS.TouchEnabled and not UIS.KeyboardEnabled then
        local vp = workspace.CurrentCamera.ViewportSize
        if vp.X < 720 then W.Size = UDim2.new(1, -20, 1, -120) end
    end

    local s1 = stroke(W, C.Accent, 1.5, 0.4)
    local s2 = stroke(W, C.Accent, 6, 0.8)

    local hue = 0
    task.spawn(function()
        while rgbRunning and W.Parent do
            hue = (hue + 0.008) % 1
            local col = Color3.fromHSV(hue, 0.85, 1)
            s1.Color = col; s2.Color = col
            s2.Transparency = 0.72 + (math.sin(tick() * 2) * 0.5 + 0.5) * 0.15
            task.wait(0.03)
        end
    end)

    tw(W, {BackgroundTransparency = 0.04}, 0.4)

    -- ── SIDEBAR ──
    local SB = Instance.new("Frame")
    SB.Size = UDim2.new(0, 180, 1, 0)
    SB.BackgroundColor3 = C.SidebarBg
    SB.BackgroundTransparency = 0.02
    SB.BorderSizePixel = 0
    SB.Parent = W
    corner(SB, 16)

    local SBCover = Instance.new("Frame")
    SBCover.Size = UDim2.new(0, 12, 1, 0)
    SBCover.Position = UDim2.new(1, -12, 0, 0)
    SBCover.BackgroundColor3 = C.SidebarBg
    SBCover.BackgroundTransparency = 0.02
    SBCover.BorderSizePixel = 0
    SBCover.Parent = SB

    local SBSep = Instance.new("Frame")
    SBSep.Size = UDim2.new(0, 1, 1, -30)
    SBSep.Position = UDim2.new(1, 0, 0, 15)
    SBSep.BackgroundColor3 = C.Border
    SBSep.BackgroundTransparency = 0.6
    SBSep.BorderSizePixel = 0
    SBSep.Parent = SB

    -- Title (gradient RGB)
    local Title = Instance.new("TextLabel")
    Title.Size = UDim2.new(1, 0, 0, 60)
    Title.BackgroundTransparency = 1
    Title.Text = "KreinLoad"
    Title.Font = F.Title
    Title.TextSize = 24
    Title.TextColor3 = Color3.new(1,1,1)
    Title.Parent = SB

    local TGrad = Instance.new("UIGradient")
    TGrad.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 90, 90)),
        ColorSequenceKeypoint.new(0.25, Color3.fromRGB(255, 230, 90)),
        ColorSequenceKeypoint.new(0.50, Color3.fromRGB(90, 255, 120)),
        ColorSequenceKeypoint.new(0.75, Color3.fromRGB(90, 190, 255)),
        ColorSequenceKeypoint.new(1.00, Color3.fromRGB(255, 90, 230)),
    })
    TGrad.Parent = Title

    task.spawn(function()
        local o = 0
        while rgbRunning and Title.Parent do
            o = (o + 0.004) % 1
            TGrad.Offset = Vector2.new(o, 0)
            task.wait(0.03)
        end
    end)

    -- Menu buttons holder
    local Menu = Instance.new("Frame")
    Menu.Size = UDim2.new(1, -16, 1, -140)
    Menu.Position = UDim2.new(0, 8, 0, 60)
    Menu.BackgroundTransparency = 1
    Menu.Parent = SB

    local MenuL = Instance.new("UIListLayout")
    MenuL.Padding = UDim.new(0, 6)
    MenuL.SortOrder = Enum.SortOrder.LayoutOrder
    MenuL.Parent = Menu

    -- Bottom "Open Library" button
    local OpenBtn = Instance.new("TextButton")
    OpenBtn.Size = UDim2.new(1, -16, 0, 40)
    OpenBtn.Position = UDim2.new(0, 8, 1, -50)
    OpenBtn.BackgroundColor3 = C.CardBg
    OpenBtn.BackgroundTransparency = 0.05
    OpenBtn.BorderSizePixel = 0
    OpenBtn.Text = "🚀  Open Library"
    OpenBtn.TextColor3 = C.Text
    OpenBtn.Font = F.Header
    OpenBtn.TextSize = 12
    OpenBtn.AutoButtonColor = false
    OpenBtn.Parent = SB
    corner(OpenBtn, 10)
    stroke(OpenBtn, C.Success, 1.5, 0.4)

    -- ── CONTENT ──
    local Content = Instance.new("Frame")
    Content.Size = UDim2.new(1, -180, 1, 0)
    Content.Position = UDim2.new(0, 180, 0, 0)
    Content.BackgroundTransparency = 1
    Content.ClipsDescendants = true
    Content.Parent = W

    local Pages = Instance.new("Frame")
    Pages.Size = UDim2.new(1, 0, 1, 0)
    Pages.BackgroundTransparency = 1
    Pages.Parent = Content

    -- ── PAGE: GAMES ──
    local GamesPage = Instance.new("ScrollingFrame")
    GamesPage.Size = UDim2.new(1, 0, 1, 0)
    GamesPage.BackgroundTransparency = 1
    GamesPage.BorderSizePixel = 0
    GamesPage.ScrollBarThickness = 2
    GamesPage.ScrollBarImageColor3 = C.Border
    GamesPage.ScrollingDirection = Enum.ScrollingDirection.Y
    GamesPage.AutomaticCanvasSize = Enum.AutomaticSize.Y
    GamesPage.CanvasSize = UDim2.new(0, 0, 0, 0)
    GamesPage.Selectable = false
    GamesPage.Parent = Pages

    local GL = Instance.new("UIListLayout")
    GL.Padding = UDim.new(0, 10)
    GL.SortOrder = Enum.SortOrder.LayoutOrder
    GL.HorizontalAlignment = Enum.HorizontalAlignment.Center
    GL.Parent = GamesPage

    local GPad = Instance.new("UIPadding")
    GPad.PaddingTop = UDim.new(0, 20)
    GPad.PaddingBottom = UDim.new(0, 20)
    GPad.Parent = GamesPage

    local GHeader = Instance.new("TextLabel")
    GHeader.Size = UDim2.new(1, -40, 0, 34)
    GHeader.BackgroundTransparency = 1
    GHeader.Text = "🎮 Game List"
    GHeader.TextColor3 = C.Text
    GHeader.Font = F.Title
    GHeader.TextSize = 22
    GHeader.TextXAlignment = Enum.TextXAlignment.Left
    GHeader.LayoutOrder = 0
    GHeader.Parent = GamesPage

    local GSub = Instance.new("TextLabel")
    GSub.Size = UDim2.new(1, -40, 0, 22)
    GSub.BackgroundTransparency = 1
    GSub.Text = "Pilih game untuk teleport. Game saat ini tidak didukung."
    GSub.TextColor3 = C.TextSub
    GSub.Font = F.Reg
    GSub.TextSize = 12
    GSub.TextXAlignment = Enum.TextXAlignment.Left
    GSub.LayoutOrder = 1
    GSub.Parent = GamesPage

    -- Game card renderer
    local function makeGameCard(placeId, data, order)
        local Card = Instance.new("Frame")
        Card.Size = UDim2.new(1, -40, 0, 92)
        Card.BackgroundColor3 = C.CardBg
        Card.BackgroundTransparency = 0.05
        Card.BorderSizePixel = 0
        Card.LayoutOrder = order
        Card.Parent = GamesPage
        corner(Card, 12)
        local cStk = stroke(Card, C.Border, 1, 0.5)

        -- Icon
        local IconF = Instance.new("Frame")
        IconF.Size = UDim2.new(0, 68, 0, 68)
        IconF.Position = UDim2.new(0, 12, 0.5, -34)
        IconF.BackgroundColor3 = C.BgSoft
        IconF.BorderSizePixel = 0
        IconF.ClipsDescendants = true
        IconF.Parent = Card
        corner(IconF, 10)
        local IconStk = stroke(IconF, C.Border, 1, 0.3)

        local Icon = Instance.new("ImageLabel")
        Icon.Size = UDim2.new(1, 0, 1, 0)
        Icon.BackgroundTransparency = 1
        Icon.Image = "rbxthumb://type=GameIcon&id=" .. placeId .. "&w=150&h=150"
        Icon.Parent = IconF

        -- Name
        local Name = Instance.new("TextLabel")
        Name.Size = UDim2.new(1, -240, 0, 22)
        Name.Position = UDim2.new(0, 92, 0, 22)
        Name.BackgroundTransparency = 1
        Name.Text = data.Name
        Name.TextColor3 = C.Text
        Name.Font = F.Header
        Name.TextSize = 15
        Name.TextXAlignment = Enum.TextXAlignment.Left
        Name.TextTruncate = Enum.TextTruncate.AtEnd
        Name.Parent = Card

        -- PlaceId
        local Id = Instance.new("TextLabel")
        Id.Size = UDim2.new(1, -240, 0, 16)
        Id.Position = UDim2.new(0, 92, 0, 46)
        Id.BackgroundTransparency = 1
        Id.Text = "PlaceId: " .. placeId
        Id.TextColor3 = C.TextSub
        Id.Font = F.Code
        Id.TextSize = 11
        Id.TextXAlignment = Enum.TextXAlignment.Left
        Id.Parent = Card

        -- Teleport button
        local Tp = Instance.new("TextButton")
        Tp.Size = UDim2.new(0, 110, 0, 38)
        Tp.Position = UDim2.new(1, -122, 0.5, -19)
        Tp.BackgroundColor3 = C.CardBg
        Tp.BorderSizePixel = 0
        Tp.Text = "→  Teleport"
        Tp.TextColor3 = C.Text
        Tp.Font = F.Header
        Tp.TextSize = 12
        Tp.AutoButtonColor = false
        Tp.Parent = Card
        corner(Tp, 9)
        local tStk = stroke(Tp, C.Accent, 1.5, 0.2)

        Card.MouseEnter:Connect(function()
            tw(Card, {BackgroundColor3 = C.CardHover, BackgroundTransparency = 0.02}, 0.15)
            tw(cStk, {Transparency = 0.2}, 0.15)
        end)
        Card.MouseLeave:Connect(function()
            tw(Card, {BackgroundColor3 = C.CardBg, BackgroundTransparency = 0.05}, 0.15)
            tw(cStk, {Transparency = 0.5}, 0.15)
        end)
        Tp.MouseEnter:Connect(function()
            tw(Tp, {BackgroundColor3 = C.Accent}, 0.15)
            tw(tStk, {Transparency = 0}, 0.15)
        end)
        Tp.MouseLeave:Connect(function()
            tw(Tp, {BackgroundColor3 = C.CardBg}, 0.15)
            tw(tStk, {Transparency = 0.2}, 0.15)
        end)

        Tp.MouseButton1Click:Connect(function()
            if placeId == game.PlaceId then
                Tp.Text = "Same Game!"
                task.delay(1.5, function() if Tp and Tp.Parent then Tp.Text = "→  Teleport" end end)
                return
            end
            Tp.Text = "Teleporting..."
            Tp.TextColor3 = C.TextSub
            local ok = pcall(function() TPS:Teleport(placeId, Players.LocalPlayer) end)
            if not ok then
                pcall(function() GS:OpenUrl("roblox://placeId=" .. placeId) end)
                Tp.Text = "Opening..."
            end
            task.delay(3, function()
                if Tp and Tp.Parent then Tp.Text = "→  Teleport"; Tp.TextColor3 = C.Text end
            end)
        end)
    end

    local idx = 2
    for pid, gdata in pairs(GAMES) do
        makeGameCard(pid, gdata, idx)
        idx = idx + 1
    end

    if idx == 2 then
        -- No games registered
        local Empty = Instance.new("TextLabel")
        Empty.Size = UDim2.new(1, -40, 0, 80)
        Empty.BackgroundColor3 = C.CardBg
        Empty.BackgroundTransparency = 0.5
        Empty.Text = "Belum ada game terdaftar di registry."
        Empty.TextColor3 = C.TextSub
        Empty.Font = F.Reg
        Empty.TextSize = 12
        Empty.LayoutOrder = 2
        Empty.Parent = GamesPage
        corner(Empty, 10)
    end

    -- ── PAGE: INFO ──
    local InfoPage = Instance.new("Frame")
    InfoPage.Size = UDim2.new(1, 0, 1, 0)
    InfoPage.BackgroundTransparency = 1
    InfoPage.Visible = false
    InfoPage.Parent = Pages

    local IPad = Instance.new("UIPadding")
    IPad.PaddingTop = UDim.new(0, 24)
    IPad.PaddingLeft = UDim.new(0, 30)
    IPad.PaddingRight = UDim.new(0, 30)
    IPad.Parent = InfoPage

    local IL = Instance.new("UIListLayout")
    IL.Padding = UDim.new(0, 12)
    IL.Parent = InfoPage

    local IHeader = Instance.new("TextLabel")
    IHeader.Size = UDim2.new(1, 0, 0, 32)
    IHeader.BackgroundTransparency = 1
    IHeader.Text = "ℹ️ Krein GUI Library"
    IHeader.TextColor3 = C.Text
    IHeader.Font = F.Title
    IHeader.TextSize = 22
    IHeader.TextXAlignment = Enum.TextXAlignment.Left
    IHeader.LayoutOrder = 0
    IHeader.Parent = InfoPage

    local function infoRow(order, label, value, color)
        local row = Instance.new("Frame")
        row.Size = UDim2.new(1, 0, 0, 22)
        row.BackgroundTransparency = 1
        row.LayoutOrder = order
        row.Parent = InfoPage
        local l = Instance.new("TextLabel")
        l.Size = UDim2.new(0, 130, 1, 0)
        l.BackgroundTransparency = 1
        l.Text = label
        l.TextColor3 = C.TextSub
        l.Font = F.Reg
        l.TextSize = 12
        l.TextXAlignment = Enum.TextXAlignment.Left
        l.Parent = row
        local v = Instance.new("TextLabel")
        v.Size = UDim2.new(1, -130, 1, 0)
        v.Position = UDim2.new(0, 130, 0, 0)
        v.BackgroundTransparency = 1
        v.Text = value
        v.TextColor3 = color or C.Text
        v.Font = F.Header
        v.TextSize = 12
        v.TextXAlignment = Enum.TextXAlignment.Left
        v.Parent = row
    end

    local totalGames = 0
    for _ in pairs(GAMES) do totalGames = totalGames + 1 end

    infoRow(1, "Version",     "v" .. VERSION, C.Accent)
    infoRow(2, "Creator",     CREATOR)
    infoRow(3, "License",     "MIT")
    infoRow(4, "Total Games", tostring(totalGames), C.Success)

    local Desc = Instance.new("TextLabel")
    Desc.Size = UDim2.new(1, 0, 0, 80)
    Desc.BackgroundTransparency = 1
    Desc.Text = "Krein GUI Library adalah UI library premium untuk Roblox dengan animasi halus, 12+ komponen interaktif, dan sistem notifikasi modern. Dibuat dari nol menggunakan Roblox Lua API murni."
    Desc.TextColor3 = C.TextSub
    Desc.Font = F.Reg
    Desc.TextSize = 12
    Desc.TextXAlignment = Enum.TextXAlignment.Left
    Desc.TextYAlignment = Enum.TextYAlignment.Top
    Desc.TextWrapped = true
    Desc.LayoutOrder = 5
    Desc.Parent = InfoPage

    -- Current game status
    local StatusF = Instance.new("Frame")
    StatusF.Size = UDim2.new(1, 0, 0, 80)
    StatusF.BackgroundColor3 = C.CardBg
    StatusF.BackgroundTransparency = 0.05
    StatusF.BorderSizePixel = 0
    StatusF.LayoutOrder = 6
    StatusF.Parent = InfoPage
    corner(StatusF, 10)
    stroke(StatusF, C.Danger, 1, 0.4)

    local stTitle = Instance.new("TextLabel")
    stTitle.Size = UDim2.new(1, -20, 0, 18)
    stTitle.Position = UDim2.new(0, 10, 0, 8)
    stTitle.BackgroundTransparency = 1
    stTitle.Text = "⚠ Game saat ini tidak didukung"
    stTitle.TextColor3 = C.Danger
    stTitle.Font = F.Header
    stTitle.TextSize = 12
    stTitle.TextXAlignment = Enum.TextXAlignment.Left
    stTitle.Parent = StatusF

    local gameName = "Unknown"
    pcall(function()
        local ok, info = pcall(function() return MPS:GetProductInfo(game.PlaceId) end)
        if ok and info and info.Name then gameName = info.Name end
    end)

    local stName = Instance.new("TextLabel")
    stName.Size = UDim2.new(1, -20, 0, 18)
    stName.Position = UDim2.new(0, 10, 0, 30)
    stName.BackgroundTransparency = 1
    stName.Text = "Game: " .. gameName
    stName.TextColor3 = C.Text
    stName.Font = F.Header
    stName.TextSize = 11
    stName.TextXAlignment = Enum.TextXAlignment.Left
    stName.Parent = StatusF

    local stId = Instance.new("TextLabel")
    stId.Size = UDim2.new(1, -20, 0, 16)
    stId.Position = UDim2.new(0, 10, 0, 52)
    stId.BackgroundTransparency = 1
    stId.Text = "PlaceId: " .. tostring(game.PlaceId)
    stId.TextColor3 = C.TextSub
    stId.Font = F.Code
    stId.TextSize = 10
    stId.TextXAlignment = Enum.TextXAlignment.Left
    stId.Parent = StatusF

    -- ── MENU SWITCHER ──
    local menuBtns = {}
    local currentPage = "games"

    local function switchPage(name)
        if currentPage == name then return end
        currentPage = name
        for n, b in pairs(menuBtns) do
            local active = (n == name)
            tw(b, {BackgroundColor3 = active and C.CardBg or C.SidebarBg, BackgroundTransparency = active and 0.02 or 1}, 0.2)
            local txt = b:FindFirstChild("TextLabel")
            if txt then tw(txt, {TextColor3 = active and C.Text or C.TextSub}, 0.2) end
            local ind = b:FindFirstChild("Indicator")
            if ind then tw(ind, {BackgroundTransparency = active and 0 or 1}, 0.2) end
        end
        GamesPage.Visible = (name == "games")
        InfoPage.Visible  = (name == "info")
    end

    local function createMenuBtn(name, label, icon, order)
        local B = Instance.new("TextButton")
        B.Size = UDim2.new(1, 0, 0, 42)
        B.BackgroundColor3 = name == "games" and C.CardBg or C.SidebarBg
        B.BackgroundTransparency = name == "games" and 0.02 or 1
        B.BorderSizePixel = 0
        B.Text = ""
        B.AutoButtonColor = false
        B.LayoutOrder = order
        B.Parent = Menu
        corner(B, 10)

        local T = Instance.new("TextLabel")
        T.Name = "TextLabel"
        T.Size = UDim2.new(1, -20, 1, 0)
        T.Position = UDim2.new(0, 14, 0, 0)
        T.BackgroundTransparency = 1
        T.Text = icon .. "  " .. label
        T.TextColor3 = name == "games" and C.Text or C.TextSub
        T.Font = F.Header
        T.TextSize = 13
        T.TextXAlignment = Enum.TextXAlignment.Left
        T.Parent = B

        local Ind = Instance.new("Frame")
        Ind.Name = "Indicator"
        Ind.Size = UDim2.new(0, 3, 0, 22)
        Ind.Position = UDim2.new(0, 0, 0.5, -11)
        Ind.BackgroundColor3 = C.Accent
        Ind.BackgroundTransparency = name == "games" and 0 or 1
        Ind.BorderSizePixel = 0
        Ind.Parent = B
        corner(Ind, 2)

        B.MouseEnter:Connect(function()
            if currentPage ~= name then
                tw(B, {BackgroundColor3 = C.CardBg, BackgroundTransparency = 0.5}, 0.15)
                tw(T, {TextColor3 = C.Text}, 0.15)
            end
        end)
        B.MouseLeave:Connect(function()
            if currentPage ~= name then
                tw(B, {BackgroundColor3 = C.SidebarBg, BackgroundTransparency = 1}, 0.15)
                tw(T, {TextColor3 = C.TextSub}, 0.15)
            end
        end)
        B.MouseButton1Click:Connect(function() switchPage(name) end)

        menuBtns[name] = B
        return B
    end

    createMenuBtn("games", "Games", "🎮", 1)
    createMenuBtn("info",  "Info",  "ℹ️", 2)

    -- Open Library button behavior
    OpenBtn.MouseEnter:Connect(function()
        tw(OpenBtn, {BackgroundColor3 = C.CardHover}, 0.15)
    end)
    OpenBtn.MouseLeave:Connect(function()
        tw(OpenBtn, {BackgroundColor3 = C.CardBg}, 0.15)
    end)
    OpenBtn.MouseButton1Click:Connect(function()
        if OpenBtn.Text == "Loading..." then return end
        OpenBtn.Text = "Loading..."
        loadLibrary(OpenBtn, function(KreinHub)
            task.wait(0.2)
            fadeOutLoader()
            task.delay(0.6, function()
                KreinHub:Notify("Krein Hub", "Library dibuka tanpa fitur game.", 3, "info")
            end)
        end)
    end)
end

-- ═══════════════════════════════════════════════════════════════
--  DISPATCH
-- ═══════════════════════════════════════════════════════════════
if supported then
    buildSupportedCard()
else
    buildMenuWindow()
end
