-- ============================================
-- THE PALARRAX v2.0 - PARTE 1/2
-- Interface Personalizada + Funções
-- ============================================

if _G.PALARRAX_LOADED then return end
_G.PALARRAX_LOADED = true

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Lighting = game:GetService("Lighting")
local Workspace = game:GetService("Workspace")
local UIS = game:GetService("UserInputService")
local LP = Players.LocalPlayer

_G.PLX = _G.PLX or {}
local PLX = _G.PLX

PLX.CFG = {
    ESP = false,
    Aimbot = false, AimbotFOV = 100, AimbotSmooth = 0.15,
    FPSBoost = false,
    Skybox = "Nenhum",
    Noclip = false, Fly = false, FlySpeed = 50,
    SpeedEnabled = false, SpeedValue = 50,
    InfiniteStamina = false,
    AntiTaze = false,
    HitboxEnabled = false, HitboxSize = 8,
}
local CFG = PLX.CFG

-- ============================================
-- UI PERSONALIZADA
-- ============================================
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "PALARRAX_UI"
ScreenGui.ResetOnSpawn = false
ScreenGui.IgnoreGuiInset = true
ScreenGui.DisplayOrder = 10
ScreenGui.Parent = LP:WaitForChild("PlayerGui")

-- Fundo personalizado (troca o ID pelo seu)
local bgImage = Instance.new("ImageLabel")
bgImage.Size = UDim2.new(1, 0, 1, 0)
bgImage.BackgroundTransparency = 1
bgImage.Image = "rbxassetid://7530797014"  -- ⚠️ Troca pelo seu ID
bgImage.ImageTransparency = 0.85
bgImage.ScaleType = Enum.ScaleType.Crop
bgImage.ZIndex = 0
bgImage.Parent = ScreenGui

-- Botão flutuante (abrir/fechar)
local toggleBtn = Instance.new("ImageButton")
toggleBtn.Size = UDim2.new(0, 60, 0, 60)
toggleBtn.Position = UDim2.new(0, 20, 0.4, 0)
toggleBtn.BackgroundColor3 = Color3.fromRGB(180, 30, 30)
toggleBtn.BorderSizePixel = 0
toggleBtn.Image = "rbxassetid://4483362458"  -- ⚠️ Troca pelo seu ID
toggleBtn.AutoButtonColor = false
toggleBtn.ZIndex = 100
toggleBtn.Parent = ScreenGui

local tbc = Instance.new("UICorner")
tbc.CornerRadius = UDim.new(1, 0)
tbc.Parent = toggleBtn

local tbs = Instance.new("UIStroke")
tbs.Color = Color3.fromRGB(255, 100, 100)
tbs.Thickness = 2
tbs.Parent = toggleBtn

-- Painel principal
local main = Instance.new("Frame")
main.Size = UDim2.new(0, 270, 0, 440)
main.Position = UDim2.new(0.5, -135, 0.5, -220)
main.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
main.BackgroundTransparency = 0.05
main.BorderSizePixel = 0
main.Active = true
main.Draggable = true
main.Visible = false
main.ZIndex = 50
main.Parent = ScreenGui

local mc = Instance.new("UICorner")
mc.CornerRadius = UDim.new(0, 12)
mc.Parent = main

local ms = Instance.new("UIStroke")
ms.Color = Color3.fromRGB(255, 60, 60)
ms.Thickness = 2
ms.Transparency = 0.3
ms.Parent = main

-- Header (arrastar)
local header = Instance.new("Frame")
header.Size = UDim2.new(1, 0, 0, 40)
header.BackgroundColor3 = Color3.fromRGB(180, 30, 30)
header.BorderSizePixel = 0
header.Parent = main

local hc = Instance.new("UICorner")
hc.CornerRadius = UDim.new(0, 12)
hc.Parent = header

local headerCover = Instance.new("Frame")
headerCover.Size = UDim2.new(1, 0, 0.5, 0)
headerCover.Position = UDim2.new(0, 0, 0.5, 0)
headerCover.BackgroundColor3 = Color3.fromRGB(180, 30, 30)
headerCover.BorderSizePixel = 0
headerCover.Parent = header

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -60, 1, 0)
title.Position = UDim2.new(0, 12, 0, 0)
title.BackgroundTransparency = 1
title.Text = "🔥 THE PALARRAX"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Font = Enum.Font.GothamBold
title.TextSize = 14
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = header

