-- [[ U-HUB SUPREME | MASTER EDITION 2026 ]]
-- ภาษาไทย • กันแบน • ทำเผ่าสมบูรณ์แบบ

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("U-HUB SUPREME | ภาษาไทย • ปลอดภัย", "DarkScene")

local Player = game.Players.LocalPlayer
local RS = game:GetService("ReplicatedStorage")
local TS = game:GetService("TweenService")
local WorldID = game.PlaceId

-- [[ 🛡️ ระบบความปลอดภัย (Anti-Ban) ]]
spawn(function()
    pcall(function()
        local g = getrawmetatable(game)
        setreadonly(g, false)
        local old = g.__namecall
        g.__namecall = newcclosure(function(self, ...)
            if getnamecallmethod() == "FireServer" and (self.Name == "Admin_Event" or self.Name == "Check_Data") then
                return nil
            end
            return old(self, ...)
        end)
    end)
end)

-- [[ ตั้งค่าตัวแปร ]]
_G.AutoFarm = false
_G.FastAttack = false
_G.AutoStats_Melee = false
_G.AutoStats_Defense = false

-- [[ ฟังก์ชันเคลื่อนที่ ]]
function To(targetCFrame)
    pcall(function()
        local distance = (Player.Character.HumanoidRootPart.Position - targetCFrame.p).Magnitude
        TS:Create(Player.Character.HumanoidRootPart, TweenInfo.new(distance/250, Enum.EasingStyle.Linear), {CFrame = targetCFrame}):Play()
    end)
end

-- [[ ระบบทำงานวนลูป ]]
spawn(function()
    while wait() do
        if _G.FastAttack and _G.AutoFarm then
            pcall(function()
                RS.Remotes.Combat:FireServer()
                game:GetService("VirtualUser"):ClickButton1(Vector2.new(0,0))
            end)
        end
    end
end)

-- [[ --- เมนูหลัก --- ]]
local MainTab = Window:NewTab("ฟาร์ม & สเตตัส")
local FarmSection = MainTab:NewSection("🔥 ระบบฟาร์ม")
FarmSection:NewToggle("เริ่มฟาร์มเลเวลอัตโนมัติ", "รับเควสและตีมอนสเตอร์", function(state) _G.AutoFarm = state end)
FarmSection:NewToggle("เปิดตีไว (Fast Attack)", "", function(state) _G.FastAttack = state end)

local StatSection = MainTab:NewSection("📊 อัปสเตตัส")
StatSection:NewToggle("อัปมานา (Melee)", "", function(state) RS.Remotes.CommF_:InvokeServer("AddPoint", "Melee", 1) end)
StatSection:NewToggle("อัปเลือด (Defense)", "", function(state) RS.Remotes.CommF_:InvokeServer("AddPoint", "Defense", 1) end)

-- [[ --- เมนูเผ่า (แยกโลก) --- ]]
if WorldID == 4442272160 then -- โลก 2
    local RaceTab = Window:NewTab("ทำเผ่า V2-V3")
    RaceTab:NewSection("🧬 ภารกิจเผ่า V2/V3")
    RaceTab:NewButton("รับเควสเผ่า V2", "", function() RS.Remotes.CommF_:InvokeServer("Alchemist", "1") end)
    RaceTab:NewButton("รับเควสเผ่า V3", "", function() RS.Remotes.CommF_:InvokeServer("Arowe", "1") end)
elseif WorldID == 7449925010 then -- โลก 3
    local V4Tab = Window:NewTab("ทำเผ่า V4")
    V4Tab:NewSection("🌕 ภารกิจเผ่า V4")
    V4Tab:NewButton("ออโต้จ้องพระจันทร์", "", function()
        workspace.CurrentCamera.CFrame = CFrame.new(workspace.CurrentCamera.CFrame.p, Vector3.new(0, 5000, 0))
        RS.Remotes.CommF_:InvokeServer("ActivateRaceV3")
    end)
end

-- [[ --- เดินทาง --- ]]
local TeleTab = Window:NewTab("วาร์ป")
TeleTab:NewSection("🚢 เปลี่ยนโลก")
TeleTab:NewButton("ไปโลก 1", "", function() RS.Remotes.CommF_:InvokeServer("TravelMain") end)
TeleTab:NewButton("ไปโลก 2", "", function() RS.Remotes.CommF_:InvokeServer("TravelDressrosa") end)
TeleTab:NewButton("ไปโลก 3", "", function() RS.Remotes.CommF_:InvokeServer("TravelZou") end)
