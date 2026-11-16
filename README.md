
# 🌟 Krein GUI Library

[![Roblox](https://img.shields.io/badge/Platform-Roblox-000000?style=for-the-badge&logo=roblox)](https://www.roblox.com/)
[![Language](https://img.shields.io/badge/Language-Lua-000080?style=for-the-badge&logo=lua)](https://www.lua.org/)
[![License](https://img.shields.io/badge/License-MIT-green.svg?style=for-the-badge)](LICENSE)
[![Version](https://img.shields.io/badge/Version-1.1.0-blue?style=for-the-badge)](https://github.com/liptz341/KreinGuiLibrary)

**Krein GUI Library** adalah pustaka antarmuka (UI Library) premium untuk Roblox yang dirancang dengan fokus pada estetika modern, performa tinggi, dan kelengkapan fitur. Dibangun dari nol menggunakan Roblox Lua API murni, library ini menawarkan animasi *TweenService* yang sangat halus, efek *rainbow stroke*, sistem notifikasi canggih, dan berbagai komponen interaktif siap pakai.

Dilengkapi dengan **Multi-Game Loader** modern bernuansa RGB yang otomatis mendeteksi game dan memuat fitur spesifik — satu link untuk semua game.

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
- 🚀 **Multi-Game Loader**: Loader RGB modern dengan deteksi `PlaceId` otomatis dan fallback universal.

---

## 📂 Struktur Repository

```

KreinGuiLibrary/
├── guilibrary.lua           ← Core library (di-obfuscate)
├── loader.lua               ← Multi-game loader (link yang dibagikan)
├── README.md
├── LICENSE
└── Games/
├── GameA.lua            ← Script fitur untuk PlaceId A
├── GameB.lua            ← Script fitur untuk PlaceId B
└── ...

```

---

## 📦 Instalasi

### 🚀 Cara 1 — Multi-Game Loader (Recommended)

Satu link untuk semua game. Loader akan otomatis mendeteksi game dan menampilkan GUI launch bertema RGB sebelum memuat library.

```lua
loadstring(game:HttpGet("https://raw.githubusercontent.com/liptz341/KreinGuiLibrary/refs/heads/main/loader.lua"))()
```

Alur Loader:

1. Muncul card hitam dengan border RGB animasi bertuliskan "KreinLoad"
2. Loader mendeteksi game.PlaceId dan menampilkan nama game
3. Klik "Load Now!" → library dimuat → intro main → window muncul
4. Jika game tidak didukung, tombol berubah jadi "Open Library Anyway" (library tetap bisa dipakai kosong)

🧩 Cara 2 — Manual Library (Standalone)

Untuk development atau custom script, load library secara langsung:

```lua
loadstring(game:HttpGet("https://raw.githubusercontent.com/liptz341/KreinGuiLibrary/refs/heads/main/guilibrary.lua"))()
```

⚠️ Catatan: Nama file harus .lua (bukan .lua.txt). Pastikan URL raw mengarah ke file yang benar.

---

🚀 Quick Start (Boilerplate)

Template dasar untuk membuat script standalone:

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

🌐 Multi-Game Loader — Panduan Lengkap

🎯 Cara Kerja

Loader membaca game.PlaceId lalu mencocokkan dengan registry yang kamu definisikan. Jika cocok, loader akan:

1. Menampilkan card RGB bertuliskan nama game
2. Memuat guilibrary.lua
3. Membuat Window lalu mengeksposnya ke getgenv().KreinWindow
4. Memuat file script game dari folder Games/
5. Menjalankan script game — yang tinggal memanggil getgenv().KreinWindow

🗂️ Menambah Game Baru

Step 1 — Edit loader.lua, tambahkan PlaceId ke registry:

```lua
local GAMES = {
    [87039211657390] = { Name = "Steal a Brainrot", Path = "Games/GameA.lua" },
    [1234567890]     = { Name = "Blox Fruits",      Path = "Games/GameB.lua" },
    [9876543210]     = { Name = "My New Game",      Path = "Games/MyNewGame.lua" }, -- ← tambahkan
}
```

Step 2 — Buat file Games/MyNewGame.lua:

```lua
local KreinHub = getgenv().KreinLibrary
local Window   = getgenv().KreinWindow

if not Window then
    warn("[Game] Window tidak tersedia. Loader gagal?")
    return
end

-- Mulai sama persis dengan pola README
local MainTab = Window:CreateTab("Main", "🏠")
local Sec     = MainTab:CreateSection("Fitur Utama", false)

Sec:CreateLabel("Fitur untuk game ini...")

Sec:CreateToggle("Auto Farm", false, function(state)
    print("Auto Farm:", state)
end)

Sec:CreateButton("Teleport Spawn", function()
    -- logic game
end)

KreinHub:Notify("Loaded", "Fitur game aktif!", 2, "success")
```

Step 3 — Commit & push. User tinggal jalankan loadstring loader, otomatis dapat fitur baru.

🔑 Variabel Global Loader

Setelah loader selesai, variabel berikut tersedia via getgenv():

Variabel Tipe Deskripsi
KreinWindow Object Window utama yang dibuat oleh loader
KreinLibrary Table Reference ke KreinHub library

Gunakan ini di script game untuk mengakses instance yang sama tanpa harus buat Window baru.

⚠️ Game Tidak Didukung

Jika game.PlaceId tidak ada di registry:

· Card tetap muncul dengan subtitle "⚠ Game Not Supported" + PlaceId
· Tombol berubah menjadi "Open Library Anyway"
· Klik tombol → library tetap dimuat dengan window kosong (tanpa fitur game)
· User bisa navigasi manual, tapi tidak ada tab game

Kenapa tidak skip total? Agar branding konsisten dan user bisa lapor PlaceId yang belum didukung ke developer.

---

📚 Dokumentasi API Lengkap

🪟 1. Window & Tab Management

KreinHub:CreateWindow(config)

Membuat window utama. Mengembalikan objek Window.

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

Window:CreateTab(name, icon)

Membuat tab baru. Mengembalikan objek Tab.

```lua
local Tab = Window:CreateTab("Home", "🏠") -- icon bersifat opsional (bisa emoji/teks)
```

Tab:CreateSection(title, collapsed)

Membuat section (kolom) di dalam tab. Mengembalikan objek Section.

```lua
-- collapsed = false → section langsung terbuka (RECOMMENDED untuk UX)
local Section = Tab:CreateSection("Pengaturan", false)

-- collapsed = true atau tanpa argumen → section tertutup (perlu diklik untuk buka)
local Section = Tab:CreateSection("Advanced", true)
```

---

🧩 2. UI Components (Metode Section)

Semua komponen di bawah ini dipanggil dari objek Section. Hampir semua komponen mengembalikan Object yang memiliki metode kontrol (lihat bagian Object Methods di bawah).

🏷️ Label

Menampilkan teks statis.

```lua
local Label = Section:CreateLabel("Ini adalah teks informasi.")
Label:SetText("Teks baru!") -- Mengubah teks
```

🔘 Button

Tombol aksi standar.

```lua
local Btn = Section:CreateButton("Klik Saya", function()
    print("Tombol diklik!")
end)
Btn:SetActionText("EXECUTE") -- Mengubah teks tombol (default: "CLICK")
```

⚠️ Danger Button

Tombol dengan konfirmasi keamanan (harus klik 2x: "CLICK" -> "SURE?").

```lua
Section:CreateDangerButton("Hapus Data", function()
    print("Data dihapus!")
end)
```

🔁 Toggle

Saklar ON/OFF.

```lua
local Toggle = Section:CreateToggle("Fitur Terbang", false, function(state)
    print("State:", state) -- boolean
end)
Toggle:SetValue(true) -- Mengubah state via script
```

🎚️ Slider

Penggeser nilai (mendukung integer dan float/desimal).

```lua
local Slider = Section:CreateSlider("Kecepatan", 0, 100, 50, function(value)
    print("Value:", value)
end, false) -- Parameter terakhir: false = integer, true = float (desimal)

Slider:SetValue(75)
```

📂 Dropdown

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

⌨️ Keybind

Pengikat tombol keyboard.

```lua
local Keybind = Section:CreateKeybind("Tombol Kill", Enum.KeyCode.F, function(key)
    print("Tombol ditekan:", key.Name)
end)
Keybind:SetValue(Enum.KeyCode.G) -- Mengubah keybind via script
```

🎨 ColorPicker

Pemilih warna lengkap dengan panel HSV dan input Hex.

```lua
local Color = Section:CreateColorPicker("Warna ESP", Color3.fromRGB(255, 0, 0), function(color)
    print("RGB:", color.R, color.G, color.B)
end)
Color:SetValue(Color3.fromRGB(0, 255, 0))
```

📝 TextBox

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

📊 Progress Bar

Bar progres (tidak interaktif, hanya visual).

```lua
local Progress = Section:CreateProgressBar("Loading...", 0, 100)
Progress:SetValue(50) -- Mengisi 50% dengan animasi
```

🔘 Radio Group

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

📏 Separator

Garis pemisah horizontal.

```lua
Section:CreateSeparator()
```

---

🔔 3. Sistem Notifikasi

KreinHub:Notify(title, message, duration, nType)

Menampilkan notifikasi slide-in di pojok kanan atas.

```lua
KreinHub:Notify("Sukses", "Berhasil teleport!", 4, "success")
```

Tipe Notifikasi (nType):

· "info" (Biru)
· "success" (Hijau)
· "warning" (Kuning)
· "error" (Merah)

💡 Tip: Ada cooldown 0.3 detik antar-notif untuk mencegah spam. Jika kamu mengirim 2 notif beruntun, yang kedua akan dibuang. Beri task.wait(0.35) di antaranya.

---

🛠️ 4. Object Methods (Metode Kontrol)

Hampir semua komponen di atas mengembalikan sebuah Object. Anda dapat menggunakan metode berikut untuk mengontrol komponen secara programatis:

Metode Deskripsi
:SetValue(val) Mengubah nilai komponen (Toggle, Slider, Dropdown, Keybind, ColorPicker, TextBox, ProgressBar, RadioGroup).
:GetValue() Mengembalikan nilai saat ini dari komponen.
:SetVisible(bool) Menampilkan (true) atau menyembunyikan (false) komponen.
:SetEnabled(bool) Mengaktifkan/menonaktifkan interaksi (komponen akan terlihat redup jika false).
:UpdateCallback(fn) Mengganti fungsi callback yang sudah ada dengan yang baru.
:Destroy() Menghapus komponen dari UI secara permanen.

---

📂 5. Section Methods

Metode Deskripsi
Section:Collapse() Menutup section secara programatis.
Section:Expand() Membuka section secara programatis.
Section:SetTitle("Judul Baru") Mengubah judul section.
Section:Destroy() Menghapus seluruh section beserta semua komponen di dalamnya.

---

⚙️ Kontrol Window & Fitur Bawaan

· Drag Window: Klik dan tahan Titlebar (bagian atas) untuk memindahkan window.
· Resize Window: Klik dan tarik ikon + di sudut kanan bawah window.
· Minimize/Maximize:
  · Klik tombol - atau + di titlebar.
  · Tekan tombol M di keyboard (Keybind default, bisa diubah di Settings).
  · Klik tombol K mengambang di kiri bawah layar.
· Settings Panel: Klik tombol S kecil di bagian bawah sidebar untuk mengubah tombol Minimize (Keybind).
· Search Tabs: Ketik di kolom Search tabs... pada sidebar untuk memfilter tab.
· Close Window: Klik tombol X merah di title bar untuk menghancurkan seluruh GUI.

---

❓ FAQ

Q: Library tidak muncul setelah loadstring dijalankan.
A: Cek output executor. Kemungkinan: (1) URL 404 karena nama file salah, (2) obfuscator merusak return, (3) executor tidak support loadstring. Test dengan print(type(KreinHub)) — harus "table".

Q: Notifikasi pertama muncul, yang kedua hilang.
A: Cooldown 0.3 detik. Beri jeda task.wait(0.35) antar notif, atau naikkan NOTIF_COOL di guilibrary.lua (butuh re-obfuscate).

Q: Loader stuck di "Loading..."?
A: Cek koneksi, atau buka DevTools executor untuk lihat error. Sering karena file Games/*.lua belum diupload.

Q: Bisa dipakai di game tertentu?
A: Library universal (bisa dijalankan di mana saja), tapi fitur game hanya aktif jika PlaceId terdaftar di registry loader.

Q: Bagaimana mengubah tampilan loader RGB?
A: Edit bagian StrokeOuter, StrokeGlow, dan TitleGrad di loader.lua. Warna border mengikuti Color3.fromHSV(hue, 0.85, 1).

Q: Executor apa yang direkomendasikan?
A: Semua executor modern yang support loadstring, game:HttpGet, getgenv, dan gethui (Delta, Codex, Wave, Krnl, dst).

---

📝 Lisensi

Proyek ini dilisensikan di bawah MIT License. Silakan gunakan, modifikasi, dan distribusikan secara bebas dengan menyertakan atribusi yang sesuai.

---

🤝 Kontribusi & Dukungan

Jika Anda menemukan bug, memiliki ide fitur baru, atau ingin berkontribusi, jangan ragu untuk membuka Issue atau Pull Request di repositori GitHub ini.

Menambah game baru? Fork repo, tambahkan entry di registry loader.lua + file Games/*.lua, lalu buka Pull Request. Pastikan screenshot hasil test disertakan.

Dibuat dengan ❤️ dan ☕ oleh liptz341 (Krein).

```

---

## 📋 Ringkasan Perubahan dari v1.0.0 → v1.1.0

| Bagian | Status | Keterangan |
|--------|--------|------------|
| Badge version | ✏️ Update | `1.0.0` → `1.1.0` |
| Intro paragraph | ➕ Tambah | Kalimat tentang Multi-Game Loader |
| Fitur Unggulan | ➕ Tambah | Bullet "Multi-Game Loader" |
| **Struktur Repository** | 🆕 Section | Diagram folder repo |
| **Instalasi** | ♻️ Restrukturisasi | Dipecah jadi 2 cara (loader vs manual) |
| **Multi-Game Loader Guide** | 🆕 Section | Panduan lengkap + step tambah game |
| Variabel Global | 🆕 Sub-section | Tabel `KreinWindow` & `KreinLibrary` |
| Game tidak didukung | 🆕 Sub-section | Penjelasan fallback behavior |
| `CreateSection` | ✏️ Perjelas | Contoh eksplisit `false` vs `true` |
| Notify | ✏️ Perjelas | Tambah tip cooldown 0.3s |
| **FAQ** | 🆕 Section | 6 pertanyaan umum |
| Kontribusi | ✏️ Tambah | Alur PR untuk tambah game baru |

---

## ✅ Checklist Sebelum Push README

- [ ] Hapus semua komentar HTML `<!-- -->` (kalau kamu pakai versi dengan penanda)
- [ ] Pastikan nama file di URL README = nama file di repo (`guilibrary.lua`, **bukan** `.lua.txt`)
- [ ] Pastikan branch `refs/heads/main` sesuai branch aktual (bisa `master` di repo lama)
- [ ] Test semua URL di README dengan `curl -I` → harus `HTTP/2 200`
- [ ] Update badge version di GitHub Release / tag

Kalau kamu mau aku bantu bikin **versi bahasa Inggris** juga (untuk audiens internasional), atau **GitHub Actions workflow** untuk auto-deploy ke jsDelivr, tinggal bilang bro. 🚀