local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 26, 0, 26)
closeBtn.Position = UDim2.new(1, -32, 0, 7)
closeBtn.BackgroundColor3 = Color3.fromRGB(50, 25, 25)
closeBtn.Text = "✕"
closeBtn.TextColor3 = Color3.fromRGB(255, 150, 150)
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextSize = 14
closeBtn.BorderSizePixel = 0
closeBtn.AutoButtonColor = false
closeBtn.Parent = header

local cbc = Instance.new("UICorner")
cbc.CornerRadius = UDim.new(0, 6)
cbc.Parent = closeBtn

-- Container (scroll)
local container = Instance.new("ScrollingFrame")
container.Size = UDim2.new(1, -16, 1, -52)
container.Position = UDim2.new(0, 8, 0, 46)
container.BackgroundTransparency = 1
container.BorderSizePixel = 0
container.ScrollBarThickness = 3
container.ScrollBarImageColor3 = Color3.fromRGB(180, 30, 30)
container.CanvasSize = UDim2.new(0, 0, 0, 0)
container.AutomaticCanvasSize = Enum.AutomaticSize.Y
container.Parent = main

local listLayout = Instance.new("UIListLayout")
listLayout.Padding = UDim.new(0, 6)
listLayout.SortOrder = Enum.SortOrder.LayoutOrder
listLayout.Parent = container

-- Função de notificação
local notifGui = Instance.new("ScreenGui")
notifGui.Name = "PALARRAX_Notif"
notifGui.ResetOnSpawn = false
notifGui.IgnoreGuiInset = true
notifGui.DisplayOrder = 20
notifGui.Parent = LP:WaitForChild("PlayerGui")

local function notify(text)
    local notif = Instance.new("TextLabel")
    notif.Size = UDim2.new(0, 200, 0, 34)
    notif.Position = UDim2.new(0.5, -100, 0, -40)
    notif.BackgroundColor3 = Color3.fromRGB(180, 30, 30)
    notif.Text = text
    notif.TextColor3 = Color3.fromRGB(255, 255, 255)
    notif.Font = Enum.Font.GothamBold
    notif.TextSize = 12
    notif.BorderSizePixel = 0
    notif.Parent = notifGui
    
    local nc = Instance.new("UICorner")
    nc.CornerRadius = UDim.new(0, 6)
    nc.Parent = notif
    
    notif:TweenPosition(UDim2.new(0.5, -100, 0, 40), "Out", "Quad", 0.3)
    task.wait(2)
    notif:TweenPosition(UDim2.new(0.5, -100, 0, -40), "Out", "Quad", 0.3)
    task.wait(0.3)
    notif:Destroy()
end

-- Botão customizado
local function makeBtn(text, order, color, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, 0, 0, 34)
    btn.BackgroundColor3 = color or Color3.fromRGB(30, 30, 40)
    btn.BackgroundTransparency = 0.15
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(230, 230, 240)
    btn.Font = Enum.Font.GothamMedium
    btn.TextSize = 12
    btn.BorderSizePixel = 0
    btn.LayoutOrder = order
    btn.AutoButtonColor = false
    btn.Parent = container

    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, 8)
    c.Parent = btn

    local s = Instance.new("UIStroke")
    s.Color = Color3.fromRGB(60, 60, 70)
    s.Thickness = 1
    s.Transparency = 0.5
    s.Parent = btn

    btn.MouseButton1Down:Connect(function() btn.BackgroundTransparency = 0 end)
    btn.MouseButton1Up:Connect(function() btn.BackgroundTransparency = 0.15 end)
    btn.MouseLeave:Connect(function() btn.BackgroundTransparency = 0.15 end)
    btn.MouseButton1Click:Connect(callback)
    return btn
end

-- Abrir/fechar
local menuOpen = false
toggleBtn.MouseButton1Click:Connect(function()
    menuOpen = not menuOpen
    main.Visible = menuOpen
end)

closeBtn.MouseButton1Click:Connect(function()
    menuOpen = false
    main.Visible = false
end)

