-- ═══════════════════════════════════════════════════════════════
--  KREIN LOADER v3.1 — Premium Animated UI, Small Size & Fixed Icons
-- ═══════════════════════════════════════════════════════════════
repeat task.wait() until game:IsLoaded()

local UIS = game:GetService("UserInputService")
local TS  = game:GetService("TweenService")
local MPS = game:GetService("MarketplaceService")
local Players = game:GetService("Players")

-- ── KONFIG ──
local BASE    = "https://raw.githubusercontent.com/liptz341/KreinGuiLibrary/refs/heads/main/"
local VERSION = "1.4.1"
local CREATOR = "liptz341"

-- ✏️ TAMBAH GAME DI SINI (PlaceId = "Path/File.lua")
local GAMES = {
    [123974602339071] = "Games/StealABrainrot.lua",
    [2753915549]      = "Games/BloxFruits.lua",
    [920587237]       = "Games/AdoptMe.lua",
    [6516141723]      = "Games/Doors.lua",
    [286090429]       = "Games/Arsenal.lua",
    [3260590327]      = "Games/PetSim99.lua",
}

local currentPath = GAMES[game.PlaceId]
local supported = currentPath ~= nil

-- ── HELPER: FETCH INFO & ICON (ANTI GAGAL) ──
local infoCache = {}
local function getGameInfo(placeId)
    if infoCache[placeId] then return infoCache[placeId] end
    local success, info = pcall(function()
        return MPS:GetProductInfo(placeId)
    end)
    if success and info then
        infoCache[placeId] = info
        return info
    end
    return nil
end

local function getGameIcon(placeId)
    local info = getGameInfo(placeId)
    if info then
        -- Metode 1: Pakai Asset ID langsung (100% muncul)
        if info.IconImageAssetId and info.IconImageAssetId ~= 0 then
            return "rbxassetid://" .. tostring(info.IconImageAssetId)
        end
        -- Metode 2: Fallback ke rbxthumb
        return "rbxthumb://type=GameIcon&id=" .. tostring(info.UniverseId or placeId) .. "&w=150&h=150"
    end
    return "rbxassetid://0" -- Placeholder kosong
end

-- ── FONTS ──
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

-- ── PALET PREMIUM ──
local C = {
    Bg        = Color3.fromRGB(10, 10, 14),
    BgSoft    = Color3.fromRGB(16, 16, 24),
    CardBg    = Color3.fromRGB(22, 22, 32),
    CardHover = Color3.fromRGB(30, 30, 44),
    Border    = Color3.fromRGB(55, 55, 75),
    Text      = Color3.fromRGB(245, 245, 255),
    TextSub   = Color3.fromRGB(140, 140, 160),
    Accent    = Color3.fromRGB(120, 160, 255),
    Success   = Color3.fromRGB(70, 210, 100),
    Danger    = Color3.fromRGB(230, 75, 75),
}

-- ── HELPERS ──
local function corner(parent, r)
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, r or 12)
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

-- ── PARENT & GUI (TANPA BACKDROP) ──
local parent = (gethui and gethui()) or game:GetService("CoreGui")
local old = parent:FindFirstChild("KreinLoader")
if old then old:Destroy() end

local gui = Instance.new("ScreenGui")
gui.Name = "KreinLoader"
gui.ResetOnSpawn = false
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
gui.DisplayOrder = 999
gui.Parent = parent

local rgbRunning = true

-- ═══════════════════════════════════════════════════════════════
--  CORE FUNCTIONS
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
        
        local info = getGameInfo(game.PlaceId)
        local gameName = info and info.Name or "Universal"

        local Window = KreinHub:CreateWindow({
            Title    = "Krein Hub",
            Subtitle = supported and gameName or "Universal",
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
                local src = game:HttpGet(BASE .. currentPath)
                local fn = loadstring(src)
                if not fn then error("Syntax error di " .. currentPath) end
                fn()
            end)
            if not ok2 then warn("[Krein] Game script error: " .. tostring(err)) end
        end
        if callback then callback(KreinHub, Window) end
    end)
end

