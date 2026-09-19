# 🌟 Krein GUI Library

[![Roblox](https://img.shields.io/badge/Platform-Roblox-000000?style=for-the-badge&logo=roblox)](https://www.roblox.com/)
[![Language](https://img.shields.io/badge/Language-Lua-000080?style=for-the-badge&logo=lua)](https://www.lua.org/)
[![License](https://img.shields.io/badge/License-MIT-green.svg?style=for-the-badge)](LICENSE)
[![Version](https://img.shields.io/badge/Version-1.0.0-blue?style=for-the-badge)](https://github.com/liptz341/KreinGuiLibrary)

**Krein GUI Library** adalah pustaka antarmuka (UI Library) premium untuk Roblox yang dirancang dengan fokus pada estetika modern, performa tinggi, dan kelengkapan fitur. Dibangun dari nol menggunakan Roblox Lua API murni, library ini menawarkan animasi *TweenService* yang sangat halus, efek *rainbow stroke*, sistem notifikasi canggih, dan berbagai komponen interaktif siap pakai.

---

## ✨ Fitur Unggulan

- 🎨 **Desain Premium**: Dark theme elegan dengan *UIStroke*, *glow effects*, dan sudut membulat.
- 🌈 **Rainbow Animation**: Animasi border pelangi yang halus pada window utama dan tombol reset.
- 🎬 **Loading Sequence**: Animasi intro khas (Logo shaking & Typewriter effect) saat library dimuat.
- 🧩 **12+ Komponen UI**: Button, Danger Button, Toggle, Slider, Dropdown, Keybind, ColorPicker, TextBox, ProgressBar, Radio Group, Label, dan Separator.
- 🔔 **Sistem Notifikasi**: 4 tipe notifikasi (info, success, warning, error) dengan progress bar animasi.
- ⚙️ **Window Management**: Drag, Resize, Minimize, Maximize, dan panel Settings bawaan.
- 🔍 **Tab Search**: Search bar di sidebar untuk mencari tab dengan cepat.
- 📱 **Mobile Support**: Sepenuhnya mendukung input sentuh (Touch/Mobile).

---

## 📦 Instalasi & Loadstring

Salin dan tempel kode berikut di executor Roblox Anda:

```lua
loadstring(game:HttpGet("https://raw.githubusercontent.com/liptz341/KreinGuiLibrary/refs/heads/main/guilibrary.lua"))()
```

---

## 🚀 Quick Start (Boilerplate)

Berikut adalah template dasar untuk memulai script Anda:

```lua
-- 1. Load Library
local KreinHub = loadstring(game:HttpGet("https://raw.githubusercontent.com/liptz341/KreinGuiLibrary/refs/heads/main/guilibrary.lua"))()

-- 2. Buat Window
local Window = KreinHub:CreateWindow({
    Title = "Krein Hub",
    Subtitle = "Premium UI Library",
    Size = UDim2.new(0, 680, 0, 460),
    Position = UDim2.new(0.5, -340, 0.5, -230)
})

-- 3. Buat Tab
local MainTab = Window:CreateTab("Main", "🏠")
local SettingsTab = Window:CreateTab("Settings", "⚙️")

-- 4. Buat Section
local Section = MainTab:CreateSection("Fitur Utama", false) -- false = langsung dibuka

-- 5. Tambahkan Komponen
Section:CreateLabel("Selamat datang di Krein Hub!")

Section:CreateToggle("Auto Farm", false, function(state)
    print("Auto Farm:", state)
end)

-- 6. Tampilkan Notifikasi
KreinHub:Notify("Berhasil", "Script telah dimuat!", 3, "success")
```

---

## 📚 Dokumentasi API Lengkap

### 🪟 1. Window & Tab Management

#### `KreinHub:CreateWindow(config)`
Membuat window utama. Mengembalikan objek `Window`.
```lua
local Window = KreinHub:CreateWindow({
    Title = "Judul Window",       -- String (Default: "Krein Hub")
    Subtitle = "Sub Judul",       -- String (Default: "Premium UI Library")
    Size = UDim2.new(0, 680, 0, 460), -- UDim2 (Ukuran awal)
    Position = UDim2.new(0.5, -340, 0.5, -230), -- UDim2 (Posisi awal)
    MinSize = UDim2.new(0, 280, 0, 45), -- UDim2 (Ukuran saat minimize)
    MaxSize = UDim2.new(0, 880, 0, 580) -- UDim2 (Ukuran saat maximize)
})
```

#### `Window:CreateTab(name, icon)`
Membuat tab baru. Mengembalikan objek `Tab`.
```lua
local Tab = Window:CreateTab("Home", "🏠") -- icon bersifat opsional (bisa emoji/teks)
```

#### `Tab:CreateSection(title, collapsed)`
Membuat section (kolom) di dalam tab. Mengembalikan objek `Section`.
```lua
local Section = Tab:CreateSection("Pengaturan", false) -- false = section langsung terbuka (default: true)
```

---

### 🧩 2. UI Components (Metode Section)

Semua komponen di bawah ini dipanggil dari objek `Section`. Hampir semua komponen mengembalikan **Object** yang memiliki metode kontrol (lihat bagian *Object Methods* di bawah).

#### 🏷️ Label
Menampilkan teks statis.
```lua
local Label = Section:CreateLabel("Ini adalah teks informasi.")
Label:SetText("Teks baru!") -- Mengubah teks
```

#### 🔘 Button
Tombol aksi standar.
```lua
local Btn = Section:CreateButton("Klik Saya", function()
    print("Tombol diklik!")
end)
Btn:SetActionText("EXECUTE") -- Mengubah teks tombol (default: "CLICK")
```

#### ⚠️ Danger Button
Tombol dengan konfirmasi keamanan (harus klik 2x: "CLICK" -> "SURE?").
```lua
Section:CreateDangerButton("Hapus Data", function()
    print("Data dihapus!")
end)
```

#### 🔁 Toggle
Saklar ON/OFF.
```lua
local Toggle = Section:CreateToggle("Fitur Terbang", false, function(state)
    print("State:", state) -- boolean
end)
Toggle:SetValue(true) -- Mengubah state via script
```

#### 🎚️ Slider
Penggeser nilai (mendukung integer dan float/desimal).
```lua
local Slider = Section:CreateSlider("Kecepatan", 0, 100, 50, function(value)
    print("Value:", value)
end, false) -- Parameter terakhir: false = integer, true = float (desimal)

Slider:SetValue(75)
```

#### 📂 Dropdown
Menu pilihan (mendukung Single & Multi Select).
```lua
local Dropdown = Section:CreateDropdown({
    Text = "Pilih Senjata",
    Options = {"AK-47", "M4A1", "AWP"},
    MultiSelect = false, -- true jika ingin bisa pilih lebih dari satu
    Callback = function(selected)
        print("Dipilih:", selected) -- String (jika single) / Table (jika multi)
    end
})
Dropdown:SetOptions({"Pistol", "Rifle", "Sniper"}) -- Mengubah opsi secara dinamis
```

#### ⌨️ Keybind
Pengikat tombol keyboard.
```lua
local Keybind = Section:CreateKeybind("Tombol Kill", Enum.KeyCode.F, function(key)
    print("Tombol ditekan:", key.Name)
end)
Keybind:SetValue(Enum.KeyCode.G) -- Mengubah keybind via script
```

#### 🎨 ColorPicker
Pemilih warna lengkap dengan panel HSV dan input Hex.
```lua
local Color = Section:CreateColorPicker("Warna ESP", Color3.fromRGB(255, 0, 0), function(color)
    print("RGB:", color.R, color.G, color.B)
end)
Color:SetValue(Color3.fromRGB(0, 255, 0))
```

#### 📝 TextBox
Kolom input teks (mendukung filter angka & real-time).
```lua
local Input = Section:CreateTextBox("Player Name", "Ketik nama...", function(text)
    print("Teks:", text)
end, {
    MaxLength = 20,   -- Batas karakter
    NumberOnly = false, -- true = hanya bisa input angka
    RealTime = false    -- true = callback dipanggil setiap huruf diketik
})
Input:Clear() -- Mengosongkan teks
```

#### 📊 Progress Bar
Bar progres (tidak interaktif, hanya visual).
```lua
local Progress = Section:CreateProgressBar("Loading...", 0, 100)
Progress:SetValue(50) -- Mengisi 50% dengan animasi
```

#### 🔘 Radio Group
Pilihan radio (Single/Multi).
```lua
local Radio = Section:CreateRadioGroup({
    Options = {"Mode A", "Mode B", "Mode C"},
    Default = 1,       -- Index default (mulai dari 1)
    MultiSelect = false,
    Callback = function(index, value)
        print("Index:", index, "Value:", value)
    end
})
```

#### 📏 Separator
Garis pemisah horizontal.
```lua
Section:CreateSeparator()
```

---

### 🔔 3. Sistem Notifikasi

#### `KreinHub:Notify(title, message, duration, nType)`
Menampilkan notifikasi *slide-in* di pojok kanan atas.
```lua
KreinHub:Notify("Sukses", "Berhasil teleport!", 4, "success")
```
**Tipe Notifikasi (`nType`):**
- `"info"` (Biru)
- `"success"` (Hijau)
- `"warning"` (Kuning)
- `"error"` (Merah)

---

### 🛠️ 4. Object Methods (Metode Kontrol)

Hampir semua komponen di atas mengembalikan sebuah **Object**. Anda dapat menggunakan metode berikut untuk mengontrol komponen secara programatis:

| Metode | Deskripsi |
|--------|-----------|
| `:SetValue(val)` | Mengubah nilai komponen (Toggle, Slider, Dropdown, Keybind, ColorPicker, TextBox, ProgressBar, RadioGroup). |
| `:GetValue()` | Mengembalikan nilai saat ini dari komponen. |
| `:SetVisible(bool)` | Menampilkan (`true`) atau menyembunyikan (`false`) komponen. |
| `:SetEnabled(bool)` | Mengaktifkan/menonaktifkan interaksi (komponen akan terlihat redup jika `false`). |
| `:UpdateCallback(fn)` | Mengganti fungsi callback yang sudah ada dengan yang baru. |
| `:Destroy()` | Menghapus komponen dari UI secara permanen. |

---

### 📂 5. Section Methods

| Metode | Deskripsi |
|--------|-----------|
| `Section:Collapse()` | Menutup section secara programatis. |
| `Section:Expand()` | Membuka section secara programatis. |
| `Section:SetTitle("Judul Baru")` | Mengubah judul section. |
| `Section:Destroy()` | Menghapus seluruh section beserta semua komponen di dalamnya. |

---

## ⚙️ Kontrol Window & Fitur Bawaan

- **Drag Window**: Klik dan tahan *Titlebar* (bagian atas) untuk memindahkan window.
- **Resize Window**: Klik dan tarik ikon `+` di sudut kanan bawah window.
- **Minimize/Maximize**: 
  - Klik tombol `-` atau `+` di titlebar.
  - Tekan tombol **`M`** di keyboard (Keybind default, bisa diubah di Settings).
  - Klik tombol **`K`** mengambang di kiri bawah layar.
- **Settings Panel**: Klik tombol **`S`** kecil di bagian bawah sidebar untuk mengubah tombol *Minimize* (Keybind).
- **Search Tabs**: Ketik di kolom *Search tabs...* pada sidebar untuk memfilter tab.
- **Close Window**: Klik tombol `X` merah di title bar untuk menghancurkan seluruh GUI.

---

## 📝 Lisensi

Proyek ini dilisensikan di bawah **MIT License**. Silakan gunakan, modifikasi, dan distribusikan secara bebas dengan menyertakan atribusi yang sesuai.

---

## 🤝 Kontribusi & Dukungan

Jika Anda menemukan *bug*, memiliki ide fitur baru, atau ingin berkontribusi, jangan ragu untuk membuka **Issue** atau **Pull Request** di repositori GitHub ini. 

Dibuat dengan ❤️ dan ☕ oleh **liptz341** (Krein).
