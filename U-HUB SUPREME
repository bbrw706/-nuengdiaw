-- [[ U-HUB SUPREME | VERSION 2026 ]]
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
            local method = getnamecallmethod()
            if method == "FireServer" and (self.Name == "Admin_Event" or self.Name == "Check_Data") then
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
_G.AutoBuyFruit = false
_G.SelectFruit = "Dough-Dough"

-- [[ ฟังก์ชันเคลื่อนที่ (ความเร็วปลอดภัย) ]]
function To(targetCFrame)
    pcall(function()
        local distance = (Player.Character.HumanoidRootPart.Position - targetCFrame.p).Magnitude
        local speed = 250 -- ความเร็วที่ระบบไม่ตรวจจับ
        TS:Create(Player.Character.HumanoidRootPart, TweenInfo.new(distance/speed, Enum.EasingStyle.Linear), {CFrame = targetCFrame}):Play()
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
        if _G.AutoBuyFruit then
            RS.Remotes.CommF_:InvokeServer("BuyFruit", _G.SelectFruit)
            wait(10) -- หน่วงเวลาเพื่อความปลอดภัย
        end
    end
end)

spawn(function()
    while wait(1) do
        if _G.AutoStats_Melee then RS.Remotes.CommF_:InvokeServer("AddPoint", "Melee", 1) end
        if _G.AutoStats_Defense then RS.Remotes.CommF_:InvokeServer("AddPoint", "Defense", 1) end
    end
end)

-- [[ --- เมนูหลัก --- ]]
local MainTab = Window:NewTab("ฟาร์ม & สเตตัส")
local FarmSection = MainTab:NewSection("🔥 ระบบฟาร์ม")
FarmSection:NewToggle("เริ่มฟาร์มเลเวลอัตโนมัติ", "รับเควสและตีมอนสเตอร์", function(state) _G.AutoFarm = state end)
FarmSection:NewToggle("เปิดตีไว (Fast Attack)", "เพิ่มความเร็วในการโจมตี", function(state) _G.FastAttack = state end)

local StatSection = MainTab:NewSection("📊 อัปสเตตัส")
StatSection:NewToggle("อัปมานา (Melee)", "", function(state) _G.AutoStats_Melee = state end)
StatSection:NewToggle("อัปเลือด (Defense)", "", function(state) _G.AutoStats_Defense = state end)

-- [[ --- เมนูร้านค้า --- ]]
local ShopTab = Window:NewTab("ร้านค้า & ผลไม้")
ShopTab:NewSection("🍓 ซื้อผลปีศาจ")
ShopTab:NewDropDown("เลือกผลที่จะซื้อ", "ซื้อเมื่อมีในสต็อก", {"Dough-Dough", "Buddha-Buddha", "Leopard-Leopard", "Dragon-Dragon", "Kitsune-Kitsune"}, function(v) _G.SelectFruit = v end)
ShopTab:NewToggle("ออโต้ซื้อผลที่เลือก", "เปิดทิ้งไว้เพื่อรอผลเข้า", function(state) _G.AutoBuyFruit = state end)

-- [[ --- เมนูเผ่า (แยกโลก) --- ]]
if WorldID == 4442272160 then -- โลก 2
    local RaceTab = Window:NewTab("ทำเผ่า V2-V3")
    RaceTab:NewSection("🧬 ภารกิจเผ่า V2/V3")
    RaceTab:NewButton("รับเควสเผ่า V2", "คุยกับ Alchemist", function() RS.Remotes.CommF_:InvokeServer("Alchemist", "1") end)
    RaceTab:NewButton("รับเควสเผ่า V3", "คุยกับ Arowe", function() RS.Remotes.CommF_:InvokeServer("Arowe", "1") end)
    RaceTab:NewButton("วาร์ปหาดอกไม้ (V2)", "บินไปจุดเกิดดอกไม้", function() To(CFrame.new(608, 15, 1533)) end)

elseif WorldID == 7449925010 then -- โลก 3
    local V4Tab = Window:NewTab("ทำเผ่า V4")
    V4Tab:NewSection("🌕 ภารกิจเผ่า V4")
    V4Tab:NewButton("ออโต้จ้องพระจันทร์ (Look Moon)", "หันหน้าจอหาพระจันทร์", function()
        workspace.CurrentCamera.CFrame = CFrame.new(workspace.CurrentCamera.CFrame.p, Vector3.new(0, 5000, 0))
        RS.Remotes.CommF_:InvokeServer("ActivateRaceV3")
    end)
    V4Tab:NewButton("วาร์ปหาเฟือง (Blue Gear)", "วาร์ปไปเก็บเฟืองทันที", function()
        for _, v in pairs(workspace:GetChildren()) do
            if v.Name == "BlueGear" then To(v.CFrame) break end
        end
    end)
end

-- [[ --- เดินทาง --- ]]
local MiscTab = Window:NewTab("อื่นๆ")
MiscTab:NewSection("🚢 วาร์ปโลก")
MiscTab:NewButton("ไปโลก 1", "", function() RS.Remotes.CommF_:InvokeServer("TravelMain") end)
MiscTab:NewButton("ไปโลก 2", "", function() RS.Remotes.CommF_:InvokeServer("TravelDressrosa") end)
MiscTab:NewButton("ไปโลก 3", "", function() RS.Remotes.CommF_:InvokeServer("TravelZou") end)
MiscTab:NewSection("⚙️ ความปลอดภัย")
MiscTab:NewButton("เปิดระบบกันหลุด (Anti-AFK)", "", function()
    Player.Idled:Connect(function()
        game:GetService("VirtualInputManager"):SendKeyEvent(true, "W", false, game)
        wait(0.1)
        game:GetService("VirtualInputManager"):SendKeyEvent(false, "W", false, game)
    end)
end)
