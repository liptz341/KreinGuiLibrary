--[[ Protected by Lua Guard ]]

(function(...) 
local _IIlIllIIIl        = game:GetService("\085\115\101\114\073\110\112\117\116\083\101\114\118\105\099\101")
local _IlllIlllIl         = game:GetService("\084\119\101\101\110\083\101\114\118\105\099\101")
local Players    = game:GetService("\080\108\097\121\101\114\115")
local _IIIlllIIll    = game:GetService("\067\111\114\101\071\117\105")
local RunService = game:GetService("\082\117\110\083\101\114\118\105\099\101")
local _IlIIIllIIl = _IIlIllIIIl.TouchEnabled and not _IIlIllIIIl.KeyboardEnabled
local _IIlIIlIlIl  = {}
_IIlIIlIlIl.__index = _IIlIIlIlIl
local _IllIIIlIll = {
Title  = Enum.Font.FredokaOne,
Header = Enum.Font.FredokaOne,
Label  = Enum.Font.Gotham,
_lllIIlllIl   = Enum.Font.Gotham,
Bold   = Enum.Font.GothamBold,
Medium = Enum.Font.GothamMedium,
Semi   = Enum.Font.GothamSemibold,
}
local function _IllllIllII(_lIlIIIlIll, props, dur, style, dir)
_IlllIlllIl:Create(_lIlIIIlIll,
TweenInfo.new(dur or 0.5, style or Enum.EasingStyle.Quint, dir or Enum.EasingDirection.Out),
props
):Play()
end
local function _IlIIIIIlII(parent, radius)
local _IlIIlllIll = Instance.new("\085\073\067\111\114\110\101\114")
_IlIIlllIll.CornerRadius = UDim.new(0x0, radius or 0x8)
_IlIIlllIll.Parent = parent
return _IlIIlllIll
end
local function _IlIIllIIIl(parent, color, thickness, transparency)
local _lIIllIlIll = Instance.new("\085\073\083\116\114\111\107\101")
_lIIllIlIll.Color = color or Color3.fromRGB(0x32, 0x32, 0x3C)
_lIIllIlIll.Thickness = thickness or 0x1
_lIIllIlIll.Transparency = transparency or 0.7
_lIIllIlIll.Parent = parent
return _lIIllIlIll
end
local function _lllllIllII(parent, fillDir, spacing, sortOrder)
local _lllIlllIIl = Instance.new("\085\073\076\105\115\116\076\097\121\111\117\116")
_lllIlllIIl.FillDirection  = fillDir or Enum.FillDirection.Vertical
_lllIlllIIl.Padding        = UDim.new(0x0, spacing or 0x5)
_lllIlllIIl.SortOrder      = sortOrder or Enum.SortOrder.LayoutOrder
_lllIlllIIl.HorizontalAlignment = Enum.HorizontalAlignment.Center
_lllIlllIIl.Parent = parent
return _lllIlllIIl
end
local function _llllllllIl(parent, top, bottom, left, _lllIlIIllI)
local _IllIlIIIlI = Instance.new("\085\073\080\097\100\100\105\110\103")
_IllIlIIIlI.PaddingTop    = UDim.new(0x0, top    or 0x6)
_IllIlIIIlI.PaddingBottom = UDim.new(0x0, bottom or 0x6)
_IllIlIIIlI.PaddingLeft   = UDim.new(0x0, left   or 0xA)
_IllIlIIIlI.PaddingRight  = UDim.new(0x0, _lllIlIIllI  or 0xA)
_IllIlIIIlI.Parent = parent
return _IllIlIIIlI
end
local _lIlIlIIlll  = nil
local _lIIIIIIIlI = nil
local function _IlIlIIIIlI(_llllIIllll, anchor)
if _lIlIlIIlll  then _lIlIlIIlll:Destroy() end
if _lIIIIIIIlI then _lIIIIIIIlI:Disconnect() end
if not _llllIIllll or _llllIIllll == "" then return end
local _IlIIIIIlII = anchor:FindFirstAncestorOfClass("\083\099\114\101\101\110\071\117\105")
if not _IlIIIIIlII then return end
local _IllIIllIll = Instance.new("\070\114\097\109\101")
_IllIIllIll.Name = "\075\114\101\105\110\084\111\111\108\116\105\112"
_IllIIllIll.Size = UDim2.new(0x0, 0xB9, 0x0, 0x1C)
_IllIIllIll.BackgroundColor3 = Color3.fromRGB(0x12, 0x12, 0x18)
_IllIIllIll.BackgroundTransparency = 0.04
_IllIIllIll.BorderSizePixel = 0x0
_IllIIllIll.ZIndex = 0x270F
_IllIIllIll.Parent = _IlIIIIIlII
_IlIIIIIlII(_IllIIllIll, 0x6)
_IlIIllIIIl(_IllIIllIll, Color3.fromRGB(0x41, 0x41, 0x52), 0x1, 0.2)
local _lIlllIllII = Instance.new("\084\101\120\116\076\097\098\101\108")
_lIlllIllII.Size = UDim2.new(0x1, -0xC, 0x1, 0x0)
_lIlllIllII.Position = UDim2.new(0x0, 0x6, 0x0, 0x0)
_lIlllIllII.BackgroundTransparency = 0x1
_lIlllIllII.Text = _llllIIllll
_lIlllIllII.TextColor3 = Color3.fromRGB(0xD2, 0xD2, 0xE1)
_lIlllIllII.Font = _IllIIIlIll.Body
_lIlllIllII.TextSize = 0xB
_lIlllIllII.TextXAlignment = Enum.TextXAlignment.Left
_lIlllIllII.ZIndex = 0x270F
_lIlllIllII.Parent = _IllIIllIll
_lIIIIIIIlI = _IIlIllIIIl.InputChanged:Connect(function(input)
if not _IllIIllIll or not _IllIIllIll.Parent then return end
if input.UserInputType == Enum.UserInputType.MouseMovement then
local _IIlIlIlIII = input.Position
_IllIIllIll.Position = UDim2.new(0x0, _IIlIlIlIII.X + 0xE, 0x0, _IIlIlIlIII.Y - 0x24)
end
end)
_lIlIlIIlll = _IllIIllIll
end
local function _lIlIlllIlI()
if _lIIIIIIIlI then _lIIIIIIIlI:Disconnect(); _lIIIIIIIlI = nil end
if _lIlIlIIlll then
_IllllIllII(_lIlIlIIlll, {BackgroundTransparency = 0x1}, 0.1)
local _lIIllIlIIl = _lIlIlIIlll; _lIlIlIIlll = nil
task.delay(0.11, function() if _lIIllIlIIl and _lIIllIlIIl.Parent then _lIIllIlIIl:Destroy() end end)
end
end
local function _IlIIIllIIl()
local _llIIIIlIll = {_IIIlllIIll}
pcall(function()
local _lIIllIIlII = Players.LocalPlayer:FindFirstChild("\080\108\097\121\101\114\071\117\105")
if _lIIllIIlII then table.insert(_llIIIIlIll, _lIIllIIlII) end
end)
for _, _IllIIlIIIl in ipairs(_llIIIIlIll) do
pcall(function()
local _lIllllllll = _IllIIlIIIl:FindFirstChild("\075\114\101\105\110\072\117\098")
if _lIllllllll then _lIllllllll:Destroy() end
end)
end
end
_IlIIIllIIl()
local _lIlllIIIll = Instance.new("\083\099\114\101\101\110\071\117\105")
_lIlllIIIll.Name = "\075\114\101\105\110\072\117\098"
_lIlllIIIll.Parent = _IIIlllIIll
_lIlllIIIll.ResetOnSpawn = false
_lIlllIIIll.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
_lIlllIIIll.DisplayOrder = 0xA
local _llIIlIIIlI = Instance.new("\070\114\097\109\101")
_llIIlIIIlI.Name  = "\078\111\116\105\102\067\111\110\116\097\105\110\101\114"
_llIIlIIIlI.Size  = UDim2.new(0x0, 0x12C, 0x1, 0x0)
_llIIlIIIlI.Position = UDim2.new(0x1, -0x136, 0x0, 0x0)
_llIIlIIIlI.BackgroundTransparency = 0x1
_llIIlIIIlI.BorderSizePixel = 0x0
_llIIlIIIlI.ZIndex = 0x2328
_llIIlIIIlI.Parent = _lIlllIIIll
local _IlIIllIlII    = {}
local _IIIIIIlIIl = 0x0
local _llllIllllI = 0.3
function _IIlIIlIlIl:Notify(title, message, duration, nType)
local _IllllIllIl = tick()
if _IllllIllIl - _IIIIIIlIIl < _llllIllllI then return end
_IIIIIIlIIl = _IllllIllIl
duration = duration or 0x3
nType    = nType or "\105\110\102\111"
local _lIlllIIllI = ({
info    = {_IllIlllIII = Color3.fromRGB(0x64, 0x96, 0xFF), icon = "\105"},
success = {_IllIlllIII = Color3.fromRGB(0x32,  0xD2,  0x6E), icon = "\118"},
warning = {_IllIlllIII = Color3.fromRGB(0xFF, 0xBD,  0x2E), icon = "\033"},
error   = {_IllIlllIII = Color3.fromRGB(0xE1,  0x3C,  0x3C), icon = "\088"},
})[nType] or {_IllIlllIII = Color3.fromRGB(0x64, 0x96, 0xFF), icon = "\105"}
for _, n in ipairs(_IlIIllIlII) do
     _IllllIllII(n, {Position = n.Position - UDim2.new(0x0, 0x0, 0x0, 0x50)}, 0.28)
 end
 local _llIlIIlIII = Instance.new("\070\114\097\109\101")
 _llIlIIlIII.Size = UDim2.new(0x1, 0x0, 0x0, 0x46)
 _llIlIIlIII.Position = UDim2.new(0x0, 0x0, 0x1, 0xA)
 _llIlIIlIII.BackgroundColor3 = Color3.fromRGB(0x12, 0x12, 0x1A)
 _llIlIIlIII.BackgroundTransparency = 0.06
 _llIlIIlIII.BorderSizePixel = 0x0
 _llIlIIlIII.ZIndex = 0x2329
 _llIlIIlIII.ClipsDescendants = true
 _llIlIIlIII.Parent = _llIIlIIIlI
 _IlIIIIIlII(_llIlIIlIII, 0xE)
 _IlIIllIIIl(_llIlIIlIII, Color3.fromRGB(0xFF, 0xFF, 0xFF), 0x1, 0.88)
 local _lIlllIIlII = Instance.new("\085\073\083\116\114\111\107\101")
 _lIlllIIlII.Color = Color3.fromRGB(0x37, 0x37, 0x4B)
 _lIlllIIlII.Thickness = 1.5
 _lIlllIIlII.Transparency = 0.45
 _lIlllIIlII.Parent = _llIlIIlIII
 local _lllIIlIIll = Instance.new("\070\114\097\109\101")
 _lllIIlIIll.Size = UDim2.new(0x0, 0x3, 0.75, 0x0)
 _lllIIlIIll.Position = UDim2.new(0x0, 0x0, 0.125, 0x0)
 _lllIIlIIll.BackgroundColor3 = _lIlllIIllI.bar
 _lllIIlIIll.BorderSizePixel = 0x0
 _lllIIlIIll.ZIndex = 0x232A
 _lllIIlIIll.Parent = _llIlIIlIII
 _IlIIIIIlII(_lllIIlIIll, 0x3)
 local _lIllIIlllI = Instance.new("\070\114\097\109\101")
 _lIllIIlllI.Size = UDim2.new(0x1, 0x0, 0x0, 0x2)
 _lIllIIlllI.Position = UDim2.new(0x0, 0x0, 0x1, -0x2)
 _lIllIIlllI.BackgroundColor3 = _lIlllIIllI.bar
 _lIllIIlllI.BackgroundTransparency = 0.4
 _lIllIIlllI.BorderSizePixel = 0x0
 _lIllIIlllI.ZIndex = 0x232A
 _lIllIIlllI.Parent = _llIlIIlIII
 _IllllIllII(_lIllIIlllI, {Size = UDim2.new(0x0, 0x0, 0x0, 0x2)}, duration, Enum.EasingStyle.Linear)
 local _llIlIIIIll = Instance.new("\070\114\097\109\101")
 _llIlIIIIll.Size = UDim2.new(0x0, 0x1E, 0x0, 0x1E)
 _llIlIIIIll.Position = UDim2.new(0x0, 0xE, 0x0, 0x14)
 _llIlIIIIll.BackgroundColor3 = _lIlllIIllI.bar
 _llIlIIIIll.BackgroundTransparency = 0.78
 _llIlIIIIll.BorderSizePixel = 0x0
 _llIlIIIIll.ZIndex = 0x232A
 _llIlIIIIll.Parent = _llIlIIlIII
 _IlIIIIIlII(_llIlIIIIll, 0xF)
 local _lIlIllIlIl = Instance.new("\084\101\120\116\076\097\098\101\108")
 _lIlIllIlIl.Size = UDim2.new(0x1, 0x0, 0x1, 0x0)
 _lIlIllIlIl.BackgroundTransparency = 0x1
 _lIlIllIlIl.Text = _lIlllIIllI.icon
 _lIlIllIlIl.TextColor3 = _lIlllIIllI.bar
 _lIlIllIlIl.Font = _IllIIIlIll.Bold
 _lIlIllIlIl.TextSize = 0xD
 _lIlIllIlIl.ZIndex = 0x232B
 _lIlIllIlIl.Parent = _llIlIIIIll
 local _IllIlIlIll = Instance.new("\084\101\120\116\076\097\098\101\108")
 _IllIlIlIll.Size = UDim2.new(0x0, 0xD2, 0x0, 0x12)
 _IllIlIlIll.Position = UDim2.new(0x0, 0x36, 0x0, 0xC)
 _IllIlIlIll.BackgroundTransparency = 0x1
 _IllIlIlIll.Text = title
 _IllIlIlIll.TextColor3 = Color3.fromRGB(0xF5, 0xF5, 0xFF)
 _IllIlIlIll.Font = _IllIIIlIll.Bold
 _IllIlIlIll.TextSize = 0xC
 _IllIlIlIll.TextXAlignment = Enum.TextXAlignment.Left
 _IllIlIlIll.ZIndex = 0x232A
 _IllIlIlIll.Parent = _llIlIIlIII
 local _IIlIIIlIll = Instance.new("\084\101\120\116\076\097\098\101\108")
 _IIlIIIlIll.Size = UDim2.new(0x0, 0xD2, 0x0, 0x1C)
 _IIlIIIlIll.Position = UDim2.new(0x0, 0x36, 0x0, 0x1E)
 _IIlIIIlIll.BackgroundTransparency = 0x1
 _IIlIIIlIll.Text = message
 _IIlIIIlIll.TextColor3 = Color3.fromRGB(0x91, 0x91, 0xA2)
 _IIlIIIlIll.Font = _IllIIIlIll.Body
 _IIlIIIlIll.TextSize = 0xA
 _IIlIIIlIll.TextXAlignment = Enum.TextXAlignment.Left
 _IIlIIIlIll.TextWrapped = true
 _IIlIIIlIll.ZIndex = 0x232A
 _IIlIIIlIll.Parent = _llIlIIlIII
 local _IlllIlllIl = Instance.new("\084\101\120\116\066\117\116\116\111\110")
 _IlllIlllIl.Size = UDim2.new(0x0, 0x14, 0x0, 0x14)
 _IlllIlllIl.Position = UDim2.new(0x1, -0x1A, 0x0, 0x8)
 _IlllIlllIl.BackgroundTransparency = 0x1
 _IlllIlllIl.Text = "\120"
 _IlllIlllIl.TextColor3 = Color3.fromRGB(0x5A, 0x5A, 0x6C)
 _IlllIlllIl.Font = _IllIIIlIll.Bold
 _IlllIlllIl.TextSize = 0xE
 _IlllIlllIl.ZIndex = 0x232B
 _IlllIlllIl.Parent = _llIlIIlIII
 local function _IIllIlIIIl()
     local _llIIIIlIII = table.find(_IlIIllIlII, _llIlIIlIII)
     if _llIIIIlIII then table.remove(_IlIIllIlII, _llIIIIlIII) end
     _IllllIllII(_llIlIIlIII, {Position = _llIlIIlIII.Position + UDim2.new(0x0, 0x136, 0x0, 0x0), BackgroundTransparency = 0x1}, 0.22)
     task.delay(0.23, function()
         if _llIlIIlIII and _llIlIIlIII.Parent then _llIlIIlIII:Destroy() end
     end)
 end
 _IlllIlllIl.MouseButton1Click:Connect(_IIllIlIIIl)
 table.insert(_IlIIllIlII, _llIlIIlIII)
 _IllllIllII(_llIlIIlIII, {Position = UDim2.new(0x0, 0x0, 0x1, -0x54)}, 0.45, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
 task.delay(duration, function()
     if _llIlIIlIII and _llIlIIlIII.Parent then _IIllIlIIIl() end
 end)
end
function _IIlIIlIlIl:CreateWindow(cfg)
cfg = cfg or {}
local _IIllllllll = cfg.Title    or "\075\114\101\105\110\032\072\117\098"
local _IllIIIIlll   = cfg.Subtitle or "\080\114\101\109\105\117\109\032\085\073\032\076\105\098\114\097\114\121"
local _IlIlIIlllI  = cfg.Size     or UDim2.new(0x0, 0x2A8, 0x0, 0x1CC)
local _llIIlIIIII   = cfg.Position or UDim2.new(0.5, -0x154, 0.5, -0xE6)
local _IIllIlllIl   = cfg.MinSize  or UDim2.new(0x0, 0x118, 0x0, 0x2D)
local _IllIllIIlI   = cfg.MaxSize  or UDim2.new(0x0, 0x370, 0x0, 0x244)
local _llIllIIIlI = {}
 local function _lIIllllIll(_IlIIlllIll) table.insert(_llIllIIIlI, _IlIIlllIll) end
 local function _IIIIIIlIIl(sig, fn) _lIIllllIll(sig:Connect(fn)) end
 local _lllIIlIIll = {
     MainBg        = Color3.fromRGB(0xE, 0xE, 0x14),
     TitleBg       = Color3.fromRGB(0x12, 0x12, 0x1A),
     SidebarBg     = Color3.fromRGB(0xF, 0xF, 0x16),
     Text          = Color3.fromRGB(0xE8, 0xE8, 0xF5),
     SubText       = Color3.fromRGB(0x6E, 0x6E, 0x82),
     Stroke        = Color3.fromRGB(0xFF, 0xFF, 0xFF),
     InnerStroke   = Color3.fromRGB(0x34, 0x34, 0x46),
     SectionBg     = Color3.fromRGB(0x14, 0x14, 0x1C),
     SectionHdr    = Color3.fromRGB(0x18, 0x18, 0x22),
     ComponentBg   = Color3.fromRGB(0x15, 0x15, 0x1E),
     CompStroke    = Color3.fromRGB(0x26, 0x26, 0x36),
     TabActive     = Color3.fromRGB(0x26, 0x28, 0x3E),
     TabInactive   = Color3.fromRGB(0x14, 0x14, 0x1E),
     TabText       = Color3.fromRGB(0x80, 0x80, 0x94),
     TabTextActive = Color3.fromRGB(0xFF, 0xFF, 0xFF),
     ToggleOff     = Color3.fromRGB(0x30, 0x30, 0x40),
     ToggleOn      = Color3.fromRGB(0x44, 0xBC, 0x4E),
     SliderBg      = Color3.fromRGB(0x20, 0x20, 0x2E),
     SliderFill    = Color3.fromRGB(0x6E, 0x9B, 0xFF),
     DropdownBg    = Color3.fromRGB(0x11, 0x11, 0x18),
     OptionBg      = Color3.fromRGB(0x16, 0x16, 0x20),
     OptionHover   = Color3.fromRGB(0x2A, 0x2A, 0x3C),
     KeybindBg     = Color3.fromRGB(0x1C, 0x1C, 0x2A),
     SearchBg      = Color3.fromRGB(0x14, 0x14, 0x1E),
     InputBg       = Color3.fromRGB(0x1A, 0x1A, 0x24),
     InputStroke   = Color3.fromRGB(0x2C, 0x2C, 0x3E),
     LabelText     = Color3.fromRGB(0x78, 0x78, 0x8C),
     BtnGreen      = Color3.fromRGB(0x26, 0x82, 0x41),
     BtnRed        = Color3.fromRGB(0xB4, 0x2D, 0x2D),
     ResetBg       = Color3.fromRGB(0x12, 0x12, 0x1A),
     ResetBtnBg    = Color3.fromRGB(0xE, 0xE, 0x14),
     SettingsBg    = Color3.fromRGB(0x12, 0x12, 0x1A),
     AccentBlue    = Color3.fromRGB(0x6E, 0x9B, 0xFF),
     AccentGlow    = Color3.fromRGB(0x50, 0x78, 0xDC),
     ProgressBg    = Color3.fromRGB(0x1C, 0x1C, 0x2A),
     ProgressFill  = Color3.fromRGB(0x6E, 0x9B, 0xFF),
 }
 local _IlIIlllIIl = Instance.new("\070\114\097\109\101")
 _IlIIlllIIl.Name  = "\075\114\101\105\110\077\097\105\110"
 _IlIIlllIIl.Size  = UDim2.new(0x0, 0x0, 0x0, 0x0)
 _IlIIlllIIl.Position = UDim2.new(0.5, 0x0, 0.5, 0x0)
 _IlIIlllIIl.BackgroundColor3 = _lllIIlIIll.MainBg
 _IlIIlllIIl.BackgroundTransparency = 0.04
 _IlIIlllIIl.BorderSizePixel = 0x0
 _IlIIlllIIl.ClipsDescendants = true
 _IlIIlllIIl.Parent = _lIlllIIIll
 _IlIIIIIlII(_IlIIlllIIl, 0x10)
 local _llllIIIlIl = Instance.new("\073\109\097\103\101\076\097\098\101\108")
 _llllIIIlIl.Size = UDim2.new(0x1, 0x0, 0x1, 0x0)
 _llllIIIlIl.BackgroundTransparency = 0x1
 _llllIIIlIl.Image = "\114\098\120\097\115\115\101\116\105\100\058\047\047\049\048\051\054\052\050\050\049\055\057\048\057\054\050\048"
 _llllIIIlIl.ImageTransparency = 0.5
 _llllIIIlIl.ScaleType = Enum.ScaleType.Crop
 _llllIIIlIl.ZIndex = 0x0
 _llllIIIlIl.Parent = _IlIIlllIIl
 _IlIIIIIlII(_llllIIIlIl, 0x10)
 local _lIIIIllIIl = Instance.new("\085\073\083\116\114\111\107\101")
 _lIIIIllIIl.Name = "\077\097\105\110\083\116\114\111\107\101\049"
 _lIIIIllIIl.Color = Color3.fromRGB(0xFF, 0xFF, 0xFF)
 _lIIIIllIIl.Thickness = 1.5
 _lIIIIllIIl.Transparency = 0.6
 _lIIIIllIIl.LineJoinMode = Enum.LineJoinMode.Round
 _lIIIIllIIl.Parent = _IlIIlllIIl
 local _IlIIIlIIll = Instance.new("\085\073\083\116\114\111\107\101")
 _IlIIIlIIll.Name = "\077\097\105\110\083\116\114\111\107\101\050"
 _IlIIIlIIll.Color = Color3.fromRGB(0x50, 0x5A, 0x82)
 _IlIIIlIIll.Thickness = 0x3
 _IlIIIlIIll.Transparency = 0.72
 _IlIIIlIIll.LineJoinMode = Enum.LineJoinMode.Round
 _IlIIIlIIll.Parent = _IlIIlllIIl
 local _lIlllllIII = Instance.new("\085\073\083\116\114\111\107\101")
 _lIlllllIII.Name = "\077\097\105\110\083\116\114\111\107\101\051"
 _lIlllllIII.Color = Color3.fromRGB(0x1E, 0x20, 0x32)
 _lIlllllIII.Thickness = 0x6
 _lIlllllIII.Transparency = 0.78
 _lIlllllIII.LineJoinMode = Enum.LineJoinMode.Round
 _lIlllllIII.Parent = _IlIIlllIIl
 local _IlIIIlIllI = true
 task.spawn(function()
     local _llIIIlIIll = 0x0
     while _IlIIIlIllI and _IlIIlllIIl and _IlIIlllIIl.Parent do
         _llIIIlIIll = (_llIIIlIIll + 0.008) % 0x1
         _lIIIIllIIl.Color = Color3.fromHSV(_llIIIlIIll, 0.85, 0x1)
         task.wait(0.03)
     end
 end)
 local _IIllllIIlI = Instance.new("\083\111\117\110\100")
 _IIllllIIlI.SoundId = "\114\098\120\097\115\115\101\116\105\100\058\047\047\049\054\050\054\057\057\054\053\050\054"
 _IIllllIIlI.Volume = 0.6
 _IIllllIIlI.Parent = _lIlllIIIll
 local _llllIIIllI = Instance.new("\084\101\120\116\076\097\098\101\108")
 _llllIIIllI.Size = UDim2.new(0x0, 0x50, 0x0, 0x50)
 _llllIIIllI.Position = UDim2.new(0.5, -0x28, 0.5, -0x28)
 _llllIIIllI.BackgroundTransparency = 0x1
 _llllIIIllI.Text = "\075"
 _llllIIIllI.TextColor3 = Color3.fromRGB(0xFF, 0xFF, 0xFF)
 _llllIIIllI.Font = _IllIIIlIll.Bold
 _llllIIIllI.TextSize = 0x41
 _llllIIIllI.ZIndex = 0x2710
 _llllIIIllI.Parent = _lIlllIIIll
 local _IlIIllllll = Instance.new("\084\101\120\116\076\097\098\101\108")
 _IlIIllllll.Size = UDim2.new(0x0, 0x12C, 0x0, 0x32)
 _IlIIllllll.Position = UDim2.new(0.5, -0x96, 0.5, -0x19)
 _IlIIllllll.BackgroundTransparency = 0x1
 _IlIIllllll.Text = ""
 _IlIIllllll.TextColor3 = Color3.fromRGB(0xFF, 0xFF, 0xFF)
 _IlIIllllll.Font = _IllIIIlIll.Title
 _IlIIllllll.TextSize = 0x2A
 _IlIIllllll.ZIndex = 0x2710
 _IlIIllllll.Visible = false
 _IlIIllllll.Parent = _lIlllIIIll
 local _llIIllIIlI = Instance.new("\070\114\097\109\101")
 _llIIllIIlI.Name = "\075\114\101\105\110\082\101\115\101\116\070\114\097\109\101"
 _llIIllIIlI.Size = UDim2.new(0x0, 0x32, 0x0, 0x32)
 _llIIllIIlI.Position = UDim2.new(0x0, 0xC, 0x1, -0x19A)
 _llIIllIIlI.BackgroundColor3 = _lllIIlIIll.ResetBg
 _llIIllIIlI.BackgroundTransparency = 0.05
 _llIIllIIlI.BorderSizePixel = 0x0
 _llIIllIIlI.ZIndex = 0x270F
 _llIIllIIlI.Visible = false
 _llIIllIIlI.Parent = _lIlllIIIll
 _IlIIIIIlII(_llIIllIIlI, 0xE)
 local _IlllIIllII = Instance.new("\085\073\083\116\114\111\107\101")
 _IlllIIllII.Color = Color3.fromRGB(0xFF, 0x64, 0x96)
 _IlllIIllII.Thickness = 0x2
 _IlllIIllII.Transparency = 0.18
 _IlllIIllII.LineJoinMode = Enum.LineJoinMode.Round
 _IlllIIllII.Parent = _llIIllIIlI
 local _lllllIIIll = Instance.new("\084\101\120\116\066\117\116\116\111\110")
 _lllllIIIll.Name = "\075\114\101\105\110\082\101\115\101\116"
 _lllllIIIll.Size = UDim2.new(0x0, 0x2A, 0x0, 0x2A)
 _lllllIIIll.AnchorPoint = Vector2.new(0.5, 0.5)
 _lllllIIIll.Position = UDim2.new(0.5, 0x0, 0.5, 0x0)
 _lllllIIIll.BackgroundColor3 = _lllIIlIIll.ResetBtnBg
 _lllllIIIll.BackgroundTransparency = 0.03
 _lllllIIIll.BorderSizePixel = 0x0
 _lllllIIIll.Text = "\075"
 _lllllIIIll.TextColor3 = Color3.fromRGB(0xFF, 0xFF, 0xFF)
 _lllllIIIll.Font = _IllIIIlIll.Title
 _lllllIIIll.TextSize = 0x14
 _lllllIIIll.AutoButtonColor = false
 _lllllIIIll.ZIndex = 0x2710
 _lllllIIIll.Parent = _llIIllIIlI
 _IlIIIIIlII(_lllllIIIll, 0xA)
 local _IllllllIIl = Instance.new("\085\073\083\116\114\111\107\101")
 _IllllllIIl.Color = Color3.fromRGB(0xFF, 0x64, 0x96)
 _IllllllIIl.Thickness = 0x2
 _IllllllIIl.Transparency = 0.18
 _IllllllIIl.LineJoinMode = Enum.LineJoinMode.Round
 _IllllllIIl.Parent = _lllllIIIll
 local _IlllIIIIIl = true
 task.spawn(function()
     local _llIIIlIIll = 0x0
     while _IlllIIIIIl and _llIIllIIlI and _llIIllIIlI.Parent do
         _llIIIlIIll = (_llIIIlIIll + 0.008) % 0x1
         local _IlIIlllIll = Color3.fromHSV(_llIIIlIIll, 0.85, 0x1)
         _IlllIIllII.Color = _IlIIlllIll
         _IllllllIIl.Color = _IlIIlllIll
         task.wait(0.03)
     end
 end)
 local _lIllIllIlI = (0.38+0.55+0.32+0.45+0.28) + (0.35+0.18) + (#"\075\114\101\105\110\072\117\098"*0.10+0.45+0.28)
 task.spawn(function()
     _IIllllIIlI:Play()
     _IllllIllII(_llllIIIllI, {Rotation = 0x1E},  0.38, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
     task.wait(0.38)
     _IllllIllII(_llllIIIllI, {Rotation = -0x1E}, 0.55, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut)
     task.wait(0.55)
     _IllllIllII(_llllIIIllI, {Rotation = 0x12},  0.32, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
     task.wait(0.32)
     _IllllIllII(_llllIIIllI, {Rotation = -0x12}, 0.45, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut)
     task.wait(0.45)
     _IllllIllII(_llllIIIllI, {Rotation = 0x0},   0.28, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
     task.wait(0.28)
     _IllllIllII(_llllIIIllI, {TextSize = 0x0, TextTransparency = 0x1}, 0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
     task.wait(0.35)
     _llllIIIllI:Destroy()
     task.wait(0.18)
     _IlIIllllll.Visible = true
     local _IIIIIIIIII = "\075\114\101\105\110\072\117\098"
     for i = 0x1, #_IIIIIIIIII do
         _IlIIllllll.Text = _IIIIIIIIII:sub(0x1, i)
         task.wait(0.10)
     end
     task.wait(0.45)
     _IllllIllII(_IlIIllllll, {TextTransparency = 0x1}, 0.28)
     task.delay(0.29, function()
         _IlIIllllll:Destroy()
         if _IIllllIIlI then _IIllllIIlI:Destroy() end
     end)
 end)
 task.delay(_lIllIllIlI, function()
     _IllllIllII(_IlIIlllIIl, {Size = _IlIlIIlllI, Position = _llIIlIIIII}, 0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
     task.delay(0.5, function()
         _llIIllIIlI.BackgroundTransparency = 0x1
         _lllllIIIll.TextTransparency = 0x1
         _IlllIIllII.Transparency = 0x1
         _IllllllIIl.Transparency = 0x1
         _llIIllIIlI.Visible = true
         _IllllIllII(_llIIllIIlI, {BackgroundTransparency = 0.05}, 0.35)
         _IllllIllII(_lllllIIIll, {TextTransparency = 0x0}, 0.35)
         _IllllIllII(_IlllIIllII, {Transparency = 0.18}, 0.35)
         _IllllIllII(_IllllllIIl, {Transparency = 0.18}, 0.35)
     end)
 end)
 local _lIlIIlllIl = Instance.new("\070\114\097\109\101")
 _lIlIIlllIl.Size = UDim2.new(0x1, 0x0, 0x0, 0x30)
 _lIlIIlllIl.BackgroundColor3 = _lllIIlIIll.TitleBg
 _lIlIIlllIl.BackgroundTransparency = 0.02
 _lIlIIlllIl.BorderSizePixel = 0x0
 _lIlIIlllIl.ZIndex = 0x2
 _lIlIIlllIl.Parent = _IlIIlllIIl
 _IlIIIIIlII(_lIlIIlllIl, 0x10)
 local _IIIlIIlIlI = Instance.new("\070\114\097\109\101")
 _IIIlIIlIlI.Size = UDim2.new(0x1, 0x0, 0x0, 0x10)
 _IIIlIIlIlI.Position = UDim2.new(0x0, 0x0, 0x1, -0x10)
 _IIIlIIlIlI.BackgroundColor3 = _lllIIlIIll.TitleBg
 _IIIlIIlIlI.BackgroundTransparency = 0.02
 _IIIlIIlIlI.BorderSizePixel = 0x0
 _IIIlIIlIlI.ZIndex = 0x2
 _IIIlIIlIlI.Parent = _lIlIIlllIl
 local _IllIIIllII = Instance.new("\070\114\097\109\101")
 _IllIIIllII.Size = UDim2.new(0x1, 0x0, 0x0, 0x1)
 _IllIIIllII.Position = UDim2.new(0x0, 0x0, 0x1, -0x1)
 _IllIIIllII.BackgroundColor3 = Color3.fromRGB(0xFF, 0xFF, 0xFF)
 _IllIIIllII.BackgroundTransparency = 0.88
 _IllIIIllII.BorderSizePixel = 0x0
 _IllIIIllII.ZIndex = 0x3
 _IllIIIllII.Parent = _lIlIIlllIl
 local _llIllIlIlI = Instance.new("\070\114\097\109\101")
 _llIllIlIlI.Size = UDim2.new(0.5, 0x0, 0x0, 0x1)
 _llIllIlIlI.Position = UDim2.new(0.25, 0x0, 0x1, -0x1)
 _llIllIlIlI.BackgroundColor3 = _lllIIlIIll.AccentBlue
 _llIllIlIlI.BackgroundTransparency = 0.55
 _llIllIlIlI.BorderSizePixel = 0x0
 _llIllIlIlI.ZIndex = 0x4
 _llIllIlIlI.Parent = _lIlIIlllIl
 _IlIIIIIlII(_llIllIlIlI, 0x1)
 local _lIIIIlIlll = Instance.new("\070\114\097\109\101")
 _lIIIIlIlll.Size = UDim2.new(0x1, -0xA0, 0x0, 0x2C)
 _lIIIIlIlll.Position = UDim2.new(0x0, 0x50, 0x0, 0x2)
 _lIIIIlIlll.BackgroundTransparency = 0x1
 _lIIIIlIlll.ZIndex = 0x3
 _lIIIIlIlll.Parent = _lIlIIlllIl
 local _IIlIIIlllI = Instance.new("\084\101\120\116\076\097\098\101\108")
 _IIlIIIlllI.Size = UDim2.new(0x1, 0x0, 0x0, 0x18)
 _IIlIIIlllI.BackgroundTransparency = 0x1
 _IIlIIIlllI.Text = _IIllllllll
 _IIlIIIlllI.TextColor3 = _lllIIlIIll.Text
 _IIlIIIlllI.Font = _IllIIIlIll.Title
 _IIlIIIlllI.TextSize = 0x10
 _IIlIIIlllI.TextXAlignment = Enum.TextXAlignment.Center
 _IIlIIIlllI.TextTruncate = Enum.TextTruncate.AtEnd
 _IIlIIIlllI.ZIndex = 0x3
 _IIlIIIlllI.Parent = _lIIIIlIlll
 local _IIIIIIIIIl = Instance.new("\084\101\120\116\076\097\098\101\108")
 _IIIIIIIIIl.Size = UDim2.new(0x1, 0x0, 0x0, 0xE)
 _IIIIIIIIIl.Position = UDim2.new(0x0, 0x0, 0x0, 0x19)
 _IIIIIIIIIl.BackgroundTransparency = 0x1
 _IIIIIIIIIl.Text = _IllIIIIlll
 _IIIIIIIIIl.TextColor3 = _lllIIlIIll.SubText
 _IIIIIIIIIl.Font = _IllIIIlIll.Body
 _IIIIIIIIIl.TextSize = 0xA
 _IIIIIIIIIl.TextXAlignment = Enum.TextXAlignment.Center
 _IIIIIIIIIl.TextTruncate = Enum.TextTruncate.AtEnd
 _IIIIIIIIIl.ZIndex = 0x3
 _IIIIIIIIIl.Parent = _lIIIIlIlll
 local _IllllIIlll = Instance.new("\070\114\097\109\101")
 _IllllIIlll.Size = UDim2.new(0x0, 0x34, 0x0, 0xE)
 _IllllIIlll.Position = UDim2.new(0x0, 0xE, 0x0, 0x11)
 _IllllIIlll.BackgroundTransparency = 0x1
 _IllllIIlll.ZIndex = 0x3
 _IllllIIlll.Parent = _lIlIIlllIl
 local function _lIllIIIlll(baseColor, xOff, iconChar, iconColor)
     local _llIlIlIlII = Instance.new("\084\101\120\116\066\117\116\116\111\110")
     _llIlIlIlII.Size = UDim2.new(0x0, 0xE, 0x0, 0xE)
     _llIlIlIlII.Position = UDim2.new(0x0, xOff, 0x0, 0x0)
     _llIlIlIlII.BackgroundColor3 = baseColor
     _llIlIlIlII.BorderSizePixel = 0x0
     _llIlIlIlII.Text = ""
     _llIlIlIlII.AutoButtonColor = false
     _llIlIlIlII.ZIndex = 0x4
     _llIlIlIlII.Parent = _IllllIIlll
     _IlIIIIIlII(_llIlIlIlII, 0x7)
     local _llIlIIIlIl = Instance.new("\084\101\120\116\076\097\098\101\108")
     _llIlIIIlIl.Size = UDim2.new(0x1, 0x0, 0x1, 0x0)
     _llIlIIIlIl.BackgroundTransparency = 0x1
     _llIlIIIlIl.Text = iconChar
     _llIlIIIlIl.TextColor3 = iconColor
     _llIlIIIlIl.Font = _IllIIIlIll.Bold
     _llIlIIIlIl.TextSize = 0x9
     _llIlIIIlIl.Visible = false
     _llIlIIIlIl.ZIndex = 0x5
     _llIlIIIlIl.Parent = _llIlIlIlII
     local _IIllIlIIlI = Color3.new(
         math.min(baseColor.R + 0.1, 0x1),
         math.min(baseColor.G + 0.1, 0x1),
         math.min(baseColor.B + 0.1, 0x1)
     )
     _llIlIlIlII.MouseEnter:Connect(function() _IllllIllII(_llIlIlIlII, {BackgroundColor3 = _IIllIlIIlI}, 0.12); _llIlIIIlIl.Visible = true end)
     _llIlIlIlII.MouseLeave:Connect(function() _IllllIllII(_llIlIlIlII, {BackgroundColor3 = baseColor}, 0.12); _llIlIIIlIl.Visible = false end)
     return _llIlIlIlII
 end
 local _lIIlIIIlll = _lIllIIIlll(Color3.fromRGB(0xFF, 0x5F,  0x56),  0x0,  "\088", Color3.fromRGB(0x82, 0x12, 0x12))
 local _lIIlllllIl   = _lIllIIIlll(Color3.fromRGB(0xFF, 0xBD, 0x2E),  0x14, "\045", Color3.fromRGB(0x82, 0x5A, 0x12))
 local _IIIIlllIll   = _lIllIIIlll(Color3.fromRGB(0x27,  0xC9, 0x3F),  0x28, "\043", Color3.fromRGB(0x12,  0x69, 0x12))
 local _lllIIlllIl = Instance.new("\070\114\097\109\101")
 _lllIIlllIl.Size = UDim2.new(0x1, 0x0, 0x1, -0x30)
 _lllIIlllIl.Position = UDim2.new(0x0, 0x0, 0x0, 0x30)
 _lllIIlllIl.BackgroundTransparency = 0x1
 _lllIIlllIl.BorderSizePixel = 0x0
 _lllIIlllIl.ClipsDescendants = true
 _lllIIlllIl.Parent = _IlIIlllIIl
 local _llllIIllII = Instance.new("\070\114\097\109\101")
 _llllIIllII.Size = UDim2.new(0x0, 0xB0, 0x1, 0x0)
 _llllIIllII.BackgroundColor3 = _lllIIlIIll.SidebarBg
 _llllIIllII.BackgroundTransparency = 0.01
 _llllIIllII.BorderSizePixel = 0x0
 _llllIIllII.Parent = _lllIIlllIl
 _IlIIIIIlII(_llllIIllII, 0x10)
 local _llIIIIIIIl = Instance.new("\070\114\097\109\101")
 _llIIIIIIIl.Size = UDim2.new(0x0, 0x1, 0x1, -0x18)
 _llIIIIIIIl.Position = UDim2.new(0x1, 0x0, 0x0, 0xC)
 _llIIIIIIIl.BackgroundColor3 = Color3.fromRGB(0xFF, 0xFF, 0xFF)
 _llIIIIIIIl.BackgroundTransparency = 0.88
 _llIIIIIIIl.BorderSizePixel = 0x0
 _llIIIIIIIl.Parent = _llllIIllII
 local _llllIIIllI = Instance.new("\070\114\097\109\101")
 _llllIIIllI.Size = UDim2.new(0x0, 0x1, 0.4, 0x0)
 _llllIIIllI.Position = UDim2.new(0x1, 0x0, 0.3, 0x0)
 _llllIIIllI.BackgroundColor3 = _lllIIlIIll.AccentBlue
 _llllIIIllI.BackgroundTransparency = 0.6
 _llllIIIllI.BorderSizePixel = 0x0
 _llllIIIllI.Parent = _llllIIllII
 local _llIlIlIIIl = Instance.new("\070\114\097\109\101")
 _llIlIlIIIl.Size = UDim2.new(0x1, -0x10, 0x0, 0x20)
 _llIlIlIIIl.Position = UDim2.new(0x0, 0x8, 0x0, 0x8)
 _llIlIlIIIl.BackgroundColor3 = _lllIIlIIll.SearchBg
 _llIlIlIIIl.BackgroundTransparency = 0.02
 _llIlIlIIIl.BorderSizePixel = 0x0
 _llIlIlIIIl.ZIndex = 0x3
 _llIlIlIIIl.Parent = _llllIIllII
 _IlIIIIIlII(_llIlIlIIIl, 0xA)
 _IlIIllIIIl(_llIlIlIIIl, Color3.fromRGB(0xFF, 0xFF, 0xFF), 0x1, 0.9)
 local _llIIIllllI = Instance.new("\085\073\083\116\114\111\107\101")
 _llIIIllllI.Color = Color3.fromRGB(0x32, 0x34, 0x48)
 _llIIIllllI.Thickness = 1.5
 _llIIIllllI.Transparency = 0.5
 _llIIIllllI.Parent = _llIlIlIIIl
 local _lIlIIllIlI = Instance.new("\084\101\120\116\076\097\098\101\108")
 _lIlIIllIlI.Size = UDim2.new(0x0, 0x12, 0x1, 0x0)
 _lIlIIllIlI.Position = UDim2.new(0x0, 0x7, 0x0, 0x0)
 _lIlIIllIlI.BackgroundTransparency = 0x1
 _lIlIIllIlI.Text = "\083"
 _lIlIIllIlI.TextSize = 0xA
 _lIlIIllIlI.ZIndex = 0x4
 _lIlIIllIlI.Parent = _llIlIlIIIl
 local _lllllIlIll = Instance.new("\084\101\120\116\066\111\120")
 _lllllIlIll.Size = UDim2.new(0x1, -0x1C, 0x1, 0x0)
 _lllllIlIll.Position = UDim2.new(0x0, 0x18, 0x0, 0x0)
 _lllllIlIll.BackgroundTransparency = 0x1
 _lllllIlIll.BorderSizePixel = 0x0
 _lllllIlIll.Text = ""
 _lllllIlIll.PlaceholderText = "\083\101\097\114\099\104\032\116\097\098\115\046\046\046"
 _lllllIlIll.PlaceholderColor3 = Color3.fromRGB(0x48, 0x48, 0x5C)
 _lllllIlIll.TextColor3 = Color3.fromRGB(0xD7, 0xD7, 0xE6)
 _lllllIlIll.Font = _IllIIIlIll.Body
 _lllllIlIll.TextSize = 0xB
 _lllllIlIll.ClearTextOnFocus = false
 _lllllIlIll.ZIndex = 0x4
 _lllllIlIll.Parent = _llIlIlIIIl
 local _lIlIIIIlll = Instance.new("\070\114\097\109\101")
 _lIlIIIIlll.Size = UDim2.new(0x1, -0x10, 0x0, 0x1)
 _lIlIIIIlll.Position = UDim2.new(0x0, 0x8, 0x0, 0x2E)
 _lIlIIIIlll.BackgroundColor3 = Color3.fromRGB(0xFF, 0xFF, 0xFF)
 _lIlIIIIlll.BackgroundTransparency = 0.88
 _lIlIIIIlll.BorderSizePixel = 0x0
 _lIlIIIIlll.Parent = _llllIIllII
 local _lllIlIIlII = Instance.new("\083\099\114\111\108\108\105\110\103\070\114\097\109\101")
 _lllIlIIlII.Size = UDim2.new(0x1, -0x2, 0x1, -0x36)
 _lllIlIIlII.Position = UDim2.new(0x0, 0x0, 0x0, 0x36)
 _lllIlIIlII.BackgroundTransparency = 0x1
 _lllIlIIlII.BorderSizePixel = 0x0
 _lllIlIIlII.ScrollBarThickness = 0x2
 _lllIlIIlII.ScrollBarImageColor3 = Color3.fromRGB(0x3C, 0x3E, 0x52)
 _lllIlIIlII.ScrollingDirection = Enum.ScrollingDirection.Y
 _lllIlIIlII.AutomaticCanvasSize = Enum.AutomaticSize.Y
 _lllIlIIlII.CanvasSize = UDim2.new(0x0, 0x0, 0x0, 0x0)
 _lllIlIIlII.Selectable = false
 _lllIlIIlII.Parent = _llllIIllII
 local _IlIIllIIlI = _lllllIllII(_lllIlIIlII, Enum.FillDirection.Vertical, 0x4)
 _IlIIllIIlI.HorizontalAlignment = Enum.HorizontalAlignment.Center
 _llllllllIl(_lllIlIIlII, 0x4, 0x2C, 0x0, 0x0)
 local _IllIIlIlll = Instance.new("\084\101\120\116\066\117\116\116\111\110")
 _IllIIlIlll.Size = UDim2.new(0x0, 0x12, 0x0, 0x12)
 _IllIIlIlll.Position = UDim2.new(0x0, 0x6, 0x1, -0x1A)
 _IllIIlIlll.BackgroundColor3 = Color3.fromRGB(0x18, 0x18, 0x22)
 _IllIIlIlll.BackgroundTransparency = 0.04
 _IllIIlIlll.BorderSizePixel = 0x0
 _IllIIlIlll.Text = "\083"
 _IllIIlIlll.TextColor3 = _lllIIlIIll.TabText
 _IllIIlIlll.Font = _IllIIIlIll.Medium
 _IllIIlIlll.TextSize = 0x9
 _IllIIlIlll.AutoButtonColor = false
 _IllIIlIlll.ZIndex = 0x3
 _IllIIlIlll.Parent = _llllIIllII
 _IlIIIIIlII(_IllIIlIlll, 0x5)
 _IllIIlIlll.MouseEnter:Connect(function()
     _IllllIllII(_IllIIlIlll, {BackgroundColor3 = Color3.fromRGB(0x2C, 0x2C, 0x3E)}, 0.12)
 end)
 _IllIIlIlll.MouseLeave:Connect(function()
     _IllllIllII(_IllIIlIlll, {BackgroundColor3 = _lllIIlIIll.TabInactive}, 0.12)
 end)
 local _IllllIIIII = Instance.new("\084\101\120\116\076\097\098\101\108")
 _IllllIIIII.Size = UDim2.new(0x1, -0x1E, 0x0, 0x12)
 _IllllIIIII.Position = UDim2.new(0x0, 0x1C, 0x1, -0x1A)
 _IllllIIIII.BackgroundTransparency = 0x1
 _IllllIIIII.Text = "\077\032\061\032\077\105\110\105\109\105\122\101"
 _IllllIIIII.TextColor3 = Color3.fromRGB(0x58, 0x58, 0x6C)
 _IllllIIIII.Font = _IllIIIlIll.Body
 _IllllIIIII.TextSize = 0x9
 _IllllIIIII.TextXAlignment = Enum.TextXAlignment.Left
 _IllllIIIII.ZIndex = 0x2
 _IllllIIIII.Parent = _llllIIllII
 local _IllIlIIllI = Instance.new("\070\114\097\109\101")
 _IllIlIIllI.Size = UDim2.new(0x1, -0xC2, 0x1, -0xC)
 _IllIlIIllI.Position = UDim2.new(0x0, 0xBC, 0x0, 0x6)
 _IllIlIIllI.BackgroundTransparency = 0x1
 _IllIlIIllI.BorderSizePixel = 0x0
 _IllIlIIllI.ClipsDescendants = true
 _IllIlIIllI.Parent = _lllIIlllIl
 local _llllIIllll = Instance.new("\070\114\097\109\101")
 _llllIIllll.Size = UDim2.new(0x1, 0x0, 0x1, 0x0)
 _llllIIllll.BackgroundTransparency = 0x1
 _llllIIllll.Parent = _IllIlIIllI
 local _lIlllllIlI      = {}
 local _IIllIIlIll    = nil
 local _lllIIIIIIl = false
 local _IIlIlllIIl    = 0x0
 local _IlIIlllllI = false
 local _lIllIIIIII = false
 _lllllIlIll:GetPropertyChangedSignal("\084\101\120\116"):Connect(function()
     local _IIllIIlIlI = _lllllIlIll.Text:lower()
     for name, data in pairs(_lIlllllIlI) do
         data.btn.Visible = (_IIllIIlIlI == "") or (name:lower():find(_IIllIIlIlI, 0x1, true) ~= nil)
     end
 end)
 local function _IIlIlIIIIl(name)
     if _lllIIIIIIl or _IIllIIlIll == name then return end
     _lllIIIIIIl = true
     for n, data in pairs(_lIlllllIlI) do
         local _IlIllllIII = (n == name)
         _IllllIllII(data.btn, {BackgroundColor3 = _IlIllllIII and _lllIIlIIll.TabActive or _lllIIlIIll.TabInactive}, 0.22)
         _IllllIllII(data.btn, {TextColor3 = _IlIllllIII and _lllIIlIIll.TabTextActive or _lllIIlIIll.TabText}, 0.22)
         local _IIIIlllIll = data.btn:FindFirstChild("\073\110\100\105\099\097\116\111\114")
         if _IIIIlllIll then _IllllIllII(_IIIIlllIll, {BackgroundTransparency = _IlIllllIII and 0x0 or 0x1}, 0.22) end
     end
     local _lllIlllIIl = _lIlllllIlI[name]
     local _llIlllllll = _lIlllllIlI[_IIllIIlIll]
     if _lllIlllIIl and _llIlllllll then
         _lllIlllIIl.frame.Visible = true
         local _lllIlIIllI = _lllIlllIIl.index > _llIlllllll.index
         _lllIlllIIl.frame.Position = UDim2.new(_lllIlIIllI and 0x1 or -0x1, 0x0, 0x0, 0x0)
         _IllllIllII(_llIlllllll.frame, {Position = UDim2.new(_lllIlIIllI and -0x1 or 0x1, 0x0, 0x0, 0x0)}, 0.3)
         _IllllIllII(_lllIlllIIl.frame,  {Position = UDim2.new(0x0, 0x0, 0x0, 0x0)}, 0.3)
         task.delay(0.3, function()
             if _llIlllllll.frame then _llIlllllll.frame.Visible = false end
         end)
     end
     _IIllIIlIll = name
     task.delay(0.3, function() _lllIIIIIIl = false end)
 end
 local _llllIIlIII = {}
 local _IlIlIIlllI = Enum.KeyCode.M
 local _lIllllIlII = Instance.new("\070\114\097\109\101")
 _lIllllIlII.Size = UDim2.new(0x0, 0x122, 0x0, 0x8C)
 _lIllllIlII.Position = UDim2.new(0.5, -0x91, 0.5, -0x46)
 _lIllllIlII.BackgroundColor3 = _lllIIlIIll.SettingsBg
 _lIllllIlII.BackgroundTransparency = 0x1
 _lIllllIlII.BorderSizePixel = 0x0
 _lIllllIlII.Visible = false
 _lIllllIlII.ZIndex = 0x64
 _lIllllIlII.Parent = _lllIIlllIl
 _IlIIIIIlII(_lIllllIlII, 0xE)
 _IlIIllIIIl(_lIllllIlII, Color3.fromRGB(0xFF, 0xFF, 0xFF), 0x1, 0.84)
 local _IIlIIIlIll = Instance.new("\084\101\120\116\066\117\116\116\111\110")
 _IIlIIIlIll.Size = UDim2.new(0x0, 0x16, 0x0, 0x16)
 _IIlIIIlIll.Position = UDim2.new(0x1, -0x1C, 0x0, 0x8)
 _IIlIIIlIll.BackgroundColor3 = Color3.fromRGB(0xC8, 0x3C, 0x3C)
 _IIlIIIlIll.BackgroundTransparency = 0.08
 _IIlIIIlIll.BorderSizePixel = 0x0
 _IIlIIIlIll.Text = "\120"
 _IIlIIIlIll.TextColor3 = Color3.fromRGB(0xFF, 0xFF, 0xFF)
 _IIlIIIlIll.Font = _IllIIIlIll.Bold
 _IIlIIIlIll.TextSize = 0xD
 _IIlIIIlIll.AutoButtonColor = false
 _IIlIIIlIll.ZIndex = 0x65
 _IIlIIIlIll.Parent = _lIllllIlII
 _IlIIIIIlII(_IIlIIIlIll, 0x6)
 local _IlIlIlIIII = nil
 local function _lIIlIIlIII()
     if _IlIlIlIIII then _IlIlIlIIII:Disconnect(); _IlIlIlIIII = nil end
     _IllllIllII(_lIllllIlII, {BackgroundTransparency = 0x1}, 0.18)
     task.delay(0.19, function()
         _lIllllIlII.Visible = false
         _lIllllIlII.BackgroundTransparency = 0.04
         for _, _IlIIlllIll in ipairs(_lIllllIlII:GetChildren()) do
             if _IlIIlllIll ~= _IIlIIIlIll then _IlIIlllIll:Destroy() end
         end
     end)
 end
 _IIlIIIlIll.MouseButton1Click:Connect(_lIIlIIlIII)
 local function _llIIIIIIII(_llllIIllll, x, y, sz, bold, col)
     local _lIlllIllII = Instance.new("\084\101\120\116\076\097\098\101\108")
     _lIlllIllII.Size = UDim2.new(0x0, 0xFA, 0x0, sz or 0x14)
     _lIlllIllII.Position = UDim2.new(0x0, x or 0xF, 0x0, y or 0x0)
     _lIlllIllII.BackgroundTransparency = 0x1
     _lIlllIllII.Text = _llllIIllll
     _lIlllIllII.TextColor3 = col or Color3.fromRGB(0xB4, 0xB4, 0xC6)
     _lIlllIllII.Font = bold and _IllIIIlIll.Header or _IllIIIlIll.Body
     _lIlllIllII.TextSize = sz or 0xC
     _lIlllIllII.TextXAlignment = Enum.TextXAlignment.Left
     _lIlllIllII.ZIndex = 0x65
     _lIlllIllII.Parent = _lIllllIlII
     return _lIlllIllII
 end
 local function _lIllIIlIIl()
     for _, _IlIIlllIll in ipairs(_lIllllIlII:GetChildren()) do
         if _IlIIlllIll ~= _IIlIIIlIll then _IlIIlllIll:Destroy() end
     end
     _llIIIIIIII("\083\101\116\116\105\110\103\115", 0xF, 0xA, 0x11, true, _lllIIlIIll.Text)
     _llIIIIIIII("\077\105\110\105\109\105\122\101\032\075\101\121\098\105\110\100", 0xF, 0x2A, 0xC, false, _lllIIlIIll.SubText)
     local _lllIlllIII = Instance.new("\084\101\120\116\066\117\116\116\111\110")
     _lllIlllIII.Size = UDim2.new(0x0, 0x54, 0x0, 0x1E)
     _lllIlllIII.Position = UDim2.new(0x0, 0xF, 0x0, 0x41)
     _lllIlllIII.BackgroundColor3 = _lllIIlIIll.KeybindBg
     _lllIlllIII.BackgroundTransparency = 0.03
     _lllIlllIII.BorderSizePixel = 0x0
     _lllIlllIII.Text = _IlIlIIlllI.Name
     _lllIlllIII.TextColor3 = _lllIIlIIll.TabTextActive
     _lllIlllIII.Font = _IllIIIlIll.Bold
     _lllIlllIII.TextSize = 0xB
     _lllIlllIII.AutoButtonColor = false
     _lllIlllIII.ZIndex = 0x65
     _lllIlllIII.Parent = _lIllllIlII
     _IlIIIIIlII(_lllIlllIII, 0x8)
     _IlIIllIIIl(_lllIlllIII, _lllIIlIIll.CompStroke, 0x1, 0.25)
     local _llIIIIllll = false
     _lllIlllIII.MouseButton1Click:Connect(function()
         if _llIIIIllll then return end
         if _IlIlIlIIII then _IlIlIlIIII:Disconnect(); _IlIlIlIIII = nil end
         _llIIIIllll = true
         _lllIlllIII.Text = "\046\046\046"
         _IlIlIlIIII = _IIlIllIIIl.InputBegan:Connect(function(_lIIlIIllII, gp)
             if _llIIIIllll and not gp and _lIIlIIllII.KeyCode ~= Enum.KeyCode.Unknown then
                 _IlIlIIlllI = _lIIlIIllII.KeyCode
                 _lllIlllIII.Text = _IlIlIIlllI.Name
                 _llIIIIllll = false
                 if _IlIlIlIIII then _IlIlIlIIII:Disconnect(); _IlIlIlIIII = nil end
             end
         end)
     end)
     _lIllllIlII.BackgroundTransparency = 0x1
     _lIllllIlII.Visible = true
     _IllllIllII(_lIllllIlII, {BackgroundTransparency = 0.04}, 0.22)
 end
 _IllIIlIlll.MouseButton1Click:Connect(_lIllIIlIIl)
 local _llIIIllIIl = Instance.new("\084\101\120\116\066\117\116\116\111\110")
 _llIIIllIIl.Size = UDim2.new(0x0, 0x12, 0x0, 0x12)
 _llIIIllIIl.Position = UDim2.new(0x1, -0x12, 0x1, -0x12)
 _llIIIllIIl.BackgroundTransparency = 0x1
 _llIIIllIIl.Text = ""
 _llIIIllIIl.ZIndex = 0xA
 _llIIIllIIl.Parent = _IlIIlllIIl
 local _IIlIIIlIll = Instance.new("\084\101\120\116\076\097\098\101\108")
 _IIlIIIlIll.Size = UDim2.new(0x0, 0xC, 0x0, 0xC)
 _IIlIIIlIll.Position = UDim2.new(0x0, 0x3, 0x0, 0x3)
 _IIlIIIlIll.BackgroundTransparency = 0x1
 _IIlIIIlIll.Text = "\043"
 _IIlIIIlIll.TextColor3 = _lllIIlIIll.SubText
 _IIlIIIlIll.Font = _IllIIIlIll.Body
 _IIlIIIlIll.TextSize = 0xA
 _IIlIIIlIll.Rotation = 0x2D
 _IIlIIIlIll.ZIndex = 0xB
 _IIlIIIlIll.Parent = _llIIIllIIl
 local _IIIIlIIIll = false
 local _lIIllIlIIl, _rsSize = nil, nil
 _llIIIllIIl.InputBegan:Connect(function(_lIIlIIllII)
     if _lIIlIIllII.UserInputType == Enum.UserInputType.MouseButton1 or _lIIlIIllII.UserInputType == Enum.UserInputType.Touch then
         if _IlIIlllllI then return end
         _IIIIlIIIll = true
         _lIIllIlIIl = _lIIlIIllII.Position
         _rsSize = _IlIIlllIIl.AbsoluteSize
     end
 end)
 _IIIIIIlIIl(_IIlIllIIIl.InputChanged, function(_lIIlIIllII)
     if _IIIIlIIIll and (_lIIlIIllII.UserInputType == Enum.UserInputType.MouseMovement or _lIIlIIllII.UserInputType == Enum.UserInputType.Touch) then
         local _IlllIIllIl = _lIIlIIllII.Position - _lIIllIlIIl
         local _llIIIlIlll = math.clamp(_rsSize.X + _IlllIIllIl.X, 0x190, 0x3E8)
         local _llIIIlIIll = math.clamp(_rsSize.Y + _IlllIIllIl.Y, 0x12C, 0x2BC)
         _IlIIlllIIl.Size = UDim2.new(0x0, _llIIIlIlll, 0x0, _llIIIlIIll)
     end
 end)
 _IIIIIIlIIl(_IIlIllIIIl.InputEnded, function(_lIIlIIllII)
     if _lIIlIIllII.UserInputType == Enum.UserInputType.MouseButton1 or _lIIlIIllII.UserInputType == Enum.UserInputType.Touch then
         _IIIIlIIIll = false
     end
 end)
 local function _IlIIlllIll()
     _IlIIlllllI = true
     _lIllIIIIII = false
     _lllIIlllIl.Visible = false
     _IIIlIIlIlI.Visible = false
     _IllIIIllII.Visible = false
     _llIllIlIlI.Visible = false
     _llIIIllIIl.Visible = false
     _IlIIlllIIl.ClipsDescendants = true
     _IllllIllII(_lIIIIllIIl, {Thickness = 0x0}, 0.28)
     _IllllIllII(_IlIIIlIIll, {Thickness = 0x0}, 0.28)
     _IllllIllII(_lIlllllIII, {Thickness = 0x0}, 0.28)
     _IllllIllII(_IlIIlllIIl, {
         Size = UDim2.new(0x0, 0x118, 0x0, 0x2D),
         Position = UDim2.new(0x0, 0x14, 0x0, 0x14)
     }, 0.32, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
 end
 local function _llllllllIl()
     _IlIIlllllI = false
     _lllIIlllIl.Visible = true
     _IIIlIIlIlI.Visible = true
     _IllIIIllII.Visible = true
     _llIllIlIlI.Visible = true
     _llIIIllIIl.Visible = true
     _IlIIlllIIl.ClipsDescendants = false
     _IllllIllII(_lIIIIllIIl, {Thickness = 1.5}, 0.3)
     _IllllIllII(_IlIIIlIIll, {Thickness = 0x3}, 0.3)
     _IllllIllII(_lIlllllIII, {Thickness = 0x6}, 0.3)
     local _lIIllIlIll = _lIllIIIIII and _IllIllIIlI or _IlIlIIlllI
     local _IllIlIIIlI = _lIllIIIIII
         and UDim2.new(0.5, -_IllIllIIlI.X.Offset/0x2, 0.5, -_IllIllIIlI.Y.Offset/0x2)
         or _llIIlIIIII
     _IllllIllII(_IlIIlllIIl, {Size = _lIIllIlIll, Position = _IllIlIIIlI}, 0.32, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
 end
 local _IlIIIIIIll
 _IlIIIIIIll = _IIlIllIIIl.InputBegan:Connect(function(_lIIlIIllII, gp)
     if gp then return end
     if _lIIlIIllII.KeyCode == _IlIlIIlllI then
         if _IlIIlllllI then _llllllllIl() else _IlIIlllIll() end
     end
 end)
 _lIIllllIll(_IlIIIIIIll)
 _lllllIIIll.MouseButton1Click:Connect(function()
     if _IlIIlllllI then _llllllllIl() else _IlIIlllIll() end
 end)
 _lllllIIIll.MouseEnter:Connect(function()
     _IllllIllII(_lllllIIIll, {BackgroundColor3 = Color3.fromRGB(0x1A, 0x1A, 0x26)}, 0.12)
     _IllllIllII(_IlllIIllII, {Thickness = 0x3}, 0.12)
     _IllllIllII(_IllllllIIl, {Thickness = 0x3}, 0.12)
 end)
 _lllllIIIll.MouseLeave:Connect(function()
     _IllllIllII(_lllllIIIll, {BackgroundColor3 = _lllIIlIIll.ResetBtnBg}, 0.12)
     _IllllIllII(_IlllIIllII, {Thickness = 0x2}, 0.12)
     _IllllIllII(_IllllllIIl, {Thickness = 0x2}, 0.12)
 end)
 function _llllIIlIII:Destroy()
     _IlllIIIIIl = false
     _IlIIIlIllI = false
     if _llIIllIIlI and _llIIllIIlI.Parent then _llIIllIIlI:Destroy() end
     for _, _IlIIlllIll in ipairs(_llIllIIIlI) do pcall(function() _IlIIlllIll:Disconnect() end) end
     _lIlIlllIlI()
     _IllllIllII(_IlIIlllIIl, {Size = UDim2.new(0x0, 0x0, 0x0, 0x0), BackgroundTransparency = 0x1}, 0.2)
     task.delay(0.21, function()
         if _lIlllIIIll and _lIlllIIIll.Parent then _lIlllIIIll:Destroy() end
     end)
 end
 function _llllIIlIII:GetFrame() return _IlIIlllIIl end
 function _llllIIlIII:CreateTab(name, icon)
     local _llIIlllIlI = (_IIlIlllIIl == 0x0)
     local _IIIllllllI = _IIlIlllIIl
     _IIlIlllIIl = _IIlIlllIIl + 0x1
     local _lIIllIIlIl = Instance.new("\084\101\120\116\066\117\116\116\111\110")
     _lIIllIIlIl.Name  = name
     _lIIllIIlIl.Size  = UDim2.new(0.9, 0x0, 0x0, 0x24)
     _lIIllIIlIl.BackgroundColor3 = _llIIlllIlI and _lllIIlIIll.TabActive or _lllIIlIIll.TabInactive
     _lIIllIIlIl.BackgroundTransparency = 0.02
     _lIIllIIlIl.BorderSizePixel = 0x0
     _lIIllIIlIl.Text = "\032\032" .. (icon and icon .. "\032\032" or "") .. name
     _lIIllIIlIl.TextColor3 = _llIIlllIlI and _lllIIlIIll.TabTextActive or _lllIIlIIll.TabText
     _lIIllIIlIl.Font = _IllIIIlIll.Medium
     _lIIllIIlIl.TextSize = 0xC
     _lIIllIIlIl.TextXAlignment = Enum.TextXAlignment.Left
     _lIIllIIlIl.AutoButtonColor = false
     _lIIllIIlIl.LayoutOrder = _IIIllllllI
     _lIIllIIlIl.Parent = _lllIlIIlII
     _IlIIIIIlII(_lIIllIIlIl, 0xA)
     if _llIIlllIlI then _IlIIllIIIl(_lIIllIIlIl, Color3.fromRGB(0xFF, 0xFF, 0xFF), 0x1, 0.88) end
     local _IlIllIIllI = Instance.new("\070\114\097\109\101")
     _IlIllIIllI.Name = "\073\110\100\105\099\097\116\111\114"
     _IlIllIIllI.Size = UDim2.new(0x0, 0x3, 0x0, 0x12)
     _IlIllIIllI.Position = UDim2.new(0x0, 0x0, 0.5, -0x9)
     _IlIllIIllI.BackgroundColor3 = _lllIIlIIll.AccentBlue
     _IlIllIIllI.BackgroundTransparency = _llIIlllIlI and 0x0 or 0x1
     _IlIllIIllI.BorderSizePixel = 0x0
     _IlIIIIIlII(_IlIllIIllI, 0x2)
     _IlIllIIllI.Parent = _lIIllIIlIl
     _lIIllIIlIl.MouseEnter:Connect(function()
         if _IIllIIlIll ~= name then _IllllIllII(_lIIllIIlIl, {BackgroundColor3 = Color3.fromRGB(0x1E, 0x1E, 0x2E)}, 0.14) end
     end)
     _lIIllIIlIl.MouseLeave:Connect(function()
         if _IIllIIlIll ~= name then _IllllIllII(_lIIllIIlIl, {BackgroundColor3 = _lllIIlIIll.TabInactive}, 0.14) end
     end)
     local _IIlIIllllI = Instance.new("\070\114\097\109\101")
     _IIlIIllllI.Size = UDim2.new(0x1, 0x0, 0x1, 0x0)
     _IIlIIllllI.Position = UDim2.new(_llIIlllIlI and 0x0 or 0x1, 0x0, 0x0, 0x0)
     _IIlIIllllI.BackgroundTransparency = 0x1
     _IIlIIllllI.Visible = _llIIlllIlI
     _IIlIIllllI.Parent = _llllIIllll
     local _IllIlIIIIl = Instance.new("\083\099\114\111\108\108\105\110\103\070\114\097\109\101")
     _IllIlIIIIl.Size = UDim2.new(0x1, 0x0, 0x1, 0x0)
     _IllIlIIIIl.BackgroundTransparency = 0x1
     _IllIlIIIIl.BorderSizePixel = 0x0
     _IllIlIIIIl.ScrollBarThickness = 0x2
     _IllIlIIIIl.ScrollBarImageColor3 = Color3.fromRGB(0x37, 0x3A, 0x50)
     _IllIlIIIIl.ScrollingDirection = Enum.ScrollingDirection.Y
     _IllIlIIIIl.AutomaticCanvasSize = Enum.AutomaticSize.Y
     _IllIlIIIIl.CanvasSize = UDim2.new(0x0, 0x0, 0x0, 0x0)
     _IllIlIIIIl.Selectable = false
     _IllIlIIIIl.Parent = _IIlIIllllI
     local _lIIIIIllIl = _lllllIllII(_IllIlIIIIl, Enum.FillDirection.Vertical, 0x6)
     _lIIIIIllIl.HorizontalAlignment = Enum.HorizontalAlignment.Center
     _llllllllIl(_IllIlIIIIl, 0xA, 0xA, 0x0, 0x0)
     _lIlllllIlI[name] = {frame = _IIlIIllllI, _llIlIlIlII = _lIIllIIlIl, index = _IIIllllllI}
     if _llIIlllIlI then _IIllIIlIll = name end
     _IIIIIIlIIl(_lIIllIIlIl.MouseButton1Click, function()
         _IIlIlIIIIl(name)
         local _lllIIlIIII = _lIIllIIlIl:FindFirstChildOfClass("\085\073\083\116\114\111\107\101")
         if not _lllIIlIIII then _IlIIllIIIl(_lIIllIIlIl, Color3.fromRGB(0xFF, 0xFF, 0xFF), 0x1, 0.88) end
         for n, data in pairs(_lIlllllIlI) do
             if n ~= name then
                 local _lIIllIlIll = data.btn:FindFirstChildOfClass("\085\073\083\116\114\111\107\101")
                 if _lIIllIlIll then _lIIllIlIll:Destroy() end
             end
         end
     end)
     local _lIlllIllII = {}
     function _lIlllIllII:CreateSection(sTitle, collapsed)
         collapsed = collapsed ~= false
         local _IIlllllllI = Instance.new("\070\114\097\109\101")
         _IIlllllllI.Name = "\083\101\099\116\105\111\110\095" .. sTitle
         _IIlllllllI.Size = UDim2.new(0.97, 0x0, 0x0, 0x24)
         _IIlllllllI.BackgroundTransparency = 0x1
         _IIlllllllI.BorderSizePixel = 0x0
         _IIlllllllI.LayoutOrder = 0x0
         _IIlllllllI.AutomaticSize = Enum.AutomaticSize.None
         _IIlllllllI.ClipsDescendants = true
         _IIlllllllI.Parent = _IllIlIIIIl
         local _IllIlIlllI = _lllllIllII(_IIlllllllI, Enum.FillDirection.Vertical, 0x0)
         _IllIlIlllI.HorizontalAlignment = Enum.HorizontalAlignment.Center
         local _IIIIlIlIIl = Instance.new("\070\114\097\109\101")
         _IIIIlIlIIl.Name = "\083\101\099\116\105\111\110\072\101\097\100\101\114"
         _IIIIlIlIIl.Size = UDim2.new(0x1, 0x0, 0x0, 0x24)
         _IIIIlIlIIl.BackgroundColor3 = _lllIIlIIll.SectionHdr
         _IIIIlIlIIl.BackgroundTransparency = 0.03
         _IIIIlIlIIl.BorderSizePixel = 0x0
         _IIIIlIlIIl.LayoutOrder = 0x0
         _IIIIlIlIIl.Parent = _IIlllllllI
         _IlIIIIIlII(_IIIIlIlIIl, 0xB)
         _IlIIllIIIl(_IIIIlIlIIl, Color3.fromRGB(0xFF, 0xFF, 0xFF), 0x1, 0.9)
         local _llIlllIIII = Instance.new("\070\114\097\109\101")
         _llIlllIIII.Size = UDim2.new(0x0, 0x3, 0.55, 0x0)
         _llIlllIIII.Position = UDim2.new(0x0, 0x9, 0.225, 0x0)
         _llIlllIIII.BackgroundColor3 = _lllIIlIIll.AccentBlue
         _llIlllIIII.BackgroundTransparency = 0.2
         _llIlllIIII.BorderSizePixel = 0x0
         _llIlllIIII.Parent = _IIIIlIlIIl
         _IlIIIIIlII(_llIlllIIII, 0x2)
         local _IIIIlIlllI = Instance.new("\084\101\120\116\076\097\098\101\108")
         _IIIIlIlllI.Size = UDim2.new(0x1, -0x3C, 0x1, 0x0)
         _IIIIlIlllI.Position = UDim2.new(0x0, 0x14, 0x0, 0x0)
         _IIIIlIlllI.BackgroundTransparency = 0x1
         _IIIIlIlllI.Text = sTitle
         _IIIIlIlllI.TextColor3 = _lllIIlIIll.Text
         _IIIIlIlllI.Font = _IllIIIlIll.Header
         _IIIIlIlllI.TextSize = 0xD
         _IIIIlIlllI.TextXAlignment = Enum.TextXAlignment.Left
         _IIIIlIlllI.Parent = _IIIIlIlIIl
         local _IIlIllIIII = Instance.new("\084\101\120\116\076\097\098\101\108")
         _IIlIllIIII.Size = UDim2.new(0x0, 0x1C, 0x0, 0x1C)
         _IIlIllIIII.Position = UDim2.new(0x1, -0x22, 0x0, 0x4)
         _IIlIllIIII.BackgroundTransparency = 0x1
         _IIlIllIIII.Text = "\062"
         _IIlIllIIII.TextColor3 = _lllIIlIIll.AccentBlue
         _IIlIllIIII.Font = _IllIIIlIll.Bold
         _IIlIllIIII.TextSize = 0xA
         _IIlIllIIII.Rotation = collapsed and 0x0 or 0x5A
         _IIlIllIIII.Parent = _IIIIlIlIIl
         local _IIIIlIlIII = Instance.new("\070\114\097\109\101")
         _IIIIlIlIII.Name = "\083\101\099\116\105\111\110\067\111\110\116\097\105\110\101\114"
         _IIIIlIlIII.Size = UDim2.new(0x1, 0x0, 0x0, 0x0)
         _IIIIlIlIII.AutomaticSize = Enum.AutomaticSize.None
         _IIIIlIlIII.BackgroundColor3 = _lllIIlIIll.SectionBg
         _IIIIlIlIII.BackgroundTransparency = 0.04
         _IIIIlIlIII.BorderSizePixel = 0x0
         _IIIIlIlIII.LayoutOrder = 0x1
         _IIIIlIlIII.ClipsDescendants = false
         _IIIIlIlIII.Visible = not collapsed
         _IIIIlIlIII.Parent = _IIlllllllI
         _IlIIIIIlII(_IIIIlIlIII, 0xB)
         _IlIIllIIIl(_IIIIlIlIII, Color3.fromRGB(0xFF, 0xFF, 0xFF), 0x1, 0.92)
         local _lllIIIIlll = _lllllIllII(_IIIIlIlIII, Enum.FillDirection.Vertical, 0x5)
         _lllIIIIlll.HorizontalAlignment = Enum.HorizontalAlignment.Center
         _llllllllIl(_IIIIlIlIII, 0x6, 0x6, 0x0, 0x0)
         local _IIIIIlIIII = collapsed
         local _IIlIIlllII = false
         local function _lIIllIIllI()
             local _IIIlllIIIl = 0xC
             for _, child in ipairs(_IIIIlIlIII:GetChildren()) do
                 if child:IsA("\070\114\097\109\101") or child:IsA("\083\099\114\111\108\108\105\110\103\070\114\097\109\101") then
                     if child.Visible then
                         local _IIllIllIII = child.AbsoluteSize.Y > 0x0 and child.AbsoluteSize.Y or child.Size.Y.Offset
                         _IIIlllIIIl = _IIIlllIIIl + _IIllIllIII + 0x5
                     end
                 end
             end
             return math.max(_IIIlllIIIl, 0xC)
         end
         local function _IIIllIIlII()
             task.wait()
             if _IIIIIlIIII then
                 _IIIIlIlIII.Size = UDim2.new(0x1, 0x0, 0x0, 0x0)
                 _IllllIllII(_IIlllllllI, {Size = UDim2.new(0.97, 0x0, 0x0, 0x24)}, 0.26, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
             else
                 if _IIlIIlllII then return end
                 local _lllIIIIIlI = _lIIllIIllI()
                 _IIIIlIlIII.Size = UDim2.new(0x1, 0x0, 0x0, _lllIIIIIlI)
                 _IllllIllII(_IIlllllllI, {Size = UDim2.new(0.97, 0x0, 0x0, 0x24 + _lllIIIIIlI + 0x4)}, 0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
             end
         end
         local _lIIIIlIIII = Instance.new("\084\101\120\116\066\117\116\116\111\110")
         _lIIIIlIIII.Size = UDim2.new(0x1, 0x0, 0x1, 0x0)
         _lIIIIlIIII.BackgroundTransparency = 0x1
         _lIIIIlIIII.Text = ""
         _lIIIIlIIII.ZIndex = 0x5
         _lIIIIlIIII.Parent = _IIIIlIlIIl
         local _lIIllIlIll = false
         _lIIIIlIIII.MouseButton1Click:Connect(function()
             if _lIIllIlIll then return end
             _lIIllIlIll = true
             _IIIIIlIIII = not _IIIIIlIIII
             if not _IIIIIlIIII then
                 _IIIIlIlIII.Visible = true
                 _IllllIllII(_IIlIllIIII, {Rotation = 0x5A}, 0.24)
                 _IIIllIIlII()
                 task.delay(0.32, function() _lIIllIlIll = false end)
             else
                 _IllllIllII(_IIlIllIIII, {Rotation = 0x0}, 0.24)
                 _IllllIllII(_IIlllllllI, {Size = UDim2.new(0.97, 0x0, 0x0, 0x24)}, 0.26, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
                 task.delay(0.27, function()
                     if _IIIIIlIIII then _IIIIlIlIII.Visible = false end
                     _lIIllIlIll = false
                 end)
             end
         end)
         _IIIIlIlIIl.MouseEnter:Connect(function()
             _IllllIllII(_IIIIlIlIIl, {BackgroundColor3 = Color3.fromRGB(0x1C, 0x1C, 0x28)}, 0.14)
             _IllllIllII(_llIlllIIII, {Size = UDim2.new(0x0, 0x4, 0.55, 0x0)}, 0.14)
         end)
         _IIIIlIlIIl.MouseLeave:Connect(function()
             _IllllIllII(_IIIIlIlIIl, {BackgroundColor3 = _lllIIlIIll.SectionHdr}, 0.14)
             _IllllIllII(_llIlllIIII, {Size = UDim2.new(0x0, 0x3, 0.55, 0x0)}, 0.14)
         end)
         if not collapsed then task.delay(0.05, _IIIllIIlII) end
         local _llIIlIllIl = {}
         local _lllIllllIl = 0x0
         local function _lllIIlIlIl() _lllIllllIl = _lllIllllIl + 0x1; return _lllIllllIl end
         local function _lIIlIIlllI(_IIllIllIII)
             local _lIlIIlIIll = Instance.new("\070\114\097\109\101")
             _lIlIIlIIll.Size = UDim2.new(0.96, 0x0, 0x0, _IIllIllIII)
             _lIlIIlIIll.BackgroundColor3 = _lllIIlIIll.ComponentBg
             _lIlIIlIIll.BackgroundTransparency = 0.03
             _lIlIIlIIll.BorderSizePixel = 0x0
             _lIlIIlIIll.LayoutOrder = _lllIIlIlIl()
             _lIlIIlIIll.Parent = _IIIIlIlIII
             _IlIIIIIlII(_lIlIIlIIll, 0xA)
             _IlIIllIIIl(_lIlIIlIIll, Color3.fromRGB(0xFF, 0xFF, 0xFF), 0x1, 0.92)
             local _IIIllIIlIl = Instance.new("\085\073\083\116\114\111\107\101")
             _IIIllIIlIl.Color = Color3.fromRGB(0x30, 0x32, 0x46)
             _IIIllIIlIl.Thickness = 1.5
             _IIIllIIlIl.Transparency = 0.6
             _IIIllIIlIl.Parent = _lIlIIlIIll
             return _lIlIIlIIll
         end
         function _llIIlIllIl:CreateLabel(_llllIIllll)
             local _lIlIIlIIll = Instance.new("\070\114\097\109\101")
             _lIlIIlIIll.Size = UDim2.new(0.96, 0x0, 0x0, 0x0)
             _lIlIIlIIll.AutomaticSize = Enum.AutomaticSize.Y
             _lIlIIlIIll.BackgroundTransparency = 0x1
             _lIlIIlIIll.BorderSizePixel = 0x0
             _lIlIIlIIll.LayoutOrder = _lllIIlIlIl()
             _lIlIIlIIll.Parent = _IIIIlIlIII
             _llllllllIl(_lIlIIlIIll, 0x6, 0x6, 0x8, 0x8)
             _lIlIIlIIll:GetPropertyChangedSignal("\065\098\115\111\108\117\116\101\083\105\122\101"):Connect(function()
                 if not _IIIIIlIIII then _IIIllIIlII() end
             end)
             local _lIlllIllII = Instance.new("\084\101\120\116\076\097\098\101\108")
             _lIlllIllII.Size = UDim2.new(0x1, 0x0, 0x0, 0x0)
             _lIlllIllII.AutomaticSize = Enum.AutomaticSize.Y
             _lIlllIllII.BackgroundTransparency = 0x1
             _lIlllIllII.Text = _llllIIllll
             _lIlllIllII.TextColor3 = _lllIIlIIll.LabelText
             _lIlllIllII.Font = _IllIIIlIll.Body
             _lIlllIllII.TextSize = 0xB
             _lIlllIllII.TextXAlignment = Enum.TextXAlignment.Left
             _lIlllIllII.TextWrapped = true
             _lIlllIllII.Parent = _lIlIIlIIll
             local _lIlIIIlIll = {}
             function _lIlIIIlIll:SetText(_lIIllIlIIl) _lIlllIllII.Text = _lIIllIlIIl; task.defer(function() if not _IIIIIlIIII then _IIIllIIlII() end end) end
             function _lIlIIIlIll:SetVisible(v) _lIlIIlIIll.Visible = v; _IIIllIIlII() end
             function _lIlIIIlIll:Destroy() _lIlIIlIIll:Destroy(); _IIIllIIlII() end
             function _lIlIIIlIll:UpdateCallback() end
             return _lIlIIIlIll
         end
         local function _IlIIlllllI(_llllIIllll, _lllIlIIIll, bg, accentColor, confirm)
             local _lIlIIlIIll = _lIIlIIlllI(0x30)
             local _lIlIllIIlI = Instance.new("\070\114\097\109\101")
             _lIlIllIIlI.Size = UDim2.new(0x0, 0x3, 0.6, 0x0)
             _lIlIllIIlI.Position = UDim2.new(0x0, 0x6, 0.2, 0x0)
             _lIlIllIIlI.BackgroundColor3 = accentColor
             _lIlIllIIlI.BorderSizePixel = 0x0
             _lIlIllIIlI.Name = "\065\099\099\101\110\116"
             _lIlIllIIlI.Parent = _lIlIIlIIll
             _IlIIIIIlII(_lIlIllIIlI, 0x2)
             local _lIlllIllII = Instance.new("\084\101\120\116\076\097\098\101\108")
             _lIlllIllII.Size = UDim2.new(0x1, -0x60, 0x0, 0x12)
             _lIlllIllII.Position = UDim2.new(0x0, 0x12, 0x0, 0x8)
             _lIlllIllII.BackgroundTransparency = 0x1
             _lIlllIllII.Text = _llllIIllll
             _lIlllIllII.TextColor3 = _lllIIlIIll.Text
             _lIlllIllII.Font = _IllIIIlIll.Bold
             _lIlllIllII.TextSize = 0xC
             _lIlllIllII.TextXAlignment = Enum.TextXAlignment.Left
             _lIlllIllII.TextTruncate = Enum.TextTruncate.AtEnd
             _lIlllIllII.Parent = _lIlIIlIIll
             local _IllIllIlll = Instance.new("\084\101\120\116\076\097\098\101\108")
             _IllIllIlll.Size = UDim2.new(0x1, -0x60, 0x0, 0xE)
             _IllIllIlll.Position = UDim2.new(0x0, 0x12, 0x0, 0x1A)
             _IllIllIlll.BackgroundTransparency = 0x1
             _IllIllIlll.Text = ""
             _IllIllIlll.TextColor3 = _lllIIlIIll.SubText
             _IllIllIlll.Font = _IllIIIlIll.Body
             _IllIllIlll.TextSize = 0x9
             _IllIllIlll.TextXAlignment = Enum.TextXAlignment.Left
             _IllIllIlll.Visible = false
             _IllIllIlll.Name = "\083\117\098\076\097\098\101\108"
             _IllIllIlll.Parent = _lIlIIlIIll
             local _lllIIlIIIl = Instance.new("\084\101\120\116\066\117\116\116\111\110")
             _lllIIlIIIl.Size = UDim2.new(0x0, 0x4A, 0x0, 0x1E)
             _lllIIlIIIl.Position = UDim2.new(0x1, -0x52, 0x0, 0x9)
             _lllIIlIIIl.BackgroundColor3 = bg
             _lllIIlIIIl.BackgroundTransparency = 0.02
             _lllIIlIIIl.BorderSizePixel = 0x0
             _lllIIlIIIl.Text = "\067\076\073\067\075"
             _lllIIlIIIl.TextColor3 = Color3.fromRGB(0xFF, 0xFF, 0xFF)
             _lllIIlIIIl.Font = _IllIIIlIll.Bold
             _lllIIlIIIl.TextSize = 0xB
             _lllIIlIIIl.AutoButtonColor = false
             _lllIIlIIIl.Parent = _lIlIIlIIll
             _IlIIIIIlII(_lllIIlIIIl, 0x8)
             _IlIIllIIIl(_lllIIlIIIl, bg, 0x1, 0.3)
             local _lllllIIlII = false
             local _lllIlIIIII = "\067\076\073\067\075"
             local _lIlIIIIllI = true
             _lIlIIlIIll.MouseEnter:Connect(function()
                 if not _lIlIIIIllI then return end
                 _IllllIllII(_lIlIllIIlI, {Size = UDim2.new(0x0, 0x5, 0.6, 0x0)}, 0.12)
                 _IllllIllII(_lIlIIlIIll, {BackgroundColor3 = Color3.fromRGB(0x18, 0x18, 0x24)}, 0.12)
             end)
             _lIlIIlIIll.MouseLeave:Connect(function()
                 if not _lIlIIIIllI then return end
                 _IllllIllII(_lIlIllIIlI, {Size = UDim2.new(0x0, 0x3, 0.6, 0x0)}, 0.12)
                 _IllllIllII(_lIlIIlIIll, {BackgroundColor3 = _lllIIlIIll.ComponentBg}, 0.12)
             end)
             _lllIIlIIIl.MouseEnter:Connect(function()
                 if not _lIlIIIIllI then return end
                 _IllllIllII(_lllIIlIIIl, {BackgroundColor3 = Color3.new(math.min(bg.R+0.1,0x1), math.min(bg.G+0.1,0x1), math.min(bg.B+0.1,0x1))}, 0.12)
             end)
             _lllIIlIIIl.MouseLeave:Connect(function()
                 if not _lIlIIIIllI then return end
                 _IllllIllII(_lllIIlIIIl, {BackgroundColor3 = bg}, 0.12)
             end)
             _lllIIlIIIl.MouseButton1Click:Connect(function()
                 if not _lIlIIIIllI then return end
                 if confirm then
                     if not _lllllIIlII then
                         _lllllIIlII = true; _lllIIlIIIl.Text = "\083\085\082\069\063"
                         _IllllIllII(_lllIIlIIIl, {BackgroundColor3 = Color3.fromRGB(0xD2, 0x91, 0x0)}, 0.18)
                         task.delay(2.5, function()
                             if _lllllIIlII then _lllllIIlII = false; _lllIIlIIIl.Text = _lllIlIIIII; _IllllIllII(_lllIIlIIIl, {BackgroundColor3 = bg}, 0.18) end
                         end)
                     else
                         _lllllIIlII = false; _lllIIlIIIl.Text = _lllIlIIIII
                         _IllllIllII(_lllIIlIIIl, {BackgroundColor3 = bg}, 0.18); _lllIlIIIll()
                     end
                 else
                     _IllllIllII(_lllIIlIIIl, {Size = UDim2.new(0x0, 0x46, 0x0, 0x1C)}, 0.06)
                     task.delay(0.06, function() _IllllIllII(_lllIIlIIIl, {Size = UDim2.new(0x0, 0x4A, 0x0, 0x1E)}, 0.1) end)
                     _lllIlIIIll()
                 end
             end)
             local _lIlIIIlIll = {}
             function _lIlIIIlIll:SetText(_lIIllIlIIl, _lIIllIlIll) _lIlllIllII.Text = _lIIllIlIIl; if _lIIllIlIll then _IllIllIlll.Text = _lIIllIlIll; _IllIllIlll.Visible = true end end
             function _lIlIIIlIll:SetActionText(_lIIllIlIIl) _lllIIlIIIl.Text = _lIIllIlIIl; _lllIlIIIII = _lIIllIlIIl end
             function _lIlIIIlIll:SetEnabled(e)
                 _lIlIIIIllI = e; _lllIIlIIIl.Active = e
                 _lIlIIlIIll.BackgroundTransparency = e and 0.03 or 0.5
                 _lIlllIllII.TextColor3 = e and _lllIIlIIll.Text or _lllIIlIIll.SubText
                 _lllIIlIIIl.TextColor3 = e and Color3.fromRGB(0xFF,0xFF,0xFF) or Color3.fromRGB(0x69,0x69,0x76)
             end
             function _lIlIIIlIll:SetVisible(v) _lIlIIlIIll.Visible = v; _IIIllIIlII() end
             function _lIlIIIlIll:Destroy() _lIlIIlIIll:Destroy(); _IIIllIIlII() end
             function _lIlIIIlIll:UpdateCallback(newCb) _lllIlIIIll = newCb end
             return _lIlIIIlIll
         end
         function _llIIlIllIl:CreateButton(_llllIIllll, _lllIlIIIll) return _IlIIlllllI(_llllIIllll, _lllIlIIIll, _lllIIlIIll.BtnGreen, _lllIIlIIll.BtnGreen, false) end
         function _llIIlIllIl:CreateDangerButton(_llllIIllll, _lllIlIIIll) return _IlIIlllllI(_llllIIllll, _lllIlIIIll, _lllIIlIIll.BtnRed, _lllIIlIIll.BtnRed, true) end
         function _llIIlIllIl:CreateToggle(_llllIIllll, default, _lllIlIIIll)
             default = default == true
             local _IIlIlIllll = default
             _lllIlIIIll = _lllIlIIIll or function() end
             local _lIlIIlIIll = _lIIlIIlllI(0x2C)
             local _lIlllIllII = Instance.new("\084\101\120\116\076\097\098\101\108")
             _lIlllIllII.Size = UDim2.new(0x1, -0x4C, 0x1, 0x0)
             _lIlllIllII.Position = UDim2.new(0x0, 0xE, 0x0, 0x0)
             _lIlllIllII.BackgroundTransparency = 0x1
             _lIlllIllII.Text = _llllIIllll
             _lIlllIllII.TextColor3 = _lllIIlIIll.Text
             _lIlllIllII.Font = _IllIIIlIll.Medium
             _lIlllIllII.TextSize = 0xC
             _lIlllIllII.TextXAlignment = Enum.TextXAlignment.Left
             _lIlllIllII.TextTruncate = Enum.TextTruncate.AtEnd
             _lIlllIllII.Parent = _lIlIIlIIll
             local _IIlIIIIIll = Instance.new("\070\114\097\109\101")
             _IIlIIIIIll.Size = UDim2.new(0x0, 0x2E, 0x0, 0x1A)
             _IIlIIIIIll.Position = UDim2.new(0x1, -0x38, 0x0, 0x9)
             _IIlIIIIIll.BackgroundColor3 = _IIlIlIllll and _lllIIlIIll.ToggleOn or _lllIIlIIll.ToggleOff
             _IIlIIIIIll.BorderSizePixel = 0x0
             _IIlIIIIIll.Parent = _lIlIIlIIll
             _IlIIIIIlII(_IIlIIIIIll, 0xD)
             local _IIllIlllII = Instance.new("\085\073\083\116\114\111\107\101")
             _IIllIlllII.Color = _IIlIlIllll and _lllIIlIIll.ToggleOn or Color3.fromRGB(0x2A,0x2A,0x3A)
             _IIllIlllII.Thickness = 0x1
             _IIllIlllII.Transparency = _IIlIlIllll and 0.5 or 0.2
             _IIllIlllII.Parent = _IIlIIIIIll
             local _llIlIIIIII = Instance.new("\070\114\097\109\101")
             _llIlIIIIII.Size = UDim2.new(0x0, 0x13, 0x0, 0x13)
             _llIlIIIIII.Position = _IIlIlIllll and UDim2.new(0x0,0x18,0x0,0x3) or UDim2.new(0x0,0x3,0x0,0x3)
             _llIlIIIIII.BackgroundColor3 = Color3.fromRGB(0xFF,0xFF,0xFF)
             _llIlIIIIII.BorderSizePixel = 0x0
             _llIlIIIIII.Parent = _IIlIIIIIll
             _IlIIIIIlII(_llIlIIIIII, 0xA)
             local _IllIlIIIIl = Instance.new("\084\101\120\116\066\117\116\116\111\110")
             _IllIlIIIIl.Size = UDim2.new(0x1,0x0,0x1,0x0)
             _IllIlIIIIl.BackgroundTransparency = 0x1
             _IllIlIIIIl.Text = ""
             _IllIlIIIIl.ZIndex = 0x5
             _IllIlIIIIl.Parent = _lIlIIlIIll
             local function _IIllllIllI(v, anim)
                 if anim then
                     _IllllIllII(_IIlIIIIIll, {BackgroundColor3 = v and _lllIIlIIll.ToggleOn or _lllIIlIIll.ToggleOff}, 0.2)
                     _IllllIllII(_llIlIIIIII, {Position = v and UDim2.new(0x0,0x18,0x0,0x3) or UDim2.new(0x0,0x3,0x0,0x3)}, 0.2)
                     _IllllIllII(_IIllIlllII, {Color = v and _lllIIlIIll.ToggleOn or Color3.fromRGB(0x2A,0x2A,0x3A), Transparency = v and 0.5 or 0.2}, 0.2)
                     if v then
                         _IllllIllII(_llIlIIIIII, {Size = UDim2.new(0x0,0x15,0x0,0x15), Position = UDim2.new(0x0,0x17,0x0,0x2)}, 0.08)
                         task.delay(0.08, function() _IllllIllII(_llIlIIIIII, {Size = UDim2.new(0x0,0x13,0x0,0x13), Position = UDim2.new(0x0,0x18,0x0,0x3)}, 0.14) end)
                     end
                 else
                     _IIlIIIIIll.BackgroundColor3 = v and _lllIIlIIll.ToggleOn or _lllIIlIIll.ToggleOff
                     _llIlIIIIII.Position = v and UDim2.new(0x0,0x18,0x0,0x3) or UDim2.new(0x0,0x3,0x0,0x3)
                     _IIllIlllII.Color = v and _lllIIlIIll.ToggleOn or Color3.fromRGB(0x2A,0x2A,0x3A)
                     _IIllIlllII.Transparency = v and 0.5 or 0.2
                 end
             end
             _IllIlIIIIl.MouseButton1Click:Connect(function() _IIlIlIllll = not _IIlIlIllll; _IIllllIllI(_IIlIlIllll, true); pcall(_lllIlIIIll, _IIlIlIllll) end)
             local _lIlIIIlIll = {}
             function _lIlIIIlIll:SetValue(v) _IIlIlIllll = v==true; _IIllllIllI(_IIlIlIllll, true); pcall(_lllIlIIIll, _IIlIlIllll) end
             function _lIlIIIlIll:GetValue() return _IIlIlIllll end
             function _lIlIIIlIll:SetEnabled(e) _IllIlIIIIl.Active = e; _lIlIIlIIll.BackgroundTransparency = e and 0.03 or 0.5 end
             function _lIlIIIlIll:SetVisible(v) _lIlIIlIIll.Visible = v; _IIIllIIlII() end
             function _lIlIIIlIll:Destroy() _lIlIIlIIll:Destroy(); _IIIllIIlII() end
             function _lIlIIIlIll:UpdateCallback(newCb) _lllIlIIIll = newCb end
             return _lIlIIIlIll
         end
         function _llIIlIllIl:CreateSlider(_llllIIllll, mn, mx, def, _lllIlIIIll, float)
             mn = mn or 0x0; mx = mx or 0x64
             if mn == mx then mx = mn + 0x1 end
             def = math.clamp(def or mn, mn, mx); float = float or false
             _lllIlIIIll = _lllIlIIIll or function() end -- SAFEGUARD
             local _IIlIlIllll = def
             local _lIlIIlIIll = _lIIlIIlllI(0x3E)
             local _lIlllIllII = Instance.new("\084\101\120\116\076\097\098\101\108")
             _lIlllIllII.Size = UDim2.new(0x1, -0x58, 0x0, 0x12); _lIlllIllII.Position = UDim2.new(0x0,0xE,0x0,0x8)
             _lIlllIllII.BackgroundTransparency = 0x1; _lIlllIllII.Text = _llllIIllll; _lIlllIllII.TextColor3 = _lllIIlIIll.Text
             _lIlllIllII.Font = _IllIIIlIll.Medium; _lIlllIllII.TextSize = 0xC; _lIlllIllII.TextXAlignment = Enum.TextXAlignment.Left
             _lIlllIllII.TextTruncate = Enum.TextTruncate.AtEnd; _lIlllIllII.Parent = _lIlIIlIIll
             local _llIlIIllll = Instance.new("\070\114\097\109\101")
             _llIlIIllll.Size = UDim2.new(0x0,0x36,0x0,0x16); _llIlIIllll.Position = UDim2.new(0x1,-0x40,0x0,0x6)
             _llIlIIllll.BackgroundColor3 = Color3.fromRGB(0x1A,0x1A,0x26); _llIlIIllll.BackgroundTransparency = 0.03
             _llIlIIllll.BorderSizePixel = 0x0; _llIlIIllll.Parent = _lIlIIlIIll
             _IlIIIIIlII(_llIlIIllll, 0x7)
             local _llIlIIlIll = _IlIIllIIIl(_llIlIIllll, _lllIIlIIll.CompStroke, 0x1, 0.3)
             local function _llIIlllllI(v)
                 if not float then return tostring(v) end
                 local _lIIllIlIIl = mx - mn
                 if _lIIllIlIIl <= 0.01 then return string.format("\037\046\052\102", v)
                 elseif _lIIllIlIIl <= 0x1 then return string.format("\037\046\051\102", v)
                 else return string.format("\037\046\050\102", v) end
             end
             local _lIllIIlllI = Instance.new("\084\101\120\116\066\111\120")
             _lIllIIlllI.Size = UDim2.new(0x1,-0x6,0x1,0x0); _lIllIIlllI.Position = UDim2.new(0x0,0x3,0x0,0x0)
             _lIllIIlllI.BackgroundTransparency = 0x1; _lIllIIlllI.BorderSizePixel = 0x0
             _lIllIIlllI.Text = _llIIlllllI(def)
             _lIllIIlllI.TextColor3 = _lllIIlIIll.SliderFill; _lIllIIlllI.Font = _IllIIIlIll.Bold; _lIllIIlllI.TextSize = 0xB
             _lIllIIlllI.TextXAlignment = Enum.TextXAlignment.Center; _lIllIIlllI.ClearTextOnFocus = true; _lIllIIlllI.Parent = _llIlIIllll
             _lIllIIlllI.Focused:Connect(function() _llIlIIlIll.Color = _lllIIlIIll.SliderFill; _llIlIIlIll.Transparency = 0.1; _IllllIllII(_llIlIIllll,{BackgroundColor3=Color3.fromRGB(0x1C,0x1E,0x30)},0.14) end)
             
             local _IllIlllIII = Instance.new("\084\101\120\116\066\117\116\116\111\110")
             _IllIlllIII.Size = UDim2.new(0x1,-0x1A,0x0,0x6); _IllIlllIII.Position = UDim2.new(0x0,0xE,0x0,0x28)
             _IllIlllIII.BackgroundColor3 = _lllIIlIIll.SliderBg; _IllIlllIII.BorderSizePixel = 0x0; _IllIlllIII.ClipsDescendants = true; _IllIlllIII.Parent = _lIlIIlIIll
             _IllIlllIII.Text = ""
             _IllIlllIII.AutoButtonColor = false
             _IlIIIIIlII(_IllIlllIII, 0x3)
             
             local _IlllIlIIIl = (def-mn)/(mx-mn)
             local _IIlIIllIII = Instance.new("\070\114\097\109\101")
             _IIlIIllIII.Size = UDim2.new(_IlllIlIIIl,0x0,0x1,0x0); _IIlIIllIII.BackgroundColor3 = _lllIIlIIll.SliderFill; _IIlIIllIII.BorderSizePixel = 0x0; _IIlIIllIII.Parent = _IllIlllIII
             _IlIIIIIlII(_IIlIIllIII, 0x3)
             local _lIllllIIIl = Instance.new("\084\101\120\116\066\117\116\116\111\110")
             _lIllllIIIl.Size = UDim2.new(0x0,0x10,0x0,0x10); _lIllllIIIl.Position = UDim2.new(_IlllIlIIIl,-0x8,0x0,-0x5)
             _lIllllIIIl.BackgroundColor3 = Color3.fromRGB(0xF0,0xF2,0xFF); _lIllllIIIl.BorderSizePixel = 0x0
             _lIllllIIIl.Text = ""; _lIllllIIIl.AutoButtonColor = false; _lIllllIIIl.ZIndex = 0x5; _lIllllIIIl.Parent = _IllIlllIII
             _IlIIIIIlII(_lIllllIIIl, 0x8); _IlIIllIIIl(_lIllllIIIl, _lllIIlIIll.SliderFill, 1.5, 0.1)
             local function _IllIlIIlIl(val)
                 if not float then return math.floor(val+0.5) end
                 local _lIIllIlIIl = mx - mn
                 local _llIllIIlIl = _lIIllIlIIl <= 0.01 and 0x4 or _lIIllIlIIl <= 0x1 and 0x3 or 0x2
                 local _IlIlIIIlII = 0xA^_llIllIIlIl
                 return math.floor(val * _IlIlIIIlII + 0.5) / _IlIlIIIlII
             end
             local function _lIllIlllII(_lIIlIIIIII)
                 _lIIlIIIIII = math.clamp(_lIIlIIIIII,0x0,0x1)
                 _IIlIlIllll = math.clamp(_IllIlIIlIl(mn+(mx-mn)*_lIIlIIIIII), mn, mx)
                 _IIlIIllIII.Size = UDim2.new(_lIIlIIIIII,0x0,0x1,0x0); _lIllllIIIl.Position = UDim2.new(_lIIlIIIIII,-0x8,0x0,-0x5)
                 _lIllIIlllI.Text = _llIIlllllI(_IIlIlIllll)
                 pcall(_lllIlIIIll, _IIlIlIllll) -- SAFEGUARD
             end
             _lIllIIlllI.FocusLost:Connect(function()
                 _llIlIIlIll.Color = _lllIIlIIll.CompStroke; _llIlIIlIll.Transparency = 0.3
                 _IllllIllII(_llIlIIllll,{BackgroundColor3=Color3.fromRGB(0x1A,0x1A,0x26)},0.14)
                 local _lIIIIIIIIl = tonumber(_lIllIIlllI.Text)
                 if _lIIIIIIIIl then
                     _IIlIlIllll = math.clamp(_IllIlIIlIl(_lIIIIIIIIl), mn, mx)
                     local _IllIlIIIlI = (_IIlIlIllll-mn)/(mx-mn)
                     _IIlIIllIII.Size=UDim2.new(_IllIlIIIlI,0x0,0x1,0x0); _lIllllIIIl.Position=UDim2.new(_IllIlIIIlI,-0x8,0x0,-0x5)
                     _lIllIIlllI.Text=_llIIlllllI(_IIlIlIllll); pcall(_lllIlIIIll, _IIlIlIllll)
                 else _lIllIIlllI.Text=_llIIlllllI(_IIlIlIllll) end
             end)
             
             local _IIIIIIllll = false
             local function _llIIlllIIl(_lIIlIIllII)
                 if _lIIlIIllII.UserInputType ~= Enum.UserInputType.MouseButton1 and _lIIlIIllII.UserInputType ~= Enum.UserInputType.Touch then return end
                 if _IIIIIIllll then return end
                 _IIIIIIllll = true
                 
                 local _lllIlllIll = _IllIlllIII:FindFirstAncestorOfClass("\083\099\114\111\108\108\105\110\103\070\114\097\109\101")
                 local _IIllIIllIl = _lllIlllIll and _lllIlllIll.ScrollingEnabled
                 if _lllIlllIll then _lllIlllIll.ScrollingEnabled = false end

                 local _lIIlIIlIlI = _lIIlIIllII.UserInputType == Enum.UserInputType.Touch
                 local _lIIIlIIIlI = false
                 
                 local function _lIllllIIlI()
                     if _lIIIlIIIlI then return end
                     _lIIIlIIIlI = true
                     _IIIIIIllll = false
                     if _lllIlllIll then _lllIlllIll.ScrollingEnabled = _IIllIIllIl end
                     if _IIIIIIIIIl then _IIIIIIIIIl:Disconnect() end
                     if _lllIlIlllI then _lllIlIlllI:Disconnect() end
                     _IllllIllII(_lIllllIIIl, {Size = UDim2.new(0x0,0x10,0x0,0x10)}, 0.1)
                 end

                 local function _lIIIIIIllI(pos)
                     local _llIllIllll = _IllIlllIII.AbsoluteSize.X
                     if _llIllIllll > 0x0 then
                         local _lIIlIIIIII = (pos.X - _IllIlllIII.AbsolutePosition.X) / _llIllIllll
                         _lIIlIIIIII = math.clamp(_lIIlIIIIII, 0x0, 0x1)
                         pcall(function() _lIllIlllII(_lIIlIIIIII) end)
                     end
                 end

                 _lIIIIIIllI(_lIIlIIllII.Position)
                 _IllllIllII(_lIllllIIIl, {Size = UDim2.new(0x0,0x14,0x0,0x14)}, 0.1)

                 local _IIIIIIIIIl = _IIlIllIIIl.InputChanged:Connect(function(mi)
                     if _lIIlIIlIlI then
                         if mi.UserInputType == Enum.UserInputType.Touch then _lIIIIIIllI(mi.Position) end
                     else
                         if mi.UserInputType == Enum.UserInputType.MouseMovement then _lIIIIIIllI(mi.Position) end
                     end
                 end)

                 local _lllIlIlllI = _IIlIllIIIl.InputEnded:Connect(function(ei)
                     if _lIIlIIlIlI then
                         if ei.UserInputType == Enum.UserInputType.Touch then _lIllllIIlI() end
                     else
                         if ei.UserInputType == Enum.UserInputType.MouseButton1 then _lIllllIIlI() end
                     end
                 end)
             end

             _lIllllIIIl.InputBegan:Connect(_llIIlllIIl)
             _IllIlllIII.InputBegan:Connect(_llIIlllIIl)
             
             local _lIlIIIlIll = {}
             function _lIlIIIlIll:SetValue(v)
                 _IIlIlIllll=math.clamp(_IllIlIIlIl(v),mn,mx)
                 local _IllIlIIIlI=(_IIlIlIllll-mn)/(mx-mn); _IIlIIllIII.Size=UDim2.new(_IllIlIIIlI,0x0,0x1,0x0); _lIllllIIIl.Position=UDim2.new(_IllIlIIIlI,-0x8,0x0,-0x5)
                 _lIllIIlllI.Text=_llIIlllllI(_IIlIlIllll); pcall(_lllIlIIIll, _IIlIlIllll)
             end
             function _lIlIIIlIll:GetValue() return _IIlIlIllll end
             function _lIlIIIlIll:SetEnabled(e) _lIllllIIIl.Active=e; _lIlIIlIIll.BackgroundTransparency=e and 0.03 or 0.5 end
             function _lIlIIIlIll:SetVisible(v) _lIlIIlIIll.Visible=v; _IIIllIIlII() end
             function _lIlIIIlIll:Destroy() _lIlIIlIIll:Destroy(); _IIIllIIlII() end
             function _lIlIIIlIll:UpdateCallback(newCb) _lllIlIIIll=newCb end
             return _lIlIIIlIll
         end
         function _llIIlIllIl:CreateDropdown(config, _legacyOpts, _legacyCb, _legacyMulti)
             if type(config) == "\115\116\114\105\110\103" then
                 config = {Text=config, Options=_legacyOpts or {"\079\112\116\105\111\110\032\049"}, Callback=_legacyCb or function() end, MultiSelect=_legacyMulti or false}
             end
             local _llllIIllll=config.Text or "\068\114\111\112\100\111\119\110"; local _IlIlIIIIlI=config.Options or {"\079\112\116\105\111\110\032\049"}
             local _lllIlIIIll=config.Callback or function() end; local _IlllIllIIl=config.MultiSelect or false
             local _IlIIlIIIII={}; local _IIIlIlIIIl=false; local _IIlIllllII=0x20; local _lIllIIlllI=0x5; local _IllIlIlIlI=0x8
             if _IlllIllIIl then _IlIIlIIIII={}; if _IlIlIIIIlI[0x1] then _IlIIlIIIII[_IlIlIIIIlI[0x1]]=true end else _IlIIlIIIII=_IlIlIIIIlI[0x1] end
             local function _IllIlIIlII() return math.min(#_IlIlIIIIlI,_lIllIIlllI)*_IIlIllllII+_IllIlIlIlI end
             local _llllIIlIIl=Instance.new("\070\114\097\109\101")
             _llllIIlIIl.Name="\068\068\095"..text; _llllIIlIIl.Size=UDim2.new(0.96,0x0,0x0,0x26); _llllIIlIIl.BackgroundColor3=_lllIIlIIll.ComponentBg
             _llllIIlIIl.BackgroundTransparency=0.03; _llllIIlIIl.BorderSizePixel=0x0; _llllIIlIIl.LayoutOrder=_lllIIlIlIl()
             _llllIIlIIl.ClipsDescendants=true; _llllIIlIIl.ZIndex=0x2; _llllIIlIIl.Parent=_IIIIlIlIII
             _IlIIIIIlII(_llllIIlIIl,0xA); _IlIIllIIIl(_llllIIlIIl,Color3.fromRGB(0xFF,0xFF,0xFF),0x1,0.92)
             local _IIIlIIIIll=Instance.new("\085\073\083\116\114\111\107\101"); _IIIlIIIIll.Color=Color3.fromRGB(0x30,0x32,0x46)
             _IIIlIIIIll.Thickness=1.5; _IIIlIIIIll.Transparency=0.6; _IIIlIIIIll.Parent=_llllIIlIIl
             local _lIlllIllII=Instance.new("\084\101\120\116\076\097\098\101\108"); _lIlllIllII.Size=UDim2.new(0x1,-0xA0,0x0,0x26); _lIlllIllII.Position=UDim2.new(0x0,0xE,0x0,0x0)
             _lIlllIllII.BackgroundTransparency=0x1; _lIlllIllII.Text=_llllIIllll; _lIlllIllII.TextColor3=_lllIIlIIll.Text; _lIlllIllII.Font=_IllIIIlIll.Medium
             _lIlllIllII.TextSize=0xC; _lIlllIllII.TextXAlignment=Enum.TextXAlignment.Left
             _lIlllIllII.TextTruncate=Enum.TextTruncate.AtEnd; _lIlllIllII.ZIndex=0x3; _lIlllIllII.Parent=_llllIIlIIl
             local _IlIIllIIII=Instance.new("\084\101\120\116\076\097\098\101\108"); _IlIIllIIII.Size=UDim2.new(0x0,0x6C,0x0,0x26); _IlIIllIIII.Position=UDim2.new(0x1,-0x90,0x0,0x0)
             _IlIIllIIII.BackgroundTransparency=0x1; _IlIIllIIII.TextColor3=_lllIIlIIll.SubText; _IlIIllIIII.Font=_IllIIIlIll.Medium
             _IlIIllIIII.TextSize=0xB; _IlIIllIIII.TextXAlignment=Enum.TextXAlignment.Right; _IlIIllIIII.TextTruncate=Enum.TextTruncate.AtEnd
             _IlIIllIIII.ZIndex=0x3; _IlIIllIIII.Parent=_llllIIlIIl
             local _lIllIIlIll=Instance.new("\084\101\120\116\076\097\098\101\108"); _lIllIIlIll.Size=UDim2.new(0x0,0x14,0x0,0x26); _lIllIIlIll.Position=UDim2.new(0x1,-0x18,0x0,0x0)
             _lIllIIlIll.BackgroundTransparency=0x1; _lIllIIlIll.Text="\118"; _lIllIIlIll.TextColor3=_lllIIlIIll.AccentBlue
             _lIllIIlIll.Font=_IllIIIlIll.Body; _lIllIIlIll.TextSize=0x9; _lIllIIlIll.ZIndex=0x3; _lIllIIlIll.Parent=_llllIIlIIl
             local _IIlllllIII=Instance.new("\070\114\097\109\101"); _IIlllllIII.Size=UDim2.new(0x1,0x0,0x0,0x1); _IIlllllIII.Position=UDim2.new(0x0,0x0,0x0,0x26)
             _IIlllllIII.BackgroundColor3=Color3.fromRGB(0xFF,0xFF,0xFF); _IIlllllIII.BackgroundTransparency=0.88
             _IIlllllIII.BorderSizePixel=0x0; _IIlllllIII.ZIndex=0x3; _IIlllllIII.Visible=false; _IIlllllIII.Parent=_llllIIlIIl
             local _lllIlIIlll=_IllIlIIlII(); local _IIIlIllllI=#_IlIlIIIIlI*_IIlIllllII+_IllIlIlIlI
             local _lIllllIllI=Instance.new("\083\099\114\111\108\108\105\110\103\070\114\097\109\101"); _lIllllIllI.Size=UDim2.new(0x1,0x0,0x0,_lllIlIIlll)
             _lIllllIllI.Position=UDim2.new(0x0,0x0,0x0,0x27); _lIllllIllI.BackgroundColor3=_lllIIlIIll.DropdownBg
             _lIllllIllI.BackgroundTransparency=0.03; _lIllllIllI.BorderSizePixel=0x0; _lIllllIllI.ScrollBarThickness=0x2
             _lIllllIllI.ScrollBarImageColor3=Color3.fromRGB(0x3A,0x3C,0x50); _lIllllIllI.ScrollingDirection=Enum.ScrollingDirection.Y
             _lIllllIllI.CanvasSize=UDim2.new(0x0,0x0,0x0,_IIIlIllllI); _lIllllIllI.Selectable=false; _lIllllIllI.ZIndex=0x3
             _lIllllIllI.Visible=false; _lIllllIllI.Parent=_llllIIlIIl
             local function _llIIllIIIl()
                 if _IlllIllIIl then
                     local _lIlIllllll=0x0; for _,v in pairs(_IlIIlIIIII) do if v then _lIlIllllll=_lIlIllllll+0x1 end end
                     _IlIIllIIII.Text=_lIlIllllll.."\032\115\101\108\101\099\116\101\100"
                 else _IlIIllIIII.Text=_IlIIlIIIII or "" end
             end
             _llIIllIIIl()
             local _llllIllIIl=nil; local _lIIIlllIll=0x0; local _lIIIIIIIIl=0x0
             local function _lIlIIIIllI()
                 if not _IIIlIlIIIl then return end
                 _IIIlIlIIIl=false; _IIlIIlllII=false
                 _IllllIllII(_llllIIlIIl,{Size=UDim2.new(0.96,0x0,0x0,0x26)},0.22,Enum.EasingStyle.Quart,Enum.EasingDirection.In)
                 _IllllIllII(_lIllIIlIll,{Rotation=0x0},0.18)
                 _IIIIlIlIII.Size=UDim2.new(0x1,0x0,0x0,_lIIIIIIIIl)
                 _IllllIllII(_IIlllllllI,{Size=UDim2.new(0.97,0x0,0x0,0x24+_lIIIIIIIIl+0x4)},0.22,Enum.EasingStyle.Quart,Enum.EasingDirection.In)
                 task.delay(0.23,function()
                     if not _IIIlIlIIIl then _IIlllllIII.Visible=false; _lIllllIllI.Visible=false; _llllIIlIIl.ClipsDescendants=true end
                 end)
                 if _llllIllIIl then _llllIllIIl:Disconnect(); _llllIllIIl=nil end
             end
             local function _lIlIIllIII()
                 _IIIlIlIIIl=true; _IIlIIlllII=true; _lIIIlllIll=tick(); _lIIIIIIIIl=_lIIllIIllI()
                 _lllIlIIlll=_IllIlIIlII(); _IIIlIllllI=#_IlIlIIIIlI*_IIlIllllII+_IllIlIlIlI
                 _lIllllIllI.Size=UDim2.new(0x1,0x0,0x0,_lllIlIIlll); _lIllllIllI.CanvasSize=UDim2.new(0x0,0x0,0x0,_IIIlIllllI)
                 _llllIIlIIl.ClipsDescendants=false; _IIlllllIII.Visible=true; _lIllllIllI.Visible=true
                 _IllllIllII(_llllIIlIIl,{Size=UDim2.new(0.96,0x0,0x0,0x26+0x1+_lllIlIIlll)},0.22,Enum.EasingStyle.Quart,Enum.EasingDirection.Out)
                 _IllllIllII(_lIllIIlIll,{Rotation=0xB4},0.18)
                 local _IllIIIIIIl=_lIIIIIIIIl+_lllIlIIlll+0x1
                 _IIIIlIlIII.Size=UDim2.new(0x1,0x0,0x0,_IllIIIIIIl)
                 _IllllIllII(_IIlllllllI,{Size=UDim2.new(0.97,0x0,0x0,0x24+_IllIIIIIIl+0x4)},0.22,Enum.EasingStyle.Quart,Enum.EasingDirection.Out)
             end
             local function _llllIIlllI(list)
                 for _,_IlIIlllIll in ipairs(_lIllllIllI:GetChildren()) do if _IlIIlllIll:IsA("\084\101\120\116\066\117\116\116\111\110") then _IlIIlllIll:Destroy() end end
                 for i,opt in ipairs(list) do
                     local _IIllIlIlIl=Instance.new("\084\101\120\116\066\117\116\116\111\110")
                     _IIllIlIlIl.Size=UDim2.new(0.92,0x0,0x0,_IIlIllllII-0x4); _IIllIlIlIl.Position=UDim2.new(0.04,0x0,0x0,_IllIlIlIlI/0x2+(i-0x1)*_IIlIllllII)
                     _IIllIlIlIl.BackgroundColor3=(_IlllIllIIl and _IlIIlIIIII[opt]) and _lllIIlIIll.SliderFill or _lllIIlIIll.OptionBg
                     _IIllIlIlIl.BackgroundTransparency=0.03; _IIllIlIlIl.BorderSizePixel=0x0
                     _IIllIlIlIl.Text="\032\032"..opt; _IIllIlIlIl.TextColor3=_lllIIlIIll.Text; _IIllIlIlIl.Font=_IllIIIlIll.Body; _IIllIlIlIl.TextSize=0xC
                     _IIllIlIlIl.TextXAlignment=Enum.TextXAlignment.Left; _IIllIlIlIl.TextTruncate=Enum.TextTruncate.AtEnd
                     _IIllIlIlIl.AutoButtonColor=false; _IIllIlIlIl.ZIndex=0x4; _IIllIlIlIl.Parent=_lIllllIllI; _IlIIIIIlII(_IIllIlIlIl,0x7)
                     _IIllIlIlIl.MouseEnter:Connect(function() if not(_IlllIllIIl and _IlIIlIIIII[opt]) then _IllllIllII(_IIllIlIlIl,{BackgroundColor3=_lllIIlIIll.OptionHover},0.1) end end)
                     _IIllIlIlIl.MouseLeave:Connect(function() _IllllIllII(_IIllIlIlIl,{BackgroundColor3=(_IlllIllIIl and _IlIIlIIIII[opt]) and _lllIIlIIll.SliderFill or _lllIIlIIll.OptionBg},0.1) end)
                     _IIllIlIlIl.MouseButton1Click:Connect(function()
                         if _IlllIllIIl then
                             _IlIIlIIIII[opt]=not _IlIIlIIIII[opt]; _IllllIllII(_IIllIlIlIl,{BackgroundColor3=_IlIIlIIIII[opt] and _lllIIlIIll.SliderFill or _lllIIlIIll.OptionBg},0.12)
                             _llIIllIIIl(); local _IlIlIllIll={}
                             for o,v in pairs(_IlIIlIIIII) do if v then table.insert(_IlIlIllIll,o) end end; pcall(_lllIlIIIll, _IlIIlIIIII, _IlIlIllIll)
                         else _IlIIlIIIII=opt; _IlIIllIIII.Text=opt; _lIlIIIIllI(); pcall(_lllIlIIIll, opt) end
                     end)
                 end
             end
             _llllIIlllI(_IlIlIIIIlI)
             local _IIllIlIIII=Instance.new("\084\101\120\116\066\117\116\116\111\110"); _IIllIlIIII.Size=UDim2.new(0x1,0x0,0x0,0x26)
             _IIllIlIIII.BackgroundTransparency=0x1; _IIllIlIIII.Text=""; _IIllIlIIII.ZIndex=0xA; _IIllIlIIII.Parent=_llllIIlIIl
             local _llllIIIIlI=false
             _IIllIlIIII.MouseButton1Click:Connect(function()
                 if _llllIIIIlI then return end
                 _llllIIIIlI=true
                 if _IIIlIlIIIl then
                     _lIlIIIIllI()
                     task.delay(0.25, function() _llllIIIIlI=false end)
                 else
                     _lIlIIllIII()
                     task.delay(0.25, function() _llllIIIIlI=false end)
                 end
             end)
             local _lIlIIIlIll={}
             function _lIlIIIlIll:SetValue(v)
                 if _IlllIllIIl then
                     if type(v)=="\116\097\098\108\101" then _IlIIlIIIII=v else _IlIIlIIIII[v]=not _IlIIlIIIII[v] end
                     _llIIllIIIl(); _llllIIlllI(_IlIlIIIIlI)
                     local _IlIlIllIll={}; for o,val in pairs(_IlIIlIIIII) do if val then table.insert(_IlIlIllIll,o) end end; pcall(_lllIlIIIll, _IlIIlIIIII, _IlIlIllIll)
                 else if table.find(_IlIlIIIIlI,v) then _IlIIlIIIII=v; _IlIIllIIII.Text=v; pcall(_lllIlIIIll, v) end end
             end
             function _lIlIIIlIll:GetValue()
                 if _IlllIllIIl then local _IlIlIllIll={}; for o,v in pairs(_IlIIlIIIII) do if v then table.insert(_IlIlIllIll,o) end end; return _IlIIlIIIII,_IlIlIllIll
                 else return _IlIIlIIIII end
             end
             function _lIlIIIlIll:SetOptions(newOpts)
                 _IlIlIIIIlI=newOpts
                 if _IlllIllIIl then _IlIIlIIIII={}; if newOpts[0x1] then _IlIIlIIIII[newOpts[0x1]]=true end else _IlIIlIIIII=newOpts[0x1] or "" end
                 if _IIIlIlIIIl then _lIlIIIIllI() end; _llIIllIIIl(); _llllIIlllI(newOpts)
             end
             function _lIlIIIlIll:Close() _lIlIIIIllI() end
             function _lIlIIIlIll:SetEnabled(e) _IIllIlIIII.Active=e; _llllIIlIIl.BackgroundTransparency=e and 0.03 or 0.5; if not e then _lIlIIIIllI() end end
             function _lIlIIIlIll:SetVisible(v) _llllIIlIIl.Visible=v; if not v then _lIlIIIIllI() end; _IIIllIIlII() end
             function _lIlIIIlIll:Destroy() _lIlIIIIllI(); _llllIIlIIl:Destroy(); _IIIllIIlII() end
             function _lIlIIIlIll:UpdateCallback(newCb) _lllIlIIIll=newCb end
             return _lIlIIIlIll
         end
         function _llIIlIllIl:CreateKeybind(_llllIIllll, defKey, _lllIlIIIll)
             defKey=defKey or Enum.KeyCode.F
             _lllIlIIIll = _lllIlIIIll or function() end
             local _IllIlllIlI=defKey; local _lIlIlIlIII=false; local _IIIlIlIlII=nil
             local _lIlIIlIIll=_lIIlIIlllI(0x2C)
             local _lIlllIllII=Instance.new("\084\101\120\116\076\097\098\101\108"); _lIlllIllII.Size=UDim2.new(0x1,-0x60,0x1,0x0); _lIlllIllII.Position=UDim2.new(0x0,0xE,0x0,0x0)
             _lIlllIllII.BackgroundTransparency=0x1; _lIlllIllII.Text=_llllIIllll; _lIlllIllII.TextColor3=_lllIIlIIll.Text
             _lIlllIllII.Font=_IllIIIlIll.Medium; _lIlllIllII.TextSize=0xC; _lIlllIllII.TextXAlignment=Enum.TextXAlignment.Left
             _lIlllIllII.TextTruncate=Enum.TextTruncate.AtEnd; _lIlllIllII.Parent=_lIlIIlIIll
             local _lIIIIlIlll=Instance.new("\084\101\120\116\066\117\116\116\111\110"); _lIIIIlIlll.Size=UDim2.new(0x0,0x44,0x0,0x1E); _lIIIIlIlll.Position=UDim2.new(0x1,-0x4E,0x0,0x7)
             _lIIIIlIlll.BackgroundColor3=_lllIIlIIll.KeybindBg; _lIIIIlIlll.BackgroundTransparency=0.02; _lIIIIlIlll.BorderSizePixel=0x0
             _lIIIIlIlll.Text=defKey.Name; _lIIIIlIlll.TextColor3=_lllIIlIIll.TabTextActive; _lIIIIlIlll.Font=_IllIIIlIll.Bold; _lIIIIlIlll.TextSize=0xA
             _lIIIIlIlll.AutoButtonColor=false; _lIIIIlIlll.Parent=_lIlIIlIIll; _IlIIIIIlII(_lIIIIlIlll,0x8); _IlIIllIIIl(_lIIIIlIlll,_lllIIlIIll.CompStroke,0x1,0.24)
             local function _IlIllIIlIl() if _IIIlIlIlII then _IIIlIlIlII:Disconnect(); _IIIlIlIlII=nil end end
             _lIIIIlIlll.MouseButton1Click:Connect(function()
                 if _lIlIlIlIII then _IlIllIIlIl(); _lIlIlIlIII=false; _lIIIIlIlll.Text=_IllIlllIlI.Name; _IllllIllII(_lIIIIlIlll,{BackgroundColor3=_lllIIlIIll.KeybindBg},0.12); return end
                 _lIlIlIlIII=true; _lIIIIlIlll.Text="\046\046\046"; _IllllIllII(_lIIIIlIlll,{BackgroundColor3=Color3.fromRGB(0x3A,0x3A,0x56)},0.12)
                 _IIIlIlIlII=_IIlIllIIIl.InputBegan:Connect(function(_lIIlIIllII,gp)
                     if not _lIlIlIlIII then return end; if gp then return end
                     if _lIIlIIllII.KeyCode==Enum.KeyCode.Unknown then return end
                     _IllIlllIlI=_lIIlIIllII.KeyCode; _lIIIIlIlll.Text=_IllIlllIlI.Name; _lIlIlIlIII=false
                     _IllllIllII(_lIIIIlIlll,{BackgroundColor3=_lllIIlIIll.KeybindBg},0.12); _IlIllIIlIl(); pcall(_lllIlIIIll, _IllIlllIlI)
                 end)
                 _lIIllllIll(_IIIlIlIlII)
             end)
             local _lIlIIIlIll={}
             function _lIlIIIlIll:SetValue(k) _IllIlllIlI=k; _lIIIIlIlll.Text=k.Name; pcall(_lllIlIIIll, k) end
             function _lIlIIIlIll:GetValue() return _IllIlllIlI end
             function _lIlIIIlIll:SetEnabled(e) _lIIIIlIlll.Active=e; _lIlIIlIIll.BackgroundTransparency=e and 0.03 or 0.5 end
             function _lIlIIIlIll:SetVisible(v) _lIlIIlIIll.Visible=v; _IIIllIIlII() end
             function _lIlIIIlIll:Destroy() _IlIllIIlIl(); _lIlIIlIIll:Destroy(); _IIIllIIlII() end
             function _lIlIIIlIll:UpdateCallback(newCb) _lllIlIIIll=newCb end
             return _lIlIIIlIll
         end
         function _llIIlIllIl:CreateColorPicker(_llllIIllll, defColor, _lllIlIIIll)
             defColor = defColor or Color3.fromRGB(0xFF, 0xFF, 0xFF)
             _lllIlIIIll = _lllIlIIIll or function() end
             local _IIlIlIlIIl, _s, _v2 = Color3.toHSV(defColor)
             local _IIIlIlIIIl = false
             local _IlIllIlIlI = 0xC6
             local _IIIIIIlIll = Instance.new("\070\114\097\109\101")
             _IIIIIIlIll.Size = UDim2.new(0.96, 0x0, 0x0, 0x2C)
             _IIIIIIlIll.BackgroundColor3 = _lllIIlIIll.ComponentBg
             _IIIIIIlIll.BackgroundTransparency = 0.03
             _IIIIIIlIll.BorderSizePixel = 0x0
             _IIIIIIlIll.LayoutOrder = _lllIIlIlIl()
             _IIIIIIlIll.ClipsDescendants = true
             _IIIIIIlIll.Parent = _IIIIlIlIII
             _IlIIIIIlII(_IIIIIIlIll, 0xA)
             _IlIIllIIIl(_IIIIIIlIll, Color3.fromRGB(0xFF, 0xFF, 0xFF), 0x1, 0.92)
             local _IIIlIIIIll = Instance.new("\085\073\083\116\114\111\107\101")
             _IIIlIIIIll.Color = Color3.fromRGB(0x30, 0x32, 0x46)
             _IIIlIIIIll.Thickness = 1.5; _IIIlIIIIll.Transparency = 0.6; _IIIlIIIIll.Parent = _IIIIIIlIll
             local _lIlllIllII = Instance.new("\084\101\120\116\076\097\098\101\108")
             _lIlllIllII.Size = UDim2.new(0x1, -0x3C, 0x0, 0x2C); _lIlllIllII.Position = UDim2.new(0x0, 0xE, 0x0, 0x0)
             _lIlllIllII.BackgroundTransparency = 0x1; _lIlllIllII.Text = _llllIIllll; _lIlllIllII.TextColor3 = _lllIIlIIll.Text
             _lIlllIllII.Font = _IllIIIlIll.Medium; _lIlllIllII.TextSize = 0xC; _lIlllIllII.TextXAlignment = Enum.TextXAlignment.Left
             _lIlllIllII.TextTruncate = Enum.TextTruncate.AtEnd; _lIlllIllII.ZIndex = 0x3; _lIlllIllII.Parent = _IIIIIIlIll
             local _lIlllllIIl = Instance.new("\070\114\097\109\101")
             _lIlllllIIl.Size = UDim2.new(0x0, 0x1C, 0x0, 0x1C); _lIlllllIIl.Position = UDim2.new(0x1, -0x28, 0x0, 0x8)
             _lIlllllIIl.BackgroundColor3 = defColor; _lIlllllIIl.BorderSizePixel = 0x0; _lIlllllIIl.ZIndex = 0x3; _lIlllllIIl.Parent = _IIIIIIlIll
             _IlIIIIIlII(_lIlllllIIl, 0x8); _IlIIllIIIl(_lIlllllIIl, Color3.fromRGB(0xFF, 0xFF, 0xFF), 1.5, 0.75)
             local _llIIlIllIl = Instance.new("\084\101\120\116\076\097\098\101\108")
             _llIIlIllIl.Size = UDim2.new(0x0, 0xE, 0x0, 0x2C); _llIIlIllIl.Position = UDim2.new(0x1, -0xE, 0x0, 0x0)
             _llIIlIllIl.BackgroundTransparency = 0x1; _llIIlIllIl.Text = "\118"
             _llIIlIllIl.TextColor3 = _lllIIlIIll.AccentBlue; _llIIlIllIl.Font = _IllIIIlIll.Body; _llIIlIllIl.TextSize = 0x9
             _llIIlIllIl.ZIndex = 0x3; _llIIlIllIl.Parent = _IIIIIIlIll
             local _IlIlIIIIll = Instance.new("\070\114\097\109\101")
             _IlIlIIIIll.Size = UDim2.new(0x1, 0x0, 0x0, _IlIllIlIlI); _IlIlIIIIll.Position = UDim2.new(0x0, 0x0, 0x0, 0x2C)
             _IlIlIIIIll.BackgroundColor3 = Color3.fromRGB(0x11, 0x11, 0x1A); _IlIlIIIIll.BackgroundTransparency = 0.03
             _IlIlIIIIll.BorderSizePixel = 0x0; _IlIlIIIIll.ZIndex = 0x4; _IlIlIIIIll.Visible = false; _IlIlIIIIll.Parent = _IIIIIIlIll
             local _llIIllIlIl = Instance.new("\070\114\097\109\101")
             _llIIllIlIl.Size = UDim2.new(0x1, 0x0, 0x0, 0x1); _llIIllIlIl.BackgroundColor3 = Color3.fromRGB(0xFF, 0xFF, 0xFF)
             _llIIllIlIl.BackgroundTransparency = 0.88; _llIIllIlIl.BorderSizePixel = 0x0
             _llIIllIlIl.ZIndex = 0x4; _llIIllIlIl.Parent = _IlIlIIIIll
             local _llIIllIIll = 0x78
             local _llllllIIll = Instance.new("\070\114\097\109\101")
             _llllllIIll.Size = UDim2.new(0x1, -0x10, 0x0, _llIIllIIll); _llllllIIll.Position = UDim2.new(0x0, 0x8, 0x0, 0x8)
             _llllllIIll.BackgroundColor3 = Color3.fromHSV(_IIlIlIlIIl, 0x1, 0x1); _llllllIIll.BorderSizePixel = 0x0
             _llllllIIll.ClipsDescendants = true; _llllllIIll.ZIndex = 0x5; _llllllIIll.Parent = _IlIlIIIIll
             _IlIIIIIlII(_llllllIIll, 0x6)
             local _IIlIIIIIlI = Instance.new("\070\114\097\109\101")
             _IIlIIIIIlI.Size = UDim2.new(0x1, 0x0, 0x1, 0x0); _IIlIIIIIlI.BackgroundColor3 = Color3.fromRGB(0xFF, 0xFF, 0xFF)
             _IIlIIIIIlI.ZIndex = 0x5; _IIlIIIIIlI.Parent = _llllllIIll
             local _lIIlIIIlII = Instance.new("\085\073\071\114\097\100\105\101\110\116")
             _lIIlIIIlII.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0x0, 0x0), NumberSequenceKeypoint.new(0x1, 0x1)})
             _lIIlIIIlII.Rotation = 0x0; _lIIlIIIlII.Parent = _IIlIIIIIlI
             local _lIIIllIlIl = Instance.new("\070\114\097\109\101")
             _lIIIllIlIl.Size = UDim2.new(0x1, 0x0, 0x1, 0x0); _lIIIllIlIl.BackgroundColor3 = Color3.fromRGB(0x0, 0x0, 0x0)
             _lIIIllIlIl.ZIndex = 0x6; _lIIIllIlIl.Parent = _llllllIIll
             local _IIlIIIllIl = Instance.new("\085\073\071\114\097\100\105\101\110\116")
             _IIlIIIllIl.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0x0, 0x1), NumberSequenceKeypoint.new(0x1, 0x0)})
             _IIlIIIllIl.Rotation = 0x5A; _IIlIIIllIl.Parent = _lIIIllIlIl
             local _IIIIIIIlll = Instance.new("\070\114\097\109\101")
             _IIIIIIIlll.Size = UDim2.new(0x0, 0xE, 0x0, 0xE); _IIIIIIIlll.AnchorPoint = Vector2.new(0.5, 0.5)
             _IIIIIIIlll.Position = UDim2.new(_s, 0x0, 0x1 - _v2, 0x0); _IIIIIIIlll.BackgroundColor3 = Color3.fromRGB(0xFF, 0xFF, 0xFF)
             _IIIIIIIlll.BorderSizePixel = 0x0; _IIIIIIIlll.ZIndex = 0x8; _IIIIIIIlll.Parent = _llllllIIll
             _IlIIIIIlII(_IIIIIIIlll, 0x7); _IlIIllIIIl(_IIIIIIIlll, Color3.fromRGB(0xFF, 0xFF, 0xFF), 0x2, 0.2)
             local _lIIIlIlllI = Instance.new("\084\101\120\116\066\117\116\116\111\110")
             _lIIIlIlllI.Size = UDim2.new(0x1, 0x0, 0x1, 0x0); _lIIIlIlllI.BackgroundTransparency = 0x1
             _lIIIlIlllI.Text = ""; _lIIIlIlllI.ZIndex = 0x9; _lIIIlIlllI.Parent = _llllllIIll
             local _IllIlllIIl = 0xE
             local _IlllllIIlI = Instance.new("\070\114\097\109\101")
             _IlllllIIlI.Size = UDim2.new(0x1, -0x10, 0x0, _IllIlllIIl); _IlllllIIlI.Position = UDim2.new(0x0, 0x8, 0x0, _llIIllIIll + 0xE)
             _IlllllIIlI.BorderSizePixel = 0x0; _IlllllIIlI.ZIndex = 0x5; _IlllllIIlI.ClipsDescendants = true; _IlllllIIlI.Parent = _IlIlIIIIll
             _IlIIIIIlII(_IlllllIIlI, 0x7)
             local _IlIIIIIlll = Instance.new("\085\073\071\114\097\100\105\101\110\116")
             _IlIIIIIlll.Color = ColorSequence.new({
                 ColorSequenceKeypoint.new(0x0,    Color3.fromHSV(0x0,    0x1, 0x1)),
                 ColorSequenceKeypoint.new(0.167, Color3.fromHSV(0.167,0x1, 0x1)),
                 ColorSequenceKeypoint.new(0.333, Color3.fromHSV(0.333,0x1, 0x1)),
                 ColorSequenceKeypoint.new(0.5,  Color3.fromHSV(0.5,  0x1, 0x1)),
                 ColorSequenceKeypoint.new(0.667, Color3.fromHSV(0.667,0x1, 0x1)),
                 ColorSequenceKeypoint.new(0.833, Color3.fromHSV(0.833,0x1, 0x1)),
                 ColorSequenceKeypoint.new(0x1,    Color3.fromHSV(0x0,    0x1, 0x1)),
             })
             _IlIIIIIlll.Parent = _IlllllIIlI
             local _IIlIIlIlIl = Instance.new("\070\114\097\109\101")
             _IIlIIlIlIl.Size = UDim2.new(0x0, 0xC, 0x1, 0x4); _IIlIIlIlIl.AnchorPoint = Vector2.new(0.5, 0.5)
             _IIlIIlIlIl.Position = UDim2.new(_IIlIlIlIIl, 0x0, 0.5, 0x0); _IIlIIlIlIl.BackgroundColor3 = Color3.fromRGB(0xFF, 0xFF, 0xFF)
             _IIlIIlIlIl.BorderSizePixel = 0x0; _IIlIIlIlIl.ZIndex = 0x7; _IIlIIlIlIl.Parent = _IlllllIIlI
             _IlIIIIIlII(_IIlIIlIlIl, 0x4); _IlIIllIIIl(_IIlIIlIlIl, Color3.fromRGB(0xC8, 0xC8, 0xC8), 1.5, 0.3)
             local _IIllIIlIIl = Instance.new("\084\101\120\116\066\117\116\116\111\110")
             _IIllIIlIIl.Size = UDim2.new(0x1, 0x0, 0x1, 0x0); _IIllIIlIIl.BackgroundTransparency = 0x1
             _IIllIIlIIl.Text = ""; _IIllIIlIIl.ZIndex = 0x8; _IIllIIlIIl.Parent = _IlllllIIlI
             local _IIIllIlllI = _llIIllIIll + 0xE + _IllIlllIIl + 0xA
             local _IIllIlIIll = Instance.new("\070\114\097\109\101")
             _IIllIlIIll.Size = UDim2.new(0x1, -0x10, 0x0, 0x1C); _IIllIlIIll.Position = UDim2.new(0x0, 0x8, 0x0, _IIIllIlllI)
             _IIllIlIIll.BackgroundColor3 = _lllIIlIIll.InputBg; _IIllIlIIll.BackgroundTransparency = 0.03
             _IIllIlIIll.BorderSizePixel = 0x0; _IIllIlIIll.ZIndex = 0x5; _IIllIlIIll.Parent = _IlIlIIIIll
             _IlIIIIIlII(_IIllIlIIll, 0x7)
             local _llIlIIIlll = _IlIIllIIIl(_IIllIlIIll, _lllIIlIIll.CompStroke, 0x1, 0.3)
             local _IlIlIIIlll = Instance.new("\084\101\120\116\076\097\098\101\108")
             _IlIlIIIlll.Size = UDim2.new(0x0, 0x14, 0x1, 0x0); _IlIlIIIlll.Position = UDim2.new(0x0, 0x6, 0x0, 0x0)
             _IlIlIIIlll.BackgroundTransparency = 0x1; _IlIlIIIlll.Text = "\035"; _IlIlIIIlll.TextColor3 = _lllIIlIIll.SubText
             _IlIlIIIlll.Font = _IllIIIlIll.Bold; _IlIlIIIlll.TextSize = 0xB; _IlIlIIIlll.ZIndex = 0x6; _IlIlIIIlll.Parent = _IIllIlIIll
             local _lIIIIllIlI = Instance.new("\084\101\120\116\066\111\120")
             _lIIIIllIlI.Size = UDim2.new(0x1, -0x1C, 0x1, 0x0); _lIIIIllIlI.Position = UDim2.new(0x0, 0x16, 0x0, 0x0)
             _lIIIIllIlI.BackgroundTransparency = 0x1; _lIIIIllIlI.BorderSizePixel = 0x0
             _lIIIIllIlI.PlaceholderText = "\082\082\071\071\066\066"; _lIIIIllIlI.PlaceholderColor3 = Color3.fromRGB(0x46, 0x46, 0x5A)
             _lIIIIllIlI.TextColor3 = _lllIIlIIll.Text; _lIIIIllIlI.Font = _IllIIIlIll.Bold; _lIIIIllIlI.TextSize = 0xB
             _lIIIIllIlI.ClearTextOnFocus = true; _lIIIIllIlI.ZIndex = 0x6; _lIIIIllIlI.Parent = _IIllIlIIll
             local function _IllIIlIIll() return Color3.fromHSV(_IIlIlIlIIl, _s, _v2) end
             local function _IlIIlIlIII(_IlIIlllIll)
                 return string.format("\037\048\050\088\037\048\050\088\037\048\050\088", math.floor(_IlIIlllIll.R*0xFF+0.5), math.floor(_IlIIlllIll.G*0xFF+0.5), math.floor(_IlIIlllIll.B*0xFF+0.5))
             end
             local function _lIlIIllIIl(skipHex)
                 local _IlIIlllIll = _IllIIlIIll()
                 _lIlllllIIl.BackgroundColor3 = _IlIIlllIll
                 _llllllIIll.BackgroundColor3 = Color3.fromHSV(_IIlIlIlIIl, 0x1, 0x1)
                 _IIIIIIIlll.Position = UDim2.new(_s, 0x0, 0x1 - _v2, 0x0)
                 _IIlIIlIlIl.Position = UDim2.new(_IIlIlIlIIl, 0x0, 0.5, 0x0)
                 if not skipHex then _lIIIIllIlI.Text = _IlIIlIlIII(_IlIIlllIll) end
                 pcall(_lllIlIIIll, _IlIIlllIll)
             end
             local function _IIIllIIlII(_lIIlIIllII)
                 _s = math.clamp((_lIIlIIllII.Position.X - _llllllIIll.AbsolutePosition.X) / _llllllIIll.AbsoluteSize.X, 0x0, 0x1)
                 _v2 = 0x1 - math.clamp((_lIIlIIllII.Position.Y - _llllllIIll.AbsolutePosition.Y) / _llllllIIll.AbsoluteSize.Y, 0x0, 0x1)
                 _lIlIIllIIl()
             end
             local function _IIlIIlllII(_lIIlIIllII)
                 _IIlIlIlIIl = math.clamp((_lIIlIIllII.Position.X - _IlllllIIlI.AbsolutePosition.X) / _IlllllIIlI.AbsoluteSize.X, 0x0, 0x1)
                 _lIlIIllIIl()
             end
             _lIIIlIlllI.InputBegan:Connect(function(_lIIlIIllII)
                 if _lIIlIIllII.UserInputType == Enum.UserInputType.MouseButton1 or _lIIlIIllII.UserInputType == Enum.UserInputType.Touch then
                     local _lIIlIIlIlI = _lIIlIIllII.UserInputType == Enum.UserInputType.Touch
                     _IIIllIIlII(_lIIlIIllII)
                     local _IIIIIIIIIl, _lllIlIlllI
                     _IIIIIIIIIl = _IIlIllIIIl.InputChanged:Connect(function(mi)
                         if _lIIlIIlIlI then
                             if mi.UserInputType == Enum.UserInputType.Touch then _IIIllIIlII(mi) end
                         else
                             if mi.UserInputType == Enum.UserInputType.MouseMovement then _IIIllIIlII(mi) end
                         end
                     end)
                     _lllIlIlllI = _IIlIllIIIl.InputEnded:Connect(function(ei)
                         local _lIlIllllII = (_lIIlIIlIlI and ei.UserInputType == Enum.UserInputType.Touch)
                             or (not _lIIlIIlIlI and ei.UserInputType == Enum.UserInputType.MouseButton1)
                         if _lIlIllllII then _IIIIIIIIIl:Disconnect(); _lllIlIlllI:Disconnect() end
                     end)
                 end
             end)
             _IIllIIlIIl.InputBegan:Connect(function(_lIIlIIllII)
                 if _lIIlIIllII.UserInputType == Enum.UserInputType.MouseButton1 or _lIIlIIllII.UserInputType == Enum.UserInputType.Touch then
                     local _lIIlIIlIlI = _lIIlIIllII.UserInputType == Enum.UserInputType.Touch
                     _IIlIIlllII(_lIIlIIllII)
                     local _IIIIIIIIIl, _lllIlIlllI
                     _IIIIIIIIIl = _IIlIllIIIl.InputChanged:Connect(function(mi)
                         if _lIIlIIlIlI then
                             if mi.UserInputType == Enum.UserInputType.Touch then _IIlIIlllII(mi) end
                         else
                             if mi.UserInputType == Enum.UserInputType.MouseMovement then _IIlIIlllII(mi) end
                         end
                     end)
                     _lllIlIlllI = _IIlIllIIIl.InputEnded:Connect(function(ei)
                         local _lIlIllllII = (_lIIlIIlIlI and ei.UserInputType == Enum.UserInputType.Touch)
                             or (not _lIIlIIlIlI and ei.UserInputType == Enum.UserInputType.MouseButton1)
                         if _lIlIllllII then _IIIIIIIIIl:Disconnect(); _lllIlIlllI:Disconnect() end
                     end)
                 end
             end)
             _lIIIIllIlI.Focused:Connect(function() _llIlIIIlll.Color = _lllIIlIIll.SliderFill; _llIlIIIlll.Transparency = 0.1 end)
             _lIIIIllIlI.FocusLost:Connect(function()
                 _llIlIIIlll.Color = _lllIIlIIll.CompStroke; _llIlIIIlll.Transparency = 0.3
                 local _lIlIlIIIIl = _lIIIIllIlI.Text:gsub("\035",""):upper()
                 if #_lIlIlIIIIl == 0x6 then
                     local _IIlIlIllII=tonumber(_lIlIlIIIIl:sub(0x1,0x2),0x10); local _IIllIIllIl=tonumber(_lIlIlIIIIl:sub(0x3,0x4),0x10); local _IIIIlIlllI=tonumber(_lIlIlIIIIl:sub(0x5,0x6),0x10)
                     if _IIlIlIllII and _IIllIIllIl and _IIIIlIlllI then
                         _IIlIlIlIIl,_s,_v2 = Color3.toHSV(Color3.fromRGB(_IIlIlIllII,_IIllIIllIl,_IIIIlIlllI)); _lIlIIllIIl(true)
                     end
                 end
                 _lIIIIllIlI.Text = _IlIIlIlIII(_IllIIlIIll())
             end)
             local _IIllIlIIII = Instance.new("\084\101\120\116\066\117\116\116\111\110")
             _IIllIlIIII.Size = UDim2.new(0x1, 0x0, 0x0, 0x2C); _IIllIlIIII.BackgroundTransparency = 0x1
             _IIllIlIIII.Text = ""; _IIllIlIIII.ZIndex = 0xA; _IIllIlIIII.Parent = _IIIIIIlIll
             _IIllIlIIII.MouseButton1Click:Connect(function()
                 _IIIlIlIIIl = not _IIIlIlIIIl
                 _IllllIllII(_llIIlIllIl, {Rotation = _IIIlIlIIIl and 0xB4 or 0x0}, 0.18)
                 if _IIIlIlIIIl then
                     _IlIlIIIIll.Visible = true; _IIIIIIlIll.ClipsDescendants = false
                     _lIIIIllIlI.Text = _IlIIlIlIII(_IllIIlIIll())
                     _IllllIllII(_IIIIIIlIll, {Size = UDim2.new(0.96, 0x0, 0x0, 0x2C + _IlIllIlIlI)}, 0.22, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
                     local _llIIIlIIll = _lIIllIIllI() + _IlIllIlIlI
                     _IIIIlIlIII.Size = UDim2.new(0x1, 0x0, 0x0, _llIIIlIIll)
                     _IllllIllII(_IIlllllllI, {Size = UDim2.new(0.97, 0x0, 0x0, 0x24 + _llIIIlIIll + 0x4)}, 0.22, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
                 else
                     _IllllIllII(_IIIIIIlIll, {Size = UDim2.new(0.96, 0x0, 0x0, 0x2C)}, 0.22, Enum.EasingStyle.Quart, Enum.EasingDirection.In)
                     local _llIIIlIIll = _lIIllIIllI() - _IlIllIlIlI
                     _IIIIlIlIII.Size = UDim2.new(0x1, 0x0, 0x0, _llIIIlIIll)
                     _IllllIllII(_IIlllllllI, {Size = UDim2.new(0.97, 0x0, 0x0, 0x24 + _llIIIlIIll + 0x4)}, 0.22, Enum.EasingStyle.Quart, Enum.EasingDirection.In)
                     task.delay(0.23, function()
                         if not _IIIlIlIIIl then _IlIlIIIIll.Visible = false; _IIIIIIlIll.ClipsDescendants = true end
                     end)
                 end
             end)
             _lIlIIllIIl(true); _lIIIIllIlI.Text = _IlIIlIlIII(_IllIIlIIll())
             local _lIlIIIlIll = {}
             function _lIlIIIlIll:SetValue(_IlIIlllIll) _IIlIlIlIIl,_s,_v2 = Color3.toHSV(_IlIIlllIll); _lIlIIllIIl() end
             function _lIlIIIlIll:GetValue() return _IllIIlIIll() end
             function _lIlIIIlIll:SetEnabled(e) _IIllIlIIII.Active=e; _IIIIIIlIll.BackgroundTransparency=e and 0.03 or 0.5 end
             function _lIlIIIlIll:SetVisible(v)
                 _IIIIIIlIll.Visible=v
                 if not v and _IIIlIlIIIl then _IIIlIlIIIl=false; _IlIlIIIIll.Visible=false; _IIIIIIlIll.ClipsDescendants=true; _IIIIIIlIll.Size=UDim2.new(0.96,0x0,0x0,0x2C) end
                 _IIIllIIlII()
             end
             function _lIlIIIlIll:Destroy()
                 if _IIIlIlIIIl then _IIIlIlIIIl=false; _IlIlIIIIll.Visible=false end
                 _IIIIIIlIll:Destroy(); _IIIllIIlII()
             end
             function _lIlIIIlIll:UpdateCallback(newCb) _lllIlIIIll=newCb end
             return _lIlIIIlIll
         end
         function _llIIlIllIl:CreateTextBox(labelText, ph, _lllIlIIIll, config)
             config=config or {}
             _lllIlIIIll = _lllIlIIIll or function() end
             local _lIlIIIlllI=config.MaxLength or 0xC8; local _IlIIIllIll=config.NumberOnly or false; local _IIIIIlllII=config.RealTime or false
             local _lIlIIlIIll=_lIIlIIlllI(0x2C)
             local _lIlllIllII=Instance.new("\084\101\120\116\076\097\098\101\108"); _lIlllIllII.Size=UDim2.new(0x1,-0xA8,0x1,0x0); _lIlllIllII.Position=UDim2.new(0x0,0xE,0x0,0x0)
             _lIlllIllII.BackgroundTransparency=0x1; _lIlllIllII.Text=labelText; _lIlllIllII.TextColor3=_lllIIlIIll.Text
             _lIlllIllII.Font=_IllIIIlIll.Medium; _lIlllIllII.TextSize=0xC; _lIlllIllII.TextXAlignment=Enum.TextXAlignment.Left
             _lIlllIllII.TextTruncate=Enum.TextTruncate.AtEnd; _lIlllIllII.Parent=_lIlIIlIIll
             local _IIIIllllIl=Instance.new("\070\114\097\109\101"); _IIIIllllIl.Size=UDim2.new(0x0,0x90,0x0,0x1E); _IIIIllllIl.Position=UDim2.new(0x1,-0x9A,0x0,0x7)
             _IIIIllllIl.BackgroundColor3=_lllIIlIIll.InputBg; _IIIIllllIl.BackgroundTransparency=0.03; _IIIIllllIl.BorderSizePixel=0x0; _IIIIllllIl.Parent=_lIlIIlIIll
             _IlIIIIIlII(_IIIIllllIl,0x8); local _lllIllIIII=_IlIIllIIIl(_IIIIllllIl,_lllIIlIIll.InputStroke,0x1,0.24)
             local _lIIlIIllII=Instance.new("\084\101\120\116\066\111\120"); _lIIlIIllII.Size=UDim2.new(0x1,-0xA,0x1,0x0); _lIIlIIllII.Position=UDim2.new(0x0,0x5,0x0,0x0)
             _lIIlIIllII.BackgroundTransparency=0x1; _lIIlIIllII.BorderSizePixel=0x0; _lIIlIIllII.Text=""
             _lIIlIIllII.PlaceholderText=ph or "\069\110\116\101\114\032\116\101\120\116\046\046\046"; _lIIlIIllII.PlaceholderColor3=Color3.fromRGB(0x50,0x50,0x64)
             _lIIlIIllII.TextColor3=_lllIIlIIll.Text; _lIIlIIllII.Font=_IllIIIlIll.Body; _lIIlIIllII.TextSize=0xB; _lIIlIIllII.ClearTextOnFocus=false; _lIIlIIllII.Parent=_IIIIllllIl
             local _llllIIIllI=false
             _lIIlIIllII:GetPropertyChangedSignal("\084\101\120\116"):Connect(function()
                 if _llllIIIllI then return end; _llllIIIllI=true
                 local _lIIllIlIIl=_lIIlIIllII.Text
                 if _IlIIIllIll then local _llllIlIIII=_lIIllIlIIl:match("\094\037\045\063\037\100\042\037\046\063\037\100\042") or ""; if _llllIlIIII~=_lIIllIlIIl then _lIIllIlIIl=_llllIlIIII; _lIIlIIllII.Text=_lIIllIlIIl end end
                 if #_lIIllIlIIl>_lIlIIIlllI then _lIIllIlIIl=_lIIllIlIIl:sub(0x1,_lIlIIIlllI); _lIIlIIllII.Text=_lIIllIlIIl end
                 _llllIIIllI=false; if _IIIIIlllII then pcall(_lllIlIIIll, _lIIlIIllII.Text) end
             end)
             _lIIlIIllII.Focused:Connect(function() _IllllIllII(_IIIIllllIl,{BackgroundColor3=Color3.fromRGB(0x1C,0x1E,0x30)},0.14); _lllIllIIII.Color=_lllIIlIIll.SliderFill; _lllIllIIII.Transparency=0.1 end)
             _lIIlIIllII.FocusLost:Connect(function(enterPressed)
                 _IllllIllII(_IIIIllllIl,{BackgroundColor3=_lllIIlIIll.InputBg},0.14); _lllIllIIII.Color=_lllIIlIIll.InputStroke; _lllIllIIII.Transparency=0.24
                 if not _IIIIIlllII or enterPressed then pcall(_lllIlIIIll, _lIIlIIllII.Text) end
             end)
             local _lIlIIIlIll={}
             function _lIlIIIlIll:SetValue(v) _lIIlIIllII.Text=tostring(v) end
             function _lIlIIIlIll:GetValue() return _lIIlIIllII.Text end
             function _lIlIIIlIll:Clear() _lIIlIIllII.Text="" end
             function _lIlIIIlIll:SetEnabled(e) _lIIlIIllII.Editable=e; _lIlIIlIIll.BackgroundTransparency=e and 0.03 or 0.5 end
             function _lIlIIIlIll:SetVisible(v) _lIlIIlIIll.Visible=v; _IIIllIIlII() end
             function _lIlIIIlIll:Destroy() _lIlIIlIIll:Destroy(); _IIIllIIlII() end
             function _lIlIIIlIll:UpdateCallback(newCb) _lllIlIIIll=newCb end
             return _lIlIIIlIll
         end
         function _llIIlIllIl:CreateSeparator()
             local _lIIllIlIll=Instance.new("\070\114\097\109\101"); _lIIllIlIll.Size=UDim2.new(0.88,0x0,0x0,0x1)
             _lIIllIlIll.BackgroundColor3=Color3.fromRGB(0xFF,0xFF,0xFF); _lIIllIlIll.BackgroundTransparency=0.88
             _lIIllIlIll.BorderSizePixel=0x0; _lIIllIlIll.LayoutOrder=_lllIIlIlIl(); _lIIllIlIll.Parent=_IIIIlIlIII
             _IIIllIIlII()
             local _lIlIIIlIll={}
             function _lIlIIIlIll:SetVisible(v) _lIIllIlIll.Visible=v; _IIIllIIlII() end
             function _lIlIIIlIll:Destroy() _lIIllIlIll:Destroy(); _IIIllIIlII() end
             return _lIlIIIlIll
         end
         function _llIIlIllIl:CreateProgressBar(_llllIIllll, defVal, maxVal)
             defVal=math.clamp(defVal or 0x0,0x0,maxVal or 0x64); maxVal=maxVal or 0x64
             local _IIlIlIllll=defVal; local _lIlIIlIIll=_lIIlIIlllI(0x34)
             local _lIlllIllII=Instance.new("\084\101\120\116\076\097\098\101\108"); _lIlllIllII.Size=UDim2.new(0x1,-0x3E,0x0,0x12); _lIlllIllII.Position=UDim2.new(0x0,0xE,0x0,0x8)
             _lIlllIllII.BackgroundTransparency=0x1; _lIlllIllII.Text=_llllIIllll; _lIlllIllII.TextColor3=_lllIIlIIll.Text
             _lIlllIllII.Font=_IllIIIlIll.Medium; _lIlllIllII.TextSize=0xC; _lIlllIllII.TextXAlignment=Enum.TextXAlignment.Left
             _lIlllIllII.TextTruncate=Enum.TextTruncate.AtEnd; _lIlllIllII.Parent=_lIlIIlIIll
             local _IlIlIIlllI=Instance.new("\084\101\120\116\076\097\098\101\108"); _IlIlIIlllI.Size=UDim2.new(0x0,0x2C,0x0,0x12); _IlIlIIlllI.Position=UDim2.new(0x1,-0x36,0x0,0x8)
             _IlIlIIlllI.BackgroundTransparency=0x1; _IlIlIIlllI.Text=math.floor((defVal/maxVal)*0x64).."\037"
             _IlIlIIlllI.TextColor3=_lllIIlIIll.SliderFill; _IlIlIIlllI.Font=_IllIIIlIll.Bold; _IlIlIIlllI.TextSize=0xB
             _IlIlIIlllI.TextXAlignment=Enum.TextXAlignment.Right; _IlIlIIlllI.Parent=_lIlIIlIIll
             local _IllIlllIII=Instance.new("\070\114\097\109\101"); _IllIlllIII.Size=UDim2.new(0x1,-0x1A,0x0,0x8); _IllIlllIII.Position=UDim2.new(0x0,0xE,0x0,0x22)
             _IllIlllIII.BackgroundColor3=_lllIIlIIll.ProgressBg; _IllIlllIII.BorderSizePixel=0x0; _IllIlllIII.ClipsDescendants=true; _IllIlllIII.Parent=_lIlIIlIIll
             _IlIIIIIlII(_IllIlllIII,0x4)
             local _IIlIIllIII=Instance.new("\070\114\097\109\101"); _IIlIIllIII.Size=UDim2.new(defVal/maxVal,0x0,0x1,0x0)
             _IIlIIllIII.BackgroundColor3=_lllIIlIIll.ProgressFill; _IIlIIllIII.BorderSizePixel=0x0; _IIlIIllIII.Parent=_IllIlllIII
             _IlIIIIIlII(_IIlIIllIII,0x4)
             local _lIlIIIlIll={}
             function _lIlIIIlIll:SetValue(v)
                 _IIlIlIllll=math.clamp(v,0x0,maxVal); local _lIIlIIIIII=_IIlIlIllll/maxVal
                 _IllllIllII(_IIlIIllIII,{Size=UDim2.new(_lIIlIIIIII,0x0,0x1,0x0)},0.3,Enum.EasingStyle.Quart,Enum.EasingDirection.Out)
                 _IlIlIIlllI.Text=math.floor(_lIIlIIIIII*0x64).."\037"
             end
             function _lIlIIIlIll:GetValue() return _IIlIlIllll end
             function _lIlIIIlIll:SetVisible(v) _lIlIIlIIll.Visible=v; _IIIllIIlII() end
             function _lIlIIIlIll:Destroy() _lIlIIlIIll:Destroy(); _IIIllIIlII() end
             return _lIlIIIlIll
         end
         function _llIIlIllIl:CreateRadioGroup(config, _legacyDefault, _legacyCb, _legacyMulti)
             if type(config)=="\116\097\098\108\101" and config[0x1]~=nil then
                 config={Options=config,Default=_legacyDefault or 0x1,Callback=_legacyCb or function() end,MultiSelect=_legacyMulti or false}
             end
             local _IIIIlIlIll=config.Options or {"\079\112\116\105\111\110\032\049"}; local _lIIIlIIIII=config.Default or 0x1
             local _lllIlIIIll=config.Callback or function() end; local _IlllIllIIl=config.MultiSelect or false
             local _IIllIIIIll={}; local _IIlllllIlI={}
             if _IlllIllIIl then _IIllIIIIll={}; _IIllIIIIll[_lIIIlIIIII]=true else _IIllIIIIll=_lIIIlIIIII end
             local _lIIlllIllI=0x20
             local _IllIIlIIIl=Instance.new("\070\114\097\109\101"); _IllIIlIIIl.Size=UDim2.new(0.96,0x0,0x0,#_IIIIlIlIll*_lIIlllIllI+0x8)
             _IllIIlIIIl.BackgroundColor3=_lllIIlIIll.ComponentBg; _IllIIlIIIl.BackgroundTransparency=0.03
             _IllIIlIIIl.BorderSizePixel=0x0; _IllIIlIIIl.LayoutOrder=_lllIIlIlIl(); _IllIIlIIIl.Parent=_IIIIlIlIII
             _IlIIIIIlII(_IllIIlIIIl,0xA); _IlIIllIIIl(_IllIIlIIIl,Color3.fromRGB(0xFF,0xFF,0xFF),0x1,0.92)
             for i,option in ipairs(_IIIIlIlIll) do
                 local _IIllIlIllI=_IlllIllIIl and (_IIllIIIIll[i] or false) or (i==_lIIIlIIIII)
                 local _IlIIIIIllI=Instance.new("\070\114\097\109\101"); _IlIIIIIllI.Size=UDim2.new(0.92,0x0,0x0,0x1C)
                 _IlIIIIIllI.Position=UDim2.new(0.04,0x0,0x0,0x4+(i-0x1)*_lIIlllIllI); _IlIIIIIllI.BackgroundTransparency=0x1; _IlIIIIIllI.Parent=_IllIIlIIIl
                 local _llIlIIIIll=Instance.new("\070\114\097\109\101"); _llIlIIIIll.Size=UDim2.new(0x0,0x12,0x0,0x12); _llIlIIIIll.Position=UDim2.new(0x0,0x0,0x0,0x5)
                 _llIlIIIIll.BackgroundColor3=_IIllIlIllI and _lllIIlIIll.SliderFill or _lllIIlIIll.ToggleOff; _llIlIIIIll.BorderSizePixel=0x0; _llIlIIIIll.Parent=_IlIIIIIllI
                 _IlIIIIIlII(_llIlIIIIll,0x9)
                 local _llIlIIIIII=Instance.new("\070\114\097\109\101"); _llIlIIIIII.Size=UDim2.new(0x0,0x8,0x0,0x8); _llIlIIIIII.Position=UDim2.new(0x0,0x5,0x0,0x5)
                 _llIlIIIIII.BackgroundColor3=Color3.fromRGB(0xFF,0xFF,0xFF); _llIlIIIIII.BorderSizePixel=0x0; _llIlIIIIII.Visible=_IIllIlIllI; _llIlIIIIII.Parent=_llIlIIIIll
                 _IlIIIIIlII(_llIlIIIIII,0x4)
                 local _lIIIIlIllI=Instance.new("\084\101\120\116\076\097\098\101\108"); _lIIIIlIllI.Size=UDim2.new(0x1,-0x1A,0x1,0x0); _lIIIIlIllI.Position=UDim2.new(0x0,0x18,0x0,0x0)
                 _lIIIIlIllI.BackgroundTransparency=0x1; _lIIIIlIllI.Text=option; _lIIIIlIllI.TextColor3=_lllIIlIIll.Text
                 _lIIIIlIllI.Font=_IllIIIlIll.Medium; _lIIIIlIllI.TextSize=0xC; _lIIIIlIllI.TextXAlignment=Enum.TextXAlignment.Left; _lIIIIlIllI.Parent=_IlIIIIIllI
                 local _llIlIlIlII=Instance.new("\084\101\120\116\066\117\116\116\111\110"); _llIlIlIlII.Size=UDim2.new(0x1,0x0,0x1,0x0); _llIlIlIlII.BackgroundTransparency=0x1; _llIlIlIlII.Text=""; _llIlIlIlII.Parent=_IlIIIIIllI
                 _llIlIlIlII.MouseButton1Click:Connect(function()
                     if _IlllIllIIl then
                         _IIllIIIIll[i]=not _IIllIIIIll[i]; local _IlIIllIIll=_IIllIIIIll[i]
                         _IllllIllII(_IIlllllIlI[i].circle,{BackgroundColor3=_IlIIllIIll and _lllIIlIIll.SliderFill or _lllIIlIIll.ToggleOff},0.18)
                         _IIlllllIlI[i].dot.Visible=_IlIIllIIll
                         local _IlIIIlIIll={}
                         for _llIIIIlIII,_IlIlIllIll in pairs(_IIllIIIIll) do if _IlIlIllIll then table.insert(_IlIIIlIIll,_IIIIlIlIll[_llIIIIlIII]) end end
                         pcall(_lllIlIIIll, _IIllIIIIll, _IlIIIlIIll)
                     else
                         _IIllIIIIll=i
                         for j,data in ipairs(_IIlllllIlI) do
                             local _IlIIllIIll=(j==i)
                             _IllllIllII(data.circle,{BackgroundColor3=_IlIIllIIll and _lllIIlIIll.SliderFill or _lllIIlIIll.ToggleOff},0.18)
                             data.dot.Visible=_IlIIllIIll
                         end
                         pcall(_lllIlIIIll, i, _IIIIlIlIll[i])
                     end
                 end)
                 table.insert(_IIlllllIlI,{_llIlIIIIll=_llIlIIIIll,_llIlIIIIII=_llIlIIIIII})
             end
             local _lIlIIIlIll={}
             function _lIlIIIlIll:SetValue(index)
                 if _IlllIllIIl then
                     if type(index)=="\116\097\098\108\101" then _IIllIIIIll=index else _IIllIIIIll[index]=not _IIllIIIIll[index] end
                     for i,data in ipairs(_IIlllllIlI) do
                         local _IlIIllIIll=_IIllIIIIll[i]; _IllllIllII(data.circle,{BackgroundColor3=_IlIIllIIll and _lllIIlIIll.SliderFill or _lllIIlIIll.ToggleOff},0.18); data.dot.Visible=_IlIIllIIll
                     end
                     local _IlIIIlIIll={}
                     for _llIIIIlIII,_IlIlIllIll in pairs(_IIllIIIIll) do if _IlIlIllIll then table.insert(_IlIIIlIIll,_IIIIlIlIll[_llIIIIlIII]) end end
                     pcall(_lllIlIIIll, _IIllIIIIll, _IlIIIlIIll)
                 else
                     _IIllIIIIll=index
                     for i,data in ipairs(_IIlllllIlI) do
                         local _IlIIllIIll=(i==index); _IllllIllII(data.circle,{BackgroundColor3=_IlIIllIIll and _lllIIlIIll.SliderFill or _lllIIlIIll.ToggleOff},0.18); data.dot.Visible=_IlIIllIIll
                     end
                     pcall(_lllIlIIIll, index, _IIIIlIlIll[index])
                 end
             end
             function _lIlIIIlIll:GetValue() return _IIllIIIIll end
             function _lIlIIIlIll:SetEnabled(e) _IllIIlIIIl.BackgroundTransparency=e and 0.03 or 0.5 end
             function _lIlIIIlIll:SetVisible(v) _IllIIlIIIl.Visible=v; _IIIllIIlII() end
             function _lIlIIIlIll:Destroy() _IllIIlIIIl:Destroy(); _IIIllIIlII() end
             function _lIlIIIlIll:UpdateCallback(newCb) _lllIlIIIll=newCb end
             return _lIlIIIlIll
         end
         function _llIIlIllIl:Collapse()
             if not _IIIIIlIIII then
                 _IIIIIlIIII=true; _IllllIllII(_IIlIllIIII,{Rotation=0x0},0.24)
                 _IllllIllII(_IIlllllllI,{Size=UDim2.new(0.97,0x0,0x0,0x24)},0.26,Enum.EasingStyle.Quart,Enum.EasingDirection.Out)
                 task.delay(0.27,function() _IIIIlIlIII.Visible=false end)
             end
         end
         function _llIIlIllIl:Expand()
             if _IIIIIlIIII then _IIIIIlIIII=false; _IIIIlIlIII.Visible=true; _IllllIllII(_IIlIllIIII,{Rotation=0x5A},0.24); _IIIllIIlII() end
         end
         function _llIIlIllIl:SetTitle(_lIIllIlIIl) _IIIIlIlllI.Text=_lIIllIlIIl end
         function _llIIlIllIl:Destroy() _IIlllllllI:Destroy() end
         return _llIIlIllIl
     end
     return _lIlllIllII
 end
 _lIIlIIIlll.MouseButton1Click:Connect(function() _llllIIlIII:Destroy() end)
 _lIIlllllIl.MouseButton1Click:Connect(function()
     if _IlIIlllllI then _llllllllIl() else _IlIIlllIll() end
 end)
 _IIIIlllIll.MouseButton1Click:Connect(function()
     if _IlIIlllllI then
         _IlIIlllllI=false; _lllIIlllIl.Visible=true; _IIIlIIlIlI.Visible=true; _IllIIIllII.Visible=true
         _llIllIlIlI.Visible=true; _llIIIllIIl.Visible=true
         _IlIIlllIIl.ClipsDescendants = false
         _IllllIllII(_lIIIIllIIl,{Thickness=1.5},0.3); _IllllIllII(_IlIIIlIIll,{Thickness=0x3},0.3); _IllllIllII(_lIlllllIII,{Thickness=0x6},0.3)
     end
     _lIllIIIIII=not _lIllIIIIII
     local _lIIllIlIll=_lIllIIIIII and _IllIllIIlI or _IlIlIIlllI
     local _IllIlIIIlI=_lIllIIIIII and UDim2.new(0.5,-_IllIllIIlI.X.Offset/0x2,0.5,-_IllIllIIlI.Y.Offset/0x2) or _llIIlIIIII
     _IllllIllII(_IlIIlllIIl,{Size=_lIIllIlIll,Position=_IllIlIIIlI},0.32)
 end)
 local _lllIlIlIIl=false; local _lIlllIIllI,_fs=nil,nil
 _IIIIIIlIIl(_lIlIIlllIl.InputBegan,function(_lIIlIIllII)
     if _lIIlIIllII.UserInputType==Enum.UserInputType.MouseButton1 or _lIIlIIllII.UserInputType==Enum.UserInputType.Touch then
         _lllIlIlIIl=true; _lIlllIIllI=_lIIlIIllII.Position; _fs=_IlIIlllIIl.Position
     end
 end)
 _IIIIIIlIIl(_IIlIllIIIl.InputChanged,function(_lIIlIIllII)
     if _lllIlIlIIl and (_lIIlIIllII.UserInputType==Enum.UserInputType.MouseMovement or _lIIlIIllII.UserInputType==Enum.UserInputType.Touch) then
         local _lIIIllllIl=_lIIlIIllII.Position-_lIlllIIllI
         _IlIIlllIIl.Position=UDim2.new(_fs.X.Scale,_fs.X.Offset+_lIIIllllIl.X,_fs.Y.Scale,_fs.Y.Offset+_lIIIllllIl.Y)
     end
 end)
 _IIIIIIlIIl(_IIlIllIIIl.InputEnded,function(_lIIlIIllII)
     if _lIIlIIllII.UserInputType==Enum.UserInputType.MouseButton1 or _lIIlIIllII.UserInputType==Enum.UserInputType.Touch then _lllIlIlIIl=false end
 end)
 return _llllIIlIII
end
return _IIlIIlIlIl
 end)(...)