-- ============================================
-- FUNÇÕES
-- ============================================

-- FPS BOOST
local function applyFPSBoost(on)
    CFG.FPSBoost = on
    if on then
        Lighting.GlobalShadows = false
        for _, v in ipairs(Lighting:GetChildren()) do
            pcall(function()
                if v:IsA("PostEffect") or v:IsA("Atmosphere") then v.Enabled = false end
            end)
        end
        for _, v in ipairs(Workspace:GetDescendants()) do
            pcall(function()
                if v:IsA("ParticleEmitter") or v:IsA("Trail") or v:IsA("Smoke") or v:IsA("Fire") then
                    v.Enabled = false
                end
            end)
        end
        settings().Rendering.QualityLevel = Enum.QualityLevel.Level01
    else
        settings().Rendering.QualityLevel = Enum.QualityLevel.Automatic
        Lighting.GlobalShadows = true
    end
end

-- SKYBOX
local SKYBOXES = {
    Nenhum = nil,
    Night = { Bk = "rbxassetid://1233158420", Dn = "rbxassetid://1233158838", Ft = "rbxassetid://1233157105", Lf = "rbxassetid://1233157640", Rt = "rbxassetid://1233157995", Up = "rbxassetid://1233159158" },
    Purple = { Bk = "rbxassetid://6021017254", Dn = "rbxassetid://6021016390", Ft = "rbxassetid://6021015479", Lf = "rbxassetid://6021014807", Rt = "rbxassetid://6021012347", Up = "rbxassetid://6021011228" },
    Dragon = { Bk = "rbxassetid://14753804949", Dn = "rbxassetid://14753795573", Ft = "rbxassetid://14753807625", Lf = "rbxassetid://14753797417", Rt = "rbxassetid://14753799966", Up = "rbxassetid://14753810287" },
}

local function setSkybox(name)
    CFG.Skybox = name
    for _, v in ipairs(Lighting:GetChildren()) do
        if v:IsA("Sky") then v:Destroy() end
    end
    if name == "Nenhum" or not SKYBOXES[name] then return end
    local data = SKYBOXES[name]
    local sky = Instance.new("Sky")
    sky.SkyboxBk, sky.SkyboxDn, sky.SkyboxFt = data.Bk, data.Dn, data.Ft
    sky.SkyboxLf, sky.SkyboxRt, sky.SkyboxUp = data.Lf, data.Rt, data.Up
    sky.Parent = Lighting
end

-- NOCLIP
local noclipConn = nil
local function startNoclip()
    if noclipConn then return end
    CFG.Noclip = true
    noclipConn = RunService.Stepped:Connect(function()
        if not CFG.Noclip then return end
        local char = LP.Character
        if not char then return end
        for _, p in ipairs(char:GetDescendants()) do
            if p:IsA("BasePart") then p.CanCollide = false end
        end
    end)
end
local function stopNoclip()
    CFG.Noclip = false
    if noclipConn then noclipConn:Disconnect() noclipConn = nil end
end

-- FLY
local flyConn = nil
local function startFly()
    if flyConn then return end
    CFG.Fly = true
    local char = LP.Character
    if not char then return end
    local hum = char:FindFirstChildOfClass("Humanoid")
    if hum then hum.PlatformStand = true end
    flyConn = RunService.Heartbeat:Connect(function()
        if not CFG.Fly then return end
        local c = LP.Character
        if not c then return end
        local h = c:FindFirstChild("HumanoidRootPart")
        if not h then return end
        local cam = workspace.CurrentCamera
        local dir = Vector3.zero
        if UIS:IsKeyDown(Enum.KeyCode.W) then dir += cam.CFrame.LookVector end
        if UIS:IsKeyDown(Enum.KeyCode.S) then dir -= cam.CFrame.LookVector end
        if UIS:IsKeyDown(Enum.KeyCode.A) then dir -= cam.CFrame.RightVector end
        if UIS:IsKeyDown(Enum.KeyCode.D) then dir += cam.CFrame.RightVector end
        if UIS:IsKeyDown(Enum.KeyCode.Space) then dir += Vector3.new(0, 1, 0) end
        h.AssemblyLinearVelocity = dir.Magnitude > 0 and dir.Unit * CFG.FlySpeed or Vector3.zero
    end)
