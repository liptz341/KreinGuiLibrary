# 🚀 KreinHub UI Library

Welcome to the **KreinHub UI Library** (KreinGuiLibrary), a sleek, modern, and highly responsive Graphical User Interface (GUI) framework designed for Roblox script developers. It features smooth animations, beautiful color schemes, and a wide array of interactive UI components.

---

## 📥 Installation & Loadstring

To use KreinHub in your script, simply load the library using the following `loadstring`:

```lua
local KreinHub = loadstring(game:HttpGet("https://raw.githubusercontent.com/liptz341/KreinGuiLibrary/refs/heads/main/guilibrary.lua"))()
```

---

## 🛠️ Getting Started

### 1. Creating a Window
Initialize the library by creating a main window. You can customize the title, subtitle, size, and position.

```lua
local Window = KreinHub:CreateWindow({
    Title = "Krein Hub",
    Subtitle = "Premium UI Library",
    -- Optional configurations:
    -- Size = UDim2.new(0, 680, 0, 460),
    -- Position = UDim2.new(0.5, -340, 0.5, -230),
})
```

### 2. Notifications System
KreinHub features a sleek built-in notification system. You can send notifications from anywhere in your script.

```lua
-- Parameters: Title, Message, Duration, NotificationType ("info", "success", "warning", "error")
KreinHub:Notify("Welcome!", "KreinHub loaded successfully.", 5, "success")
KreinHub:Notify("Warning", "Watch out for this feature.", 3, "warning")
KreinHub:Notify("Error", "Something went wrong.", 3, "error")
```

### 3. Creating Tabs
Tabs act as the main categories for your UI and are displayed on the left sidebar.

```lua
-- Parameters: TabName, Icon (Optional string)
local MainTab = Window:CreateTab("Main", "🏠")
local SettingsTab = Window:CreateTab("Settings", "⚙️")
```

### 4. Creating Sections
Sections group your UI elements together neatly inside a tab. They can be set to be collapsible.

```lua
-- Parameters: SectionName, CollapsedByDefault (boolean)
local PlayerSection = MainTab:CreateSection("Player Modifiers", false)
local MiscSection = MainTab:CreateSection("Miscellaneous", true)
```

---

## 🧩 UI Components

Inside your sections, you can populate the UI with various interactive elements.

### 📝 Label
Displays plain descriptive text.

```lua
local MyLabel = PlayerSection:CreateLabel("This is a descriptive label.")

-- Update the label later
MyLabel:SetText("Text updated!")
```

### 🔘 Button
A standard clickable button that executes a callback function.

```lua
PlayerSection:CreateButton("Print Hello", function()
    print("Hello from KreinHub!")
end)
```

### ⚠️ Danger Button
A red button that requires the user to click twice to confirm their action (displays "SURE?"). Ideal for destructive actions.

```lua
PlayerSection:CreateDangerButton("Reset Character", function()
    game.Players.LocalPlayer.Character:BreakJoints()
end)
```

### 🎚️ Toggle
A clean, animated On/Off switch.

```lua
-- Parameters: Text, DefaultState, Callback
local AutoFarm = PlayerSection:CreateToggle("Auto Farm", false, function(state)
    print("Auto Farm is now: ", state)
end)

-- Manually update value
AutoFarm:SetValue(true)
```

### 📊 Slider
A slider for selecting numeric values. Supports whole numbers and floats.

```lua
-- Parameters: Text, MinValue, MaxValue, DefaultValue, Callback, AllowFloat(boolean)
local SpeedSlider = PlayerSection:CreateSlider("WalkSpeed", 16, 100, 16, function(value)
    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = value
end, false)
```

### 📋 Dropdown
A dropdown menu for selecting one or multiple options from a list.

**Single Selection:**
```lua
PlayerSection:CreateDropdown({
    Text = "Select Weapon",
    Options = {"Sword", "Bow", "Magic"},
    MultiSelect = false,
    Callback = function(selected)
        print("Selected weapon: ", selected)
    end
})
```

**Multiple Selection:**
```lua
PlayerSection:CreateDropdown({
    Text = "Target Parts",
    Options = {"Head", "Torso", "Legs", "Arms"},
    MultiSelect = true,
    Callback = function(stateTable, activeList)
        -- stateTable: {["Head"] = true, ["Torso"] = false}
        -- activeList: {"Head"}
        print("You selected " .. #activeList .. " parts.")
    end
})
```

### ⌨️ Keybind
Allows users to set custom hotkeys to trigger functions.

```lua
-- Parameters: Text, DefaultKey, Callback
PlayerSection:CreateKeybind("Toggle UI", Enum.KeyCode.RightShift, function(key)
    print("New keybind set to: ", key.Name)
end)
```

### 🎨 Color Picker
An interactive gradient color picker for selecting RGB colors.

```lua
-- Parameters: Text, DefaultColor, Callback
PlayerSection:CreateColorPicker("ESP Color", Color3.fromRGB(255, 0, 0), function(color)
    print("Color changed: ", color)
end)
```

---

## ⚙️ Built-In Window Features

*   **Minimizing (Toggle UI):** By default, users can press **`M`** on their keyboard to minimize the entire UI into a small, elegant draggable button. 
*   **Customizing the Minimize Hotkey:** Users can click the small "S" (Settings) button in the bottom-left corner of the sidebar to rebind the minimize hotkey to whatever they prefer.
*   **Search Bar:** The sidebar includes a built-in search bar to quickly filter through created tabs.
*   **Window Resizing:** The main window can be dynamically resized by clicking and dragging the resize handle (`+`) at the bottom-right corner.
*   **Smooth Animations:** Elements utilize Roblox's `TweenService` for satisfying visual feedback on hovers, clicks, and window transitions.

---
*Developed with KreinHub*