local function fadeOutAndDestroy()
    rgbRunning = false
    for _, c in ipairs(gui:GetDescendants()) do
        if c:IsA("Frame") or c:IsA("TextButton") or c:IsA("ImageLabel") then
            pcall(function() tw(c, {BackgroundTransparency = 1, Size = UDim2.new(0,0,0,0)}, 0.3, Enum.EasingStyle.Back, Enum.EasingDirection.In) end)
        end
        if c:IsA("TextLabel") or c:IsA("TextBox") then
            pcall(function() tw(c, {TextTransparency = 1}, 0.2) end)
        end
        if c:IsA("UIStroke") then
            pcall(function() tw(c, {Transparency = 1}, 0.2) end)
        end
    end
    task.delay(0.4, function()
        if gui and gui.Parent then gui:Destroy() end
    end)
end

local function animateClick(btn)
    local origSize = btn.Size
    tw(btn, {Size = origSize - UDim2.new(0, 4, 0, 4)}, 0.05)
    task.delay(0.05, function() tw(btn, {Size = origSize}, 0.1, Enum.EasingStyle.Back) end)
end

local function createCloseBtn(parentFrame)
    local CloseBtn = Instance.new("TextButton")
    CloseBtn.Size = UDim2.new(0, 26, 0, 26)
    CloseBtn.Position = UDim2.new(1, -34, 0, 10)
    CloseBtn.BackgroundColor3 = C.CardBg
    CloseBtn.BackgroundTransparency = 0.5
    CloseBtn.BorderSizePixel = 0
    CloseBtn.Text = "✕"
    CloseBtn.TextColor3 = C.TextSub
    CloseBtn.Font = F.Header
    CloseBtn.TextSize = 13
    CloseBtn.AutoButtonColor = false
    CloseBtn.ZIndex = 10
    CloseBtn.Parent = parentFrame
    corner(CloseBtn, 8)
    
    CloseBtn.MouseEnter:Connect(function()
        tw(CloseBtn, {BackgroundColor3 = C.Danger, BackgroundTransparency = 0, TextColor3 = Color3.new(1,1,1)}, 0.15)
    end)
    CloseBtn.MouseLeave:Connect(function()
        tw(CloseBtn, {BackgroundColor3 = C.CardBg, BackgroundTransparency = 0.5, TextColor3 = C.TextSub}, 0.15)
    end)
    CloseBtn.MouseButton1Click:Connect(function()
        fadeOutAndDestroy()
    end)
    return CloseBtn
end

-- ═══════════════════════════════════════════════════════════════
--  MODE A: GAME SUPPORTED → Small Card
-- ═══════════════════════════════════════════════════════════════
local function buildSupportedCard()
    local info = getGameInfo(game.PlaceId)
    local gameName = info and info.Name or "Detected Game"

    local Card = Instance.new("Frame")
    Card.Size = UDim2.new(0, 280, 0, 0)
    Card.AutomaticSize = Enum.AutomaticSize.Y
    Card.AnchorPoint = Vector2.new(0.5, 0.5)
    Card.Position = UDim2.new(0.5, 0, 0.5, 0)
    Card.BackgroundColor3 = C.Bg
    Card.BackgroundTransparency = 1
    Card.BorderSizePixel = 0
    Card.ZIndex = 2
    Card.Parent = gui
    corner(Card, 14)

    local s1 = stroke(Card, C.Accent, 1.5, 0.4)
    local s2 = stroke(Card, C.Accent, 8, 0.8)

    local Pad = Instance.new("UIPadding")
    Pad.PaddingTop    = UDim.new(0, 24)
    Pad.PaddingBottom = UDim.new(0, 24)
    Pad.PaddingLeft   = UDim.new(0, 20)
    Pad.PaddingRight  = UDim.new(0, 20)
    Pad.Parent = Card

    local Layout = Instance.new("UIListLayout")
    Layout.Padding = UDim.new(0, 12)
    Layout.SortOrder = Enum.SortOrder.LayoutOrder
    Layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    Layout.Parent = Card

    local Title = Instance.new("TextLabel")
    Title.Size = UDim2.new(1, 0, 0, 38)
    Title.BackgroundTransparency = 1
    Title.Text = "KreinLoad"
    Title.Font = F.Title
    Title.TextSize = 30
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
    Sub.Text = "Detected: " .. gameName
    Sub.TextColor3 = C.TextSub
    Sub.Font = F.Body
    Sub.TextSize = 11
    Sub.TextTransparency = 1
    Sub.LayoutOrder = 2
    Sub.ZIndex = 3
    Sub.Parent = Card

    local Btn = Instance.new("TextButton")
    Btn.Size = UDim2.new(1, 0, 0, 40)
    Btn.BackgroundColor3 = C.CardBg
    Btn.BackgroundTransparency = 1
    Btn.BorderSizePixel = 0
    Btn.Text = "Load Now!"
    Btn.TextColor3 = Color3.new(1,1,1)
    Btn.Font = F.Header
    Btn.TextSize = 14
    Btn.TextTransparency = 1
    Btn.AutoButtonColor = false
    Btn.LayoutOrder = 3
    Btn.ZIndex = 3
    Btn.Parent = Card
    corner(Btn, 10)
    local sBtn = stroke(Btn, C.Accent, 2, 0.2)

    -- Scale GUI 30% lebih kecil (0.7)
    local CardScale = Instance.new("UIScale")
    CardScale.Scale = 0.6
    CardScale.Parent = Card

    task.spawn(function()
        local hue, gradOff, pulse = 0, 0, 0
        while rgbRunning and Card.Parent do
            hue = (hue + 0.01) % 1
            gradOff = (gradOff + 0.005) % 1
            pulse = (pulse + 0.06) % (math.pi * 2)
            local col = Color3.fromHSV(hue, 0.9, 1)
            s1.Color = col; s2.Color = col; sBtn.Color = col
            s2.Transparency = 0.65 + (math.sin(pulse) * 0.5 + 0.5) * 0.2
            TitleGrad.Offset = Vector2.new(gradOff, 0)
            task.wait(0.03)
        end
    end)

    tw(Card, {BackgroundTransparency = 0}, 0.5, Enum.EasingStyle.Back)
    tw(CardScale, {Scale = 0.7}, 0.6, Enum.EasingStyle.Back)
    task.delay(0.2, function()
        for _, el in ipairs({Title, Sub, Btn}) do
            if el and el.Parent then tw(el, {TextTransparency = 0}, 0.4) end
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
        animateClick(Btn)
        Btn.Text = "Loading..."
        loadLibrary(Btn, function(KreinHub)
            task.wait(0.1)
            fadeOutAndDestroy()
            task.delay(0.5, function()
                KreinHub:Notify("Krein Hub", "Berhasil dimuat!", 3, "success")
            end)
        end)
    end)

    createCloseBtn(Card)