end
local function stopFly()
    CFG.Fly = false
    if flyConn then flyConn:Disconnect() flyConn = nil end
    local char = LP.Character
    if char then
        local hum = char:FindFirstChildOfClass("Humanoid")
        if hum then hum.PlatformStand = false end
    end
end

-- SPEED
local speedConn, speedOriginal = nil, 16
local function startSpeed()
    if speedConn then return end
    CFG.SpeedEnabled = true
    local char = LP.Character
    local hum = char and char:FindFirstChildOfClass("Humanoid")
    if hum then speedOriginal = hum.WalkSpeed; hum.WalkSpeed = CFG.SpeedValue end
    speedConn = RunService.Heartbeat:Connect(function()
        if not CFG.SpeedEnabled then return end
        local c = LP.Character
        if not c then return end
        local h = c:FindFirstChildOfClass("Humanoid")
        if h and h.WalkSpeed ~= CFG.SpeedValue then h.WalkSpeed = CFG.SpeedValue end
    end)
end
local function stopSpeed()
    CFG.SpeedEnabled = false
    if speedConn then speedConn:Disconnect() speedConn = nil end
    local char = LP.Character
    local hum = char and char:FindFirstChildOfClass("Humanoid")
    if hum then hum.WalkSpeed = speedOriginal end
end

-- AIMBOT
local aimbotConn = nil
local function startAimbot()
    if aimbotConn then return end
    CFG.Aimbot = true
    aimbotConn = RunService.RenderStepped:Connect(function()
        if not CFG.Aimbot then return end
        local cam = workspace.CurrentCamera
        local char = LP.Character
        if not char or not char:FindFirstChild("HumanoidRootPart") then return end
        local myPos = char.HumanoidRootPart.Position
        local target, minDist = nil, math.huge
        for _, plr in ipairs(Players:GetPlayers()) do
            if plr ~= LP and plr.Character then
                local hrp = plr.Character:FindFirstChild("HumanoidRootPart")
                local pHum = plr.Character:FindFirstChildOfClass("Humanoid")
                if hrp and pHum and pHum.Health > 0 then
                    local dist = (myPos - hrp.Position).Magnitude
                    if dist < minDist and dist < 500 then
                        local screenPos, onScreen = cam:WorldToViewportPoint(hrp.Position)
                        if onScreen then
                            local center = Vector2.new(cam.ViewportSize.X / 2, cam.ViewportSize.Y / 2)
                            local dist2D = (Vector2.new(screenPos.X, screenPos.Y) - center).Magnitude
                            if dist2D < CFG.AimbotFOV then
                                minDist = dist
                                target = plr
                            end
                        end
                    end
                end
            end
        end
        if target and target.Character then
            local tHrp = target.Character:FindFirstChild("HumanoidRootPart")
            if tHrp then
                local targetCF = CFrame.new(cam.CFrame.Position, tHrp.Position)
                cam.CFrame = cam.CFrame:Lerp(targetCF, CFG.AimbotSmooth)
            end
        end
    end)
end
local function stopAimbot()
    CFG.Aimbot = false
    if aimbotConn then aimbotConn:Disconnect() aimbotConn = nil end
end

-- ESP
local espFolder, espConn
local function isRealPlayer(character)
    for _, plr in ipairs(Players:GetPlayers()) do
        if plr.Character == character then return true end
    end
    return false
end
local function createESP(character, isBot)
    if not character or not character:FindFirstChild("HumanoidRootPart") then return end
    local hrp = character.HumanoidRootPart
    local color = isBot and Color3.fromRGB(255, 100, 0) or Color3.fromRGB(255, 50, 50)
    local label = isBot and "BOT" or (character.Name or "Player")
    local box = Instance.new("BoxHandleAdornment")
    box.Name = "PLX_ESP_Box"
    box.Adornee = hrp
    box.AlwaysOnTop = true
    box.Size = Vector3.new(4, 6, 4)
    box.Transparency = 0.5
    box.Color3 = color
    box.Parent = espFolder
    local bb = Instance.new("BillboardGui")
    bb.Name = "PLX_ESP_Name"
    bb.Size = UDim2.new(0, 100, 0, 24)
    bb.StudsOffset = Vector3.new(0, 3.5, 0)
    bb.AlwaysOnTop = true
    bb.Adornee = hrp
    bb.Parent = espFolder
    local nameLabel = Instance.new("TextLabel")
    nameLabel.Size = UDim2.new(1, 0, 1, 0)
    nameLabel.BackgroundTransparency = 1
    nameLabel.Text = label
    nameLabel.TextColor3 = color
    nameLabel.TextStrokeTransparency = 0
    nameLabel.Font = Enum.Font.GothamBold
    nameLabel.TextSize = 14
    nameLabel.Parent = bb
