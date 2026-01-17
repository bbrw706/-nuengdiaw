-- [[ U-HUB SUPREME | VERSION 2026 ]]
-- 🇹🇭 ภาษาไทย | 🛡️ กันแบน | ⚡ ฟาร์มไว

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("U-HUB SUPREME 💎 (v2026)", "DarkScene")

local Player = game.Players.LocalPlayer
local RS = game:GetService("ReplicatedStorage")
local TS = game:GetService("TweenService")
local WorldID = game.PlaceId

-- [[ 🛡️ ระบบป้องกันการตรวจจับ (Anti-Cheat Bypass) ]]
spawn(function()
    pcall(function()
        local g = getrawmetatable(game)
        setreadonly(g, false)
        local old = g.__namecall
        g.__namecall = newcclosure(function(self, ...)
            local method = getnamecallmethod()
            if method == "FireServer" and (self.Name == "Admin_Event" or self.Name == "Check_Data") then
                return nil
            end
            return old(self, ...)
        end)
    end)
end)

-- [[ ⚙️ ตั้งค่าเริ่มต้น ]]
_G.AutoFarm = false
_G.FastAttack = false
_G.AutoStats_Melee = false
_G.AutoStats_Defense = false

-- [[ 🚀 ระบบทำงานหลัก (Loops) ]]
spawn(function()
    while task.wait() do
        if _G.AutoFarm and _G.FastAttack then
            pcall(function()
                -- ระบบตีไว
                RS.Remotes.Combat:FireServer()
                game:GetService("VirtualUser"):ClickButton1(Vector2.new(0,0))
            end)
        end
    end
end)

-- [[ 🏠 หน้าหลัก - ฟาร์มเลเวล ]]
local MainTab = Window:NewTab("🏠 หน้าหลัก")
local FarmSection = MainTab:NewSection("⚔️ ระบบฟาร์มเลเวล")

FarmSection:NewToggle("เริ่มฟาร์มเลเวลอัตโนมัติ 🍖", "ตีมอนสเตอร์และรับเควส", function(state)
    _G.AutoFarm = state
end)

FarmSection:NewToggle("เปิดตีไว (Fast Attack) ⚡", "เพิ่มความเร็วในการฟัน", function(state)
    _G.FastAttack = state
end)

-- [[ 📊 หน้าอัปสเตตัส ]]
local StatTab = Window:NewTab("📊 อัปสเตตัส")
local StatSection = StatTab:NewSection("เพิ่มแต้มอัตโนมัติ")

StatSection:NewToggle("อัปสายหมัด (Melee)", "อัปแต้มมานา", function(state)
    _G.AutoStats_Melee = state
    spawn(function()
        while _G.AutoStats_Melee do
            RS.Remotes.CommF_:InvokeServer("AddPoint", "Melee", 1)
            task.wait(0.5)
        end
    end)
end)

StatSection:NewToggle("อัปสายเลือด (Defense)", "เพิ่มเลือดให้ถึกขึ้น", function(state)
    _G.AutoStats_Defense = state
    spawn(function()
        while _G.AutoStats_Defense do
            RS.Remotes.CommF_:InvokeServer("AddPoint", "Defense", 1)
            task.wait(0.5)
        end
    end)
end)

-- [[ 🧬 หน้าทำเผ่า (V2 - V4) ]]
local RaceTab = Window:NewTab("🧬 ทำเผ่า")
if WorldID == 4442272160 then -- โลก 2
    local V2Section = RaceTab:NewSection("🧬 ภารกิจเผ่า V2-V3")
    V2Section:NewButton("รับเควสเผ่า V2 (Alchemist)", "คุยกับนักปรุงยา", function()
        RS.Remotes.CommF_:InvokeServer("Alchemist", "1")
    end)
    V2Section:NewButton("รับเควสเผ่า V3 (Arowe)", "ทำภารกิจตามเผ่า", function()
        RS.Remotes.CommF_:InvokeServer("Arowe", "1")
    end)
elseif WorldID == 7449925010 then -- โลก 3
    local V4Section = RaceTab:NewSection("🌕 ภารกิจเผ่า V4")
    V4Section:NewButton("ออโต้จ้องพระจันทร์ 🌙", "หันไปทางดวงจันทร์", function()
        workspace.CurrentCamera.CFrame = CFrame.new(workspace.CurrentCamera.CFrame.p, Vector3.new(0, 5000, 0))
        RS.Remotes.CommF_:InvokeServer("ActivateRaceV3")
    end)
    V4Section:NewButton("เทเลพอร์ตหาเฟือง ⚙️", "บินไปยังจุดเก็บเฟือง", function()
        for _, v in pairs(workspace:GetChildren()) do
            if v.Name == "BlueGear" then
                Player.Character.HumanoidRootPart.CFrame = v.CFrame
            end
        end
    end)
end

-- [[ ⚙️ ตั้งค่าเพิ่มเติม ]]
local MiscTab = Window:NewTab("⚙️ อื่นๆ")
local MiscSection = MiscTab:NewSection("🚢 เดินทาง & ระบบ")

MiscSection:NewButton("ไปโลก 1 🏝️", "", function() RS.Remotes.CommF_:InvokeServer("TravelMain") end)
MiscSection:NewButton("ไปโลก 2 🌋", "", function() RS.Remotes.CommF_:InvokeServer("TravelDressrosa") end)
MiscSection:NewButton("ไปโลก 3 ☁️", "", function() RS.Remotes.CommF_:InvokeServer("TravelZou") end)

MiscSection:NewButton("เปิดระบบกันหลุด (Anti-AFK) 🚫", "ป้องกันการเด้งออกจากเกม", function()
    Player.Idled:Connect(function()
        game:GetService("VirtualInputManager"):SendKeyEvent(true, "W", false, game)
        task.wait(0.1)
        game:GetService("VirtualInputManager"):SendKeyEvent(false, "W", false, game)
    end)
    print("Anti-AFK Enabled!")
end)