end

-- ═══════════════════════════════════════════════════════════════
--  MODE B: GAME UNSUPPORTED → Full Menu Window
-- ═══════════════════════════════════════════════════════════════
local function buildMenuWindow()
    local W = Instance.new("Frame")
    W.Name = "KreinMenu"
    W.Size = UDim2.new(0, 740, 0, 520)
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
        if vp.X < 740 then W.Size = UDim2.new(1, -20, 1, -120) end
    end

    local s1 = stroke(W, C.Accent, 1.5, 0.4)
    local s2 = stroke(W, C.Accent, 8, 0.8)

    local hue = 0
    task.spawn(function()
        while rgbRunning and W.Parent do
            hue = (hue + 0.01) % 1
            local col = Color3.fromHSV(hue, 0.9, 1)
            s1.Color = col; s2.Color = col
            s2.Transparency = 0.65 + (math.sin(tick() * 2) * 0.5 + 0.5) * 0.2
            task.wait(0.03)
        end
    end)

    -- Scale GUI 30% lebih kecil (0.7)
    local WScale = Instance.new("UIScale")
    WScale.Scale = 0.7
    WScale.Parent = W

    tw(W, {BackgroundTransparency = 0}, 0.4, Enum.EasingStyle.Back)
    tw(WScale, {Scale = 0.7}, 0.5, Enum.EasingStyle.Back)

    -- ── SIDEBAR ──
    local SB = Instance.new("Frame")
    SB.Size = UDim2.new(0, 190, 1, 0)
    SB.BackgroundColor3 = C.BgSoft
    SB.BackgroundTransparency = 0.02
    SB.BorderSizePixel = 0
    SB.Parent = W
    corner(SB, 16)

    local SBCover = Instance.new("Frame")
    SBCover.Size = UDim2.new(0, 12, 1, 0)
    SBCover.Position = UDim2.new(1, -12, 0, 0)
    SBCover.BackgroundColor3 = C.BgSoft
    SBCover.BackgroundTransparency = 0.02
    SBCover.BorderSizePixel = 0
    SBCover.Parent = SB

    local SBSep = Instance.new("Frame")
    SBSep.Size = UDim2.new(0, 1, 1, -40)
    SBSep.Position = UDim2.new(1, 0, 0, 20)
    SBSep.BackgroundColor3 = C.Border
    SBSep.BackgroundTransparency = 0.5
    SBSep.BorderSizePixel = 0
    SBSep.Parent = SB

    local Title = Instance.new("TextLabel")
    Title.Size = UDim2.new(1, 0, 0, 70)
    Title.BackgroundTransparency = 1
    Title.Text = "KreinLoad"
    Title.Font = F.Title
    Title.TextSize = 26
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
            o = (o + 0.005) % 1
            TGrad.Offset = Vector2.new(o, 0)
            task.wait(0.03)
        end
    end)

    local Menu = Instance.new("Frame")
    Menu.Size = UDim2.new(1, -20, 1, -150)
    Menu.Position = UDim2.new(0, 10, 0, 70)
    Menu.BackgroundTransparency = 1
    Menu.Parent = SB

    local MenuL = Instance.new("UIListLayout")
    MenuL.Padding = UDim.new(0, 8)
    MenuL.SortOrder = Enum.SortOrder.LayoutOrder
    MenuL.Parent = Menu

    local OpenBtn = Instance.new("TextButton")
    OpenBtn.Size = UDim2.new(1, -20, 0, 44)
    OpenBtn.Position = UDim2.new(0, 10, 1, -54)
    OpenBtn.BackgroundColor3 = C.CardBg
    OpenBtn.BorderSizePixel = 0
    OpenBtn.Text = "🚀  Open Library"
    OpenBtn.TextColor3 = C.Text
    OpenBtn.Font = F.Header
    OpenBtn.TextSize = 13
    OpenBtn.AutoButtonColor = false
    OpenBtn.Parent = SB
    corner(OpenBtn, 10)
    stroke(OpenBtn, C.Success, 1.5, 0.4)

    local Content = Instance.new("Frame")
    Content.Size = UDim2.new(1, -190, 1, 0)
    Content.Position = UDim2.new(0, 190, 0, 0)
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
    GamesPage.ScrollBarThickness = 3
    GamesPage.ScrollBarImageColor3 = C.Border
    GamesPage.ScrollingDirection = Enum.ScrollingDirection.Y
    GamesPage.AutomaticCanvasSize = Enum.AutomaticSize.Y
    GamesPage.CanvasSize = UDim2.new(0, 0, 0, 0)
    GamesPage.Selectable = false
    GamesPage.Parent = Pages

    local GL = Instance.new("UIListLayout")
    GL.Padding = UDim.new(0, 12)
    GL.SortOrder = Enum.SortOrder.LayoutOrder
    GL.HorizontalAlignment = Enum.HorizontalAlignment.Center
    GL.Parent = GamesPage

    local GPad = Instance.new("UIPadding")
    GPad.PaddingTop = UDim.new(0, 24)
    GPad.PaddingBottom = UDim.new(0, 24)
    GPad.Parent = GamesPage

    local GHeader = Instance.new("TextLabel")
    GHeader.Size = UDim2.new(1, -60, 0, 34)
    GHeader.BackgroundTransparency = 1
    GHeader.Text = "🎮 Game List"
    GHeader.TextColor3 = C.Text
    GHeader.Font = F.Title
    GHeader.TextSize = 24
    GHeader.TextXAlignment = Enum.TextXAlignment.Left
    GHeader.LayoutOrder = 0
    GHeader.Parent = GamesPage

    local GSub = Instance.new("TextLabel")
    GSub.Size = UDim2.new(1, -60, 0, 22)
    GSub.BackgroundTransparency = 1
    GSub.Text = "Daftar game yang didukung oleh Krein Hub."
    GSub.TextColor3 = C.TextSub
    GSub.Font = F.Body
    GSub.TextSize = 13
    GSub.TextXAlignment = Enum.TextXAlignment.Left
    GSub.LayoutOrder = 1
    GSub.Parent = GamesPage

    -- Game card renderer
    local function makeGameCard(placeId, order)
        local Card = Instance.new("Frame")
        Card.Size = UDim2.new(1, -60, 0, 80)
        Card.BackgroundColor3 = C.CardBg
        Card.BackgroundTransparency = 0.05
        Card.BorderSizePixel = 0
        Card.LayoutOrder = order
        Card.Parent = GamesPage
        corner(Card, 12)
        local cStk = stroke(Card, C.Border, 1, 0.5)

        local IconF = Instance.new("Frame")
        IconF.Size = UDim2.new(0, 58, 0, 58)
        IconF.Position = UDim2.new(0, 12, 0.5, -29)
        IconF.BackgroundColor3 = C.BgSoft
        IconF.BorderSizePixel = 0
        IconF.ClipsDescendants = true
        IconF.Parent = Card
        corner(IconF, 10)
        stroke(IconF, C.Border, 1, 0.3)

        local Icon = Instance.new("ImageLabel")
        Icon.Size = UDim2.new(1, 0, 1, 0)
        Icon.BackgroundTransparency = 1
        Icon.Image = getGameIcon(placeId)
        Icon.Parent = IconF

        local Name = Instance.new("TextLabel")
        Name.Size = UDim2.new(1, -100, 0, 22)
        Name.Position = UDim2.new(0, 84, 0, 20)
        Name.BackgroundTransparency = 1
        Name.Text = "Loading..."
        Name.TextColor3 = C.Text
        Name.Font = F.Header
        Name.TextSize = 15
        Name.TextXAlignment = Enum.TextXAlignment.Left
        Name.TextTruncate = Enum.TextTruncate.AtEnd
        Name.Parent = Card

        local Id = Instance.new("TextLabel")
        Id.Size = UDim2.new(1, -100, 0, 16)
        Id.Position = UDim2.new(0, 84, 0, 44)
        Id.BackgroundTransparency = 1
        Id.Text = "ID: " .. placeId
        Id.TextColor3 = C.TextSub
        Id.Font = F.Code
        Id.TextSize = 11
        Id.TextXAlignment = Enum.TextXAlignment.Left
        Id.Parent = Card
        
        -- Fetch Nama secara Async
        task.spawn(function()
            local info = getGameInfo(placeId)
            if info and Name.Parent then
                Name.Text = info.Name
            elseif Name.Parent then
                Name.Text = "Unknown Game"
            end
        end)

        Card.MouseEnter:Connect(function()
            tw(Card, {BackgroundColor3 = C.CardHover, BackgroundTransparency = 0, Size = UDim2.new(1, -56, 0, 84)}, 0.15)
            tw(cStk, {Transparency = 0.2, Color = C.Accent}, 0.15)
        end)
        Card.MouseLeave:Connect(function()
            tw(Card, {BackgroundColor3 = C.CardBg, BackgroundTransparency = 0.05, Size = UDim2.new(1, -60, 0, 80)}, 0.15)
            tw(cStk, {Transparency = 0.5, Color = C.Border}, 0.15)
        end)
    end

    local idx = 2
    for pid, _ in pairs(GAMES) do
        makeGameCard(pid, idx)
        idx = idx + 1
    end

    if idx == 2 then
        local Empty = Instance.new("TextLabel")
        Empty.Size = UDim2.new(1, -60, 0, 80)
        Empty.BackgroundColor3 = C.CardBg
        Empty.BackgroundTransparency = 0.5
        Empty.Text = "Belum ada game terdaftar di registry."
        Empty.TextColor3 = C.TextSub
        Empty.Font = F.Reg
        Empty.TextSize = 13
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
    IPad.PaddingLeft = UDim.new(0, 40)
    IPad.PaddingRight = UDim.new(0, 40)
    IPad.Parent = InfoPage

    local IL = Instance.new("UIListLayout")
    IL.Padding = UDim.new(0, 14)
    IL.Parent = InfoPage

    local IHeader = Instance.new("TextLabel")
    IHeader.Size = UDim2.new(1, 0, 0, 32)
    IHeader.BackgroundTransparency = 1
    IHeader.Text = "ℹ️ Krein GUI Library"
    IHeader.TextColor3 = C.Text
    IHeader.Font = F.Title
    IHeader.TextSize = 24
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
        l.TextSize = 13
        l.TextXAlignment = Enum.TextXAlignment.Left
        l.Parent = row
        local v = Instance.new("TextLabel")
        v.Size = UDim2.new(1, -130, 1, 0)
        v.Position = UDim2.new(0, 130, 0, 0)
        v.BackgroundTransparency = 1
        v.Text = value
        v.TextColor3 = color or C.Text
        v.Font = F.Header
        v.TextSize = 13
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
    Desc.TextSize = 13
    Desc.TextXAlignment = Enum.TextXAlignment.Left
    Desc.TextYAlignment = Enum.TextYAlignment.Top
    Desc.TextWrapped = true
    Desc.LayoutOrder = 5
    Desc.Parent = InfoPage

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
    stTitle.Position = UDim2.new(0, 12, 0, 10)
    stTitle.BackgroundTransparency = 1
    stTitle.Text = "⚠ Game saat ini tidak didukung"
    stTitle.TextColor3 = C.Danger
    stTitle.Font = F.Header
    stTitle.TextSize = 13
    stTitle.TextXAlignment = Enum.TextXAlignment.Left
    stTitle.Parent = StatusF

    local cInfo = getGameInfo(game.PlaceId)
    local cName = cInfo and cInfo.Name or "Unknown"

    local stName = Instance.new("TextLabel")
    stName.Size = UDim2.new(1, -20, 0, 18)
    stName.Position = UDim2.new(0, 12, 0, 32)
    stName.BackgroundTransparency = 1
    stName.Text = "Game: " .. cName
    stName.TextColor3 = C.Text
    stName.Font = F.Body
    stName.TextSize = 12
    stName.TextXAlignment = Enum.TextXAlignment.Left
    stName.Parent = StatusF

    local stId = Instance.new("TextLabel")
    stId.Size = UDim2.new(1, -20, 0, 16)
    stId.Position = UDim2.new(0, 12, 0, 52)
    stId.BackgroundTransparency = 1
    stId.Text = "PlaceId: " .. tostring(game.PlaceId)
    stId.TextColor3 = C.TextSub
    stId.Font = F.Code
    stId.TextSize = 11
    stId.TextXAlignment = Enum.TextXAlignment.Left
    stId.Parent = StatusF

    local menuBtns = {}
    local currentPage = "games"

    local function switchPage(name)
        if currentPage == name then return end
        currentPage = name
        for n, b in pairs(menuBtns) do
            local active = (n == name)
            tw(b, {BackgroundColor3 = active and C.CardBg or C.BgSoft, BackgroundTransparency = active and 0.02 or 1}, 0.2)
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
        B.Size = UDim2.new(1, 0, 0, 44)
        B.BackgroundColor3 = name == "games" and C.CardBg or C.BgSoft
        B.BackgroundTransparency = name == "games" and 0.02 or 1
        B.BorderSizePixel = 0
        B.Text = ""
        B.AutoButtonColor = false
        B.LayoutOrder = order
        B.Parent = Menu
        corner(B, 10)

        local T = Instance.new("TextLabel")
        T.Name = "TextLabel"
        T.Size = UDim2.new(1, -24, 1, 0)
        T.Position = UDim2.new(0, 18, 0, 0)
        T.BackgroundTransparency = 1
        T.Text = icon .. "  " .. label
        T.TextColor3 = name == "games" and C.Text or C.TextSub
        T.Font = F.Header
        T.TextSize = 14
        T.TextXAlignment = Enum.TextXAlignment.Left
        T.Parent = B

        local Ind = Instance.new("Frame")
        Ind.Name = "Indicator"
        Ind.Size = UDim2.new(0, 4, 0, 24)
        Ind.Position = UDim2.new(0, 0, 0.5, -12)
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
                tw(B, {BackgroundColor3 = C.BgSoft, BackgroundTransparency = 1}, 0.15)
                tw(T, {TextColor3 = C.TextSub}, 0.15)
            end
        end)
        B.MouseButton1Click:Connect(function() switchPage(name) end)

        menuBtns[name] = B
        return B
    end

    createMenuBtn("games", "Games", "🎮", 1)
    createMenuBtn("info",  "Info",  "ℹ️", 2)

    OpenBtn.MouseEnter:Connect(function()
        tw(OpenBtn, {BackgroundColor3 = C.CardHover}, 0.15)
    end)
    OpenBtn.MouseLeave:Connect(function()
        tw(OpenBtn, {BackgroundColor3 = C.CardBg}, 0.15)
    end)
    OpenBtn.MouseButton1Click:Connect(function()
        if OpenBtn.Text == "Loading..." then return end
        animateClick(OpenBtn)
        OpenBtn.Text = "Loading..."
        loadLibrary(OpenBtn, function(KreinHub)
            task.wait(0.1)
            fadeOutAndDestroy()
            task.delay(0.5, function()
                KreinHub:Notify("Krein Hub", "Library dibuka tanpa fitur game.", 3, "info")
            end)
        end)
    end)

    createCloseBtn(W)
end

-- ═══════════════════════════════════════════════════════════════
--  DISPATCH
-- ═══════════════════════════════════════════════════════════════
if supported then
    buildSupportedCard()
else
    buildMenuWindow()
end