end
local function applyESP(on)
    CFG.ESP = on
    if on then
        if espFolder then espFolder:Destroy() end
        espFolder = Instance.new("Folder")
        espFolder.Name = "PALARRAX_ESP"
        espFolder.Parent = Workspace
        for _, plr in ipairs(Players:GetChildren()) do
            if plr ~= LP and plr.Character then
                createESP(plr.Character, false)
            end
        end
        if espConn then espConn:Disconnect() end
        espConn = Players.ChildAdded:Connect(function(obj)
            if not CFG.ESP then return end
            obj.CharacterAdded:Connect(function(char)
                task.wait(0.5)
                if CFG.ESP and char ~= LP.Character then createESP(char, false) end
            end)
        end)
    else
        if espFolder then espFolder:Destroy() espFolder = nil end
        if espConn then espConn:Disconnect() espConn = nil end
    end
end

-- HITBOX
local hitboxConn = nil
local function startHitbox()
    if hitboxConn then return end
    CFG.HitboxEnabled = true
    hitboxConn = RunService.Heartbeat:Connect(function()
        if not CFG.HitboxEnabled then return end
        for _, plr in ipairs(Players:GetChildren()) do
            if plr ~= LP and plr.Character then
                local hrp = plr.Character:FindFirstChild("HumanoidRootPart")
                if hrp then
                    hrp.Size = Vector3.new(CFG.HitboxSize, CFG.HitboxSize, CFG.HitboxSize)
                    hrp.CanCollide = false
                end
            end
        end
    end)
end
local function stopHitbox()
    CFG.HitboxEnabled = false
    if hitboxConn then hitboxConn:Disconnect() hitboxConn = nil end
    for _, plr in ipairs(Players:GetChildren()) do
        if plr ~= LP and plr.Character then
            local hrp = plr.Character:FindFirstChild("HumanoidRootPart")
            if hrp then hrp.Size = Vector3.new(2, 2, 1) end
        end
    end
end

-- ANTI-TAZE
local antiTazeConn = nil
local function startAntiTaze()
    if antiTazeConn then return end
    CFG.AntiTaze = true
    antiTazeConn = RunService.Heartbeat:Connect(function()
        if not CFG.AntiTaze then return end
        local char = LP.Character
        if not char then return end
        local hum = char:FindFirstChildOfClass("Humanoid")
        if hum and hum:GetState() == Enum.HumanoidStateType.Physics then
            hum:ChangeState(Enum.HumanoidStateType.Running)
        end
    end)
end
local function stopAntiTaze()
    CFG.AntiTaze = false
    if antiTazeConn then antiTazeConn:Disconnect() antiTazeConn = nil end
end

-- Guarda global
PLX.applyFPSBoost = applyFPSBoost
PLX.setSkybox = setSkybox
PLX.startNoclip = startNoclip; PLX.stopNoclip = stopNoclip
PLX.startFly = startFly; PLX.stopFly = stopFly
PLX.startSpeed = startSpeed; PLX.stopSpeed = stopSpeed
PLX.startAimbot = startAimbot; PLX.stopAimbot = stopAimbot
PLX.applyESP = applyESP
PLX.startHitbox = startHitbox; PLX.stopHitbox = stopHitbox
PLX.startAntiTaze = startAntiTaze; PLX.stopAntiTaze = stopAntiTaze
PLX.makeBtn = makeBtn
PLX.notify = notify

print("✅ Parte 1 carregada")
-- ============================================
-- THE PALARRAX v2.0 - PARTE 2/2
-- Botões do menu
-- ============================================

local PLX = _G.PLX
local CFG = PLX.CFG
local makeBtn = PLX.makeBtn
local notify = PLX.notify

