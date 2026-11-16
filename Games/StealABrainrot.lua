-- Games/StealABrainrot.lua
local KreinHub = getgenv().KreinLibrary
local Window   = getgenv().KreinWindow

if not Window then
    warn("[Game] Window tidak ditemukan. Loader gagal?")
    return
end

-- ===== TAB UTAMA =====
local MainTab = Window:CreateTab("Main", "🏠")
local Sec = MainTab:CreateSection("Test Fitur", false) -- false = langsung terbuka

Sec:CreateLabel("Script test untuk Steal a Brainrot. Aman, tidak ada fitur berbahaya.")

-- Toggle
local toggle = Sec:CreateToggle("Test Toggle", false, function(state)
    print("[Test] Toggle:", state)
    if state then
        KreinHub:Notify("Test", "Toggle ON", 2, "success")
    else
        KreinHub:Notify("Test", "Toggle OFF", 2, "info")
    end
end)

-- Slider
local slider = Sec:CreateSlider("Test Slider", 0, 100, 50, function(value)
    print("[Test] Slider:", value)
end, false)

-- Button
Sec:CreateButton("Test Button", function()
    KreinHub:Notify("Test", "Tombol diklik!", 2, "success")
end)

-- Dropdown
local dropdown = Sec:CreateDropdown({
    Text = "Test Dropdown",
    Options = {"Option A", "Option B", "Option C"},
    MultiSelect = false,
    Callback = function(selected)
        print("[Test] Dropdown:", selected)
        KreinHub:Notify("Test", "Dipilih: " .. tostring(selected), 2, "info")
    end
})

-- Keybind
Sec:CreateKeybind("Test Keybind", Enum.KeyCode.F, function(key)
    print("[Test] Keybind:", key.Name)
    KreinHub:Notify("Test", "Keybind: " .. key.Name, 2, "info")
end)

-- Color Picker
Sec:CreateColorPicker("Test Color", Color3.fromRGB(255, 0, 0), function(color)
    print("[Test] Color:", color)
end)

-- TextBox
Sec:CreateTextBox("Test Input", "Ketik sesuatu...", function(text)
    print("[Test] Input:", text)
end, { MaxLength = 50 })

-- Progress Bar
local progress = Sec:CreateProgressBar("Test Progress", 0, 100)
Sec:CreateButton("Isi Progress 100%", function()
    progress:SetValue(100)
end)

-- ===== TAB KEDUA =====
local InfoTab = Window:CreateTab("Info", "ℹ️")
local InfoSec = InfoTab:CreateSection("Tentang", false)

InfoSec:CreateLabel("Krein GUI Library berhasil dimuat di Steal a Brainrot.")
InfoSec:CreateLabel("PlaceId: " .. game.PlaceId)
InfoSec:CreateLabel("Versi: 1.1.0")

KreinHub:Notify("Steal a Brainrot", "Script test berhasil dimuat!", 3, "success")