-- ===== FUNÇÕES =====
makeBtn("ESP Players", 1, Color3.fromRGB(40, 55, 45), function()
    CFG.ESP = not CFG.ESP
    PLX.applyESP(CFG.ESP)
    notify("ESP: " .. (CFG.ESP and "ON" or "OFF"))
end)

makeBtn("Aimbot", 2, Color3.fromRGB(60, 40, 40), function()
    CFG.Aimbot = not CFG.Aimbot
    if CFG.Aimbot then PLX.startAimbot() else PLX.stopAimbot() end
    notify("Aimbot: " .. (CFG.Aimbot and "ON" or "OFF"))
end)

makeBtn("Hitbox Expander", 3, Color3.fromRGB(50, 40, 60), function()
    CFG.HitboxEnabled = not CFG.HitboxEnabled
    if CFG.HitboxEnabled then PLX.startHitbox() else PLX.stopHitbox() end
    notify("Hitbox: " .. (CFG.HitboxEnabled and "ON" or "OFF"))
end)

makeBtn("Anti-Taze", 4, Color3.fromRGB(60, 50, 30), function()
    CFG.AntiTaze = not CFG.AntiTaze
    if CFG.AntiTaze then PLX.startAntiTaze() else PLX.stopAntiTaze() end
    notify("Anti-Taze: " .. (CFG.AntiTaze and "ON" or "OFF"))
end)

makeBtn("Speed Boost", 5, Color3.fromRGB(60, 60, 30), function()
    CFG.SpeedEnabled = not CFG.SpeedEnabled
    if CFG.SpeedEnabled then PLX.startSpeed() else PLX.stopSpeed() end
    notify("Speed: " .. (CFG.SpeedEnabled and "ON" or "OFF"))
end)

makeBtn("Noclip", 6, Color3.fromRGB(60, 40, 80), function()
    CFG.Noclip = not CFG.Noclip
    if CFG.Noclip then PLX.startNoclip() else PLX.stopNoclip() end
    notify("Noclip: " .. (CFG.Noclip and "ON" or "OFF"))
end)

makeBtn("Fly (WASD)", 7, Color3.fromRGB(40, 60, 90), function()
    CFG.Fly = not CFG.Fly
    if CFG.Fly then PLX.startFly() else PLX.stopFly() end
    notify("Fly: " .. (CFG.Fly and "ON" or "OFF"))
end)

makeBtn("FPS Booster", 8, Color3.fromRGB(40, 60, 40), function()
    PLX.applyFPSBoost(not CFG.FPSBoost)
    notify("FPS Boost: " .. (CFG.FPSBoost and "ON" or "OFF"))
end)

makeBtn("Skybox: Night", 9, Color3.fromRGB(50, 50, 80), function()
    PLX.setSkybox("Night")
    notify("Skybox: Night")
end)

makeBtn("Skybox: Purple", 10, Color3.fromRGB(80, 50, 100), function()
    PLX.setSkybox("Purple")
    notify("Skybox: Purple")
end)

makeBtn("Skybox: Dragon", 11, Color3.fromRGB(100, 50, 50), function()
    PLX.setSkybox("Dragon")
    notify("Skybox: Dragon")
end)

makeBtn("Resetar Tudo", 12, Color3.fromRGB(80, 25, 25), function()
    PLX.applyESP(false); PLX.stopAimbot(); PLX.stopHitbox(); PLX.stopAntiTaze()
    PLX.stopSpeed(); PLX.stopNoclip(); PLX.stopFly(); PLX.applyFPSBoost(false)
    PLX.setSkybox("Nenhum")
    CFG.ESP = false; CFG.Aimbot = false; CFG.HitboxEnabled = false
    CFG.AntiTaze = false; CFG.SpeedEnabled = false; CFG.Noclip = false
    CFG.Fly = false; CFG.FPSBoost = false
    notify("Tudo resetado")
end)

makeBtn("Destruir Interface", 13, Color3.fromRGB(50, 20, 20), function()
    game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("PALARRAX_UI"):Destroy()
    _G.PALARRAX_LOADED = false
end)

notify("THE PALARRAX carregado!")
print("✅ THE PALARRAX v2.0 carregado")
