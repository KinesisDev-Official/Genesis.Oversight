-- ============================================================
-- [AC6 ELITE MIXER v10.5 FINAL] | Fichier complet + Delivery + Auto Money
-- ============================================================

local g                 = game
local Workspace         = g:GetService("Workspace")
local ReplicatedStorage = g:GetService("ReplicatedStorage")
local Players           = g:GetService("Players")
local TweenService      = g:GetService("TweenService")
local VirtualInput      = g:GetService("VirtualInputManager")
local LocalPlayer       = Players.LocalPlayer
local PlayerGui         = LocalPlayer:WaitForChild("PlayerGui")
local Camera            = Workspace.CurrentCamera

local FOUNDER_ID = 10140222244
local ADMIN_IDS  = { [8579665758] = true }

-- Nettoyage préventif
for _, gui in ipairs(PlayerGui:GetChildren()) do
    if gui.Name:match("^AC6_") then pcall(function() gui:Destroy() end) end
end
if _G.AC6_Gui   then pcall(function() _G.AC6_Gui:Destroy() end) end
if _G.AC6_Toast then pcall(function() _G.AC6_Toast:Destroy() end) end
if _G.AC6_Chat  then pcall(function() _G.AC6_Chat:Disconnect() end) end
if _G.AC6_DeliveryBeam then pcall(function() _G.AC6_DeliveryBeam:Destroy() end) end
_G.AC6_Gui, _G.AC6_Toast, _G.AC6_Chat, _G.AC6_HUD, _G.AC6_DeliveryBeam = nil, nil, nil, nil, nil

local REMOTE
do
    local f = Workspace:FindFirstChild("AC6_FE_Sounds", true)
    if f and f:IsA("RemoteEvent") then REMOTE = f end
    if not REMOTE then
        f = ReplicatedStorage:FindFirstChild("AC6_FE_Sounds", true)
        if f and f:IsA("RemoteEvent") then REMOTE = f end
    end
end
if not REMOTE then warn("[AC6] Remote introuvable"); return end

task.spawn(function()
    task.wait(2)
    local ds = Workspace:FindFirstChild("Delivery System")
    if not ds then return end
    local gp = ds:FindFirstChild("GetPackage")
    if gp then
        local p = gp:FindFirstChild("ReceivePrompt")
        if p and p:IsA("ProximityPrompt") then p.HoldDuration = 0 end
    end
    for _, child in ipairs(ds:GetChildren()) do
        if child.Name:match("^DropOff_") then
            for _, d in ipairs(child:GetDescendants()) do
                if d:IsA("ProximityPrompt") then d.HoldDuration = 0 end
            end
        end
    end
end)

local musicDatabase = {
    ["squid game"]="75184805557831", ["im gonna get up"]="1847606521",
    ["tralalero"]="138118304933431", ["brainrot"]="77584181920412",
    ["67"]="125476440612900", ["toma"]="129098116998483",
    ["beauty"]="71123357599630", ["drift phonk"]="80709171471864",
    ["brazilian phonk"]="102522233088145", ["alanwaad"]="17422074849",
    ["beauty slow"]="115249562236391", ["dress to impress"]="139161205970637",
    ["mare"]="103953736675768", ["night life groove"]="115229682295706",
    ["cold side of the bed"]="117904844519531", ["bloom"]="111030761139030",
    ["compliqué"]="133026342031539", ["aaye na kyun"]="76838943513288",
    ["deep work sanctuary"]="128760039494991", ["hen"]="117440978857712",
}

local THEMES = {
    Blue = { name="Bleu nuit",
        Bg=Color3.fromRGB(9,11,18), Bg2=Color3.fromRGB(14,17,26),
        Glass=Color3.fromRGB(22,26,40), Glass2=Color3.fromRGB(28,33,50),
        Input=Color3.fromRGB(26,30,46), InputHi=Color3.fromRGB(34,40,58),
        Accent=Color3.fromRGB(90,180,255), Accent2=Color3.fromRGB(160,120,255),
        Accent3=Color3.fromRGB(80,230,200), Green=Color3.fromRGB(90,220,150),
        Red=Color3.fromRGB(255,105,120), Orange=Color3.fromRGB(255,180,90),
        Pink=Color3.fromRGB(255,130,200), Txt=Color3.fromRGB(238,242,255),
        Sub=Color3.fromRGB(150,158,185), Muted=Color3.fromRGB(110,118,145),
        Stroke=Color3.fromRGB(52,60,88), StrokeHi=Color3.fromRGB(80,100,150) },
    Red = { name="Rouge sang",
        Bg=Color3.fromRGB(14,8,10), Bg2=Color3.fromRGB(22,12,15),
        Glass=Color3.fromRGB(32,18,22), Glass2=Color3.fromRGB(40,22,27),
        Input=Color3.fromRGB(36,20,24), InputHi=Color3.fromRGB(48,26,32),
        Accent=Color3.fromRGB(255,80,100), Accent2=Color3.fromRGB(255,130,90),
        Accent3=Color3.fromRGB(255,180,120), Green=Color3.fromRGB(120,220,130),
        Red=Color3.fromRGB(255,80,100), Orange=Color3.fromRGB(255,160,80),
        Pink=Color3.fromRGB(255,130,190), Txt=Color3.fromRGB(255,240,242),
        Sub=Color3.fromRGB(190,155,160), Muted=Color3.fromRGB(140,110,115),
        Stroke=Color3.fromRGB(80,40,48), StrokeHi=Color3.fromRGB(140,60,75) },
    Green = { name="Vert matrix",
        Bg=Color3.fromRGB(6,12,8), Bg2=Color3.fromRGB(10,18,12),
        Glass=Color3.fromRGB(16,28,20), Glass2=Color3.fromRGB(22,36,26),
        Input=Color3.fromRGB(20,34,24), InputHi=Color3.fromRGB(28,46,32),
        Accent=Color3.fromRGB(80,230,130), Accent2=Color3.fromRGB(130,230,170),
        Accent3=Color3.fromRGB(80,230,200), Green=Color3.fromRGB(90,240,140),
        Red=Color3.fromRGB(255,105,120), Orange=Color3.fromRGB(255,200,90),
        Pink=Color3.fromRGB(255,130,200), Txt=Color3.fromRGB(230,255,238),
        Sub=Color3.fromRGB(150,190,165), Muted=Color3.fromRGB(105,145,120),
        Stroke=Color3.fromRGB(40,75,52), StrokeHi=Color3.fromRGB(70,120,85) },
    Purple = { name="Violet néon",
        Bg=Color3.fromRGB(12,8,20), Bg2=Color3.fromRGB(18,12,30),
        Glass=Color3.fromRGB(26,18,44), Glass2=Color3.fromRGB(34,22,54),
        Input=Color3.fromRGB(30,20,48), InputHi=Color3.fromRGB(42,28,64),
        Accent=Color3.fromRGB(180,120,255), Accent2=Color3.fromRGB(255,120,220),
        Accent3=Color3.fromRGB(120,180,255), Green=Color3.fromRGB(120,230,170),
        Red=Color3.fromRGB(255,105,140), Orange=Color3.fromRGB(255,180,110),
        Pink=Color3.fromRGB(255,140,220), Txt=Color3.fromRGB(245,238,255),
        Sub=Color3.fromRGB(175,160,200), Muted=Color3.fromRGB(130,118,155),
        Stroke=Color3.fromRGB(60,45,95), StrokeHi=Color3.fromRGB(110,80,170) },
    Mono = { name="Sobre",
        Bg=Color3.fromRGB(10,10,12), Bg2=Color3.fromRGB(16,16,20),
        Glass=Color3.fromRGB(24,24,30), Glass2=Color3.fromRGB(32,32,40),
        Input=Color3.fromRGB(28,28,34), InputHi=Color3.fromRGB(38,38,46),
        Accent=Color3.fromRGB(200,200,215), Accent2=Color3.fromRGB(170,170,190),
        Accent3=Color3.fromRGB(220,220,235), Green=Color3.fromRGB(140,200,160),
        Red=Color3.fromRGB(230,120,130), Orange=Color3.fromRGB(220,180,120),
        Pink=Color3.fromRGB(220,170,200), Txt=Color3.fromRGB(240,240,245),
        Sub=Color3.fromRGB(170,170,180), Muted=Color3.fromRGB(130,130,140),
        Stroke=Color3.fromRGB(60,60,70), StrokeHi=Color3.fromRGB(100,100,115) },
    Cyberpunk = { name="Cyberpunk",
        Bg=Color3.fromRGB(18,6,26), Bg2=Color3.fromRGB(28,8,38),
        Glass=Color3.fromRGB(38,14,52), Glass2=Color3.fromRGB(48,18,66),
        Input=Color3.fromRGB(42,16,58), InputHi=Color3.fromRGB(58,22,78),
        Accent=Color3.fromRGB(255,60,180), Accent2=Color3.fromRGB(60,240,255),
        Accent3=Color3.fromRGB(255,240,60), Green=Color3.fromRGB(90,240,180),
        Red=Color3.fromRGB(255,80,120), Orange=Color3.fromRGB(255,150,90),
        Pink=Color3.fromRGB(255,80,220), Txt=Color3.fromRGB(255,240,255),
        Sub=Color3.fromRGB(200,160,230), Muted=Color3.fromRGB(150,110,180),
        Stroke=Color3.fromRGB(90,30,120), StrokeHi=Color3.fromRGB(180,60,220) },

    Sunset = { name="Coucher de soleil",
        Bg=Color3.fromRGB(20,10,14), Bg2=Color3.fromRGB(30,14,20),
        Glass=Color3.fromRGB(40,20,26), Glass2=Color3.fromRGB(52,26,34),
        Input=Color3.fromRGB(46,24,30), InputHi=Color3.fromRGB(62,32,42),
        Accent=Color3.fromRGB(255,140,80), Accent2=Color3.fromRGB(255,90,140),
        Accent3=Color3.fromRGB(255,200,120), Green=Color3.fromRGB(150,220,150),
        Red=Color3.fromRGB(255,90,100), Orange=Color3.fromRGB(255,160,80),
        Pink=Color3.fromRGB(255,150,190), Txt=Color3.fromRGB(255,240,235),
        Sub=Color3.fromRGB(200,165,160), Muted=Color3.fromRGB(155,120,120),
        Stroke=Color3.fromRGB(90,45,55), StrokeHi=Color3.fromRGB(160,80,95) },

    Ocean = { name="Océan",
        Bg=Color3.fromRGB(4,14,22), Bg2=Color3.fromRGB(8,22,34),
        Glass=Color3.fromRGB(14,34,50), Glass2=Color3.fromRGB(20,44,64),
        Input=Color3.fromRGB(18,40,58), InputHi=Color3.fromRGB(26,54,76),
        Accent=Color3.fromRGB(80,220,255), Accent2=Color3.fromRGB(150,120,255),
        Accent3=Color3.fromRGB(90,255,200), Green=Color3.fromRGB(120,240,180),
        Red=Color3.fromRGB(255,110,130), Orange=Color3.fromRGB(255,180,110),
        Pink=Color3.fromRGB(255,140,210), Txt=Color3.fromRGB(230,250,255),
        Sub=Color3.fromRGB(150,200,220), Muted=Color3.fromRGB(105,155,180),
        Stroke=Color3.fromRGB(35,80,110), StrokeHi=Color3.fromRGB(70,140,190) },
}

local C = {}
for k,v in pairs(THEMES.Blue) do C[k] = v end
local themeRefs = {}

local function fmtId(s)
    if not s or s == "" then return nil end
    if s:match("^rbxasset") then return s end
    local id = s:match("/asset/(%d+)")
    return "rbxassetid://" .. (id or s)
end
local function num(v, d) return tonumber(v) or d end

local function mk(c,p,par)
    local o=Instance.new(c)
    for k,v in pairs(p or {}) do o[k]=v end
    if par then o.Parent=par end
    return o
end
local function crn(i,r) return mk("UICorner",{CornerRadius=UDim.new(0,r or 12)},i) end
local function strk(i,c,t,tr) return mk("UIStroke",{Color=c or C.Stroke,Thickness=t or 1,Transparency=tr or 0},i) end
local function grad(i,c1,c2,rot) return mk("UIGradient",{Color=ColorSequence.new(c1,c2),Rotation=rot or 0,Parent=i}) end
local function hov(b, base, hi)
    b.MouseEnter:Connect(function() TweenService:Create(b,TweenInfo.new(.15),{BackgroundColor3=hi}):Play() end)
    b.MouseLeave:Connect(function() TweenService:Create(b,TweenInfo.new(.15),{BackgroundColor3=base}):Play() end)
end
local function reg(obj, kind, key)
    table.insert(themeRefs, {obj=obj, kind=kind, key=key})
end

local function getRole(plr)
    if plr.UserId == FOUNDER_ID then
        return {tag="👑 Fondateur", color=Color3.fromRGB(255,200,60)}
    elseif ADMIN_IDS[plr.UserId] then
        return {tag="⭐ Admin", color=Color3.fromRGB(180,120,255)}
    else
        return {tag="👤 Membre", color=Color3.fromRGB(150,158,185)}
    end
end

_G.AC6_Toast = Instance.new("ScreenGui")
_G.AC6_Toast.Name="AC6_Toasts"; _G.AC6_Toast.ResetOnSpawn=false
_G.AC6_Toast.IgnoreGuiInset=true; _G.AC6_Toast.Parent=PlayerGui

local function toast(kind,msg)
    local palette = {
        Success = C.Green, Error = C.Red, Warning = C.Orange, Info = C.Accent,
        Music   = C.Accent2, Vehicle = C.Accent3,
    }
    local col = palette[kind] or C.Accent
    local t = mk("Frame",{
        Size=UDim2.new(0,320,0,64), Position=UDim2.new(1,340,0,20),
        BackgroundColor3=C.Glass, BorderSizePixel=0, Parent=_G.AC6_Toast,
    })
    crn(t,14); strk(t, col, 1.2, .35)
    mk("Frame",{
        Size=UDim2.new(0,4,1,-20), Position=UDim2.new(0,0,0,10),
        BackgroundColor3=col, BorderSizePixel=0, Parent=t,
    })
    mk("TextLabel",{
        Size=UDim2.new(0,32,0,32), Position=UDim2.new(0,16,0,16),
        BackgroundTransparency=1,
        Text=({Success="✓",Error="X",Warning="!",Info="i",Music="♪",Vehicle="V"})[kind] or "i",
        TextColor3=col, Font=Enum.Font.GothamBlack, TextSize=18, Parent=t,
    })
    mk("TextLabel",{
        Size=UDim2.new(1,-72,0,18), Position=UDim2.new(0,54,0,12),
        BackgroundTransparency=1, Text=kind:upper(),
        TextColor3=col, Font=Enum.Font.GothamBold, TextSize=10,
        TextXAlignment=Enum.TextXAlignment.Left, Parent=t,
    })
    mk("TextLabel",{
        Size=UDim2.new(1,-72,0,22), Position=UDim2.new(0,54,0,30),
        BackgroundTransparency=1, Text=msg, TextColor3=C.Txt,
        Font=Enum.Font.Gotham, TextSize=13,
        TextXAlignment=Enum.TextXAlignment.Left,
        TextTruncate=Enum.TextTruncate.AtEnd, Parent=t,
    })
    TweenService:Create(t, TweenInfo.new(.35, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
        {Position=UDim2.new(1,-340,0,20)}):Play()
    task.delay(3, function()
        pcall(function()
            TweenService:Create(t, TweenInfo.new(.25), {BackgroundTransparency=1, Position=UDim2.new(1,340,0,20)}):Play()
            for _,ch in ipairs(t:GetDescendants()) do
                if ch:IsA("TextLabel") then
                    TweenService:Create(ch, TweenInfo.new(.25), {TextTransparency=1}):Play()
                elseif ch:IsA("Frame") and ch~=t then
                    TweenService:Create(ch, TweenInfo.new(.25), {BackgroundTransparency=1}):Play()
                elseif ch:IsA("UIStroke") then
                    TweenService:Create(ch, TweenInfo.new(.25), {Transparency=1}):Play()
                end
            end
            task.wait(.3); t:Destroy()
        end)
    end)
end

local S = { loop=false, mode="Me", specific=nil, curName=nil, curLabel="—",
            curId=nil, viewing=nil, soundDistance=100 }
local activeSounds  = {}
local vehicleSounds = {}
local highlights    = {}
local _ac6_idx      = 0

local function ac6_uniqName(tag)
    _ac6_idx = _ac6_idx + 1
    return string.format("ac6_%s_%d_%d", tag or "x", _ac6_idx, math.floor(tick()*1000)%100000)
end

local function stopNames(list)
    for _,n in ipairs(list) do
        pcall(function()
            REMOTE:FireServer("stopSound", n)
            REMOTE:FireServer("removeSound", n)
        end)
        activeSounds[n] = nil
    end
end
local function stopAll()
    local l = {}
    for n in pairs(activeSounds) do table.insert(l, n) end
    stopNames(l)
    activeSounds = {}
    S.curName = nil; S.curLabel = "—"; S.curId = nil
end
local function fire(target, id, pitch, vol, looped, name)
    pcall(function()
        REMOTE:FireServer("newSound", name, target, id, pitch, vol, looped, S.soundDistance)
        REMOTE:FireServer("playSound", name)
    end)
    activeSounds[name] = true
end

local pitchInp, volInp, idInp, LoopBtn, setMode, restartCurrentSound

local function findDriveSeat(seat)
    if not seat then return nil end
    local veh = seat.Parent
    while veh and veh ~= Workspace do
        if veh:IsA("Model") then break end
        veh = veh.Parent
    end
    if not veh then return nil end
    for _, d in ipairs(veh:GetDescendants()) do
        if d:IsA("VehicleSeat") and string.lower(d.Name):find("drive") then
            return d
        end
    end
    for _, d in ipairs(veh:GetDescendants()) do
        if d:IsA("VehicleSeat") then return d end
    end
    return seat
end

local function findBodySeat(seat)
    if not seat then return nil end
    local veh = seat.Parent
    while veh and veh ~= Workspace do
        if veh:IsA("Model") then break end
        veh = veh.Parent
    end
    if not veh then return nil end
    local body = veh:FindFirstChild("Body", true)
    if body then
        local s = body:FindFirstChild("Seat", true)
        if s then return s end
        for _, d in ipairs(body:GetDescendants()) do
            if d:IsA("Seat") and d ~= seat then return d end
        end
    end
    return seat
end

local function playMode(id, label)
    stopAll()
    local p  = num(pitchInp and pitchInp.Text, 1)
    local v  = num(volInp  and volInp.Text, 1)
    local lp = S.loop

    if S.mode == "Me" then
        local ch = LocalPlayer.Character
        local t  = ch and ch:FindFirstChild("HumanoidRootPart")
        if t then
            local nm = ac6_uniqName("me"); fire(t, id, p, v, lp, nm); S.curName = nm
        end
    elseif S.mode == "All" then
        local nm = ac6_uniqName("all"); fire(Workspace, id, p, v, lp, nm); S.curName = nm
    elseif S.mode == "Players" then
        for _, plr in ipairs(Players:GetPlayers()) do
            local ch = plr.Character
            local t  = ch and ch:FindFirstChild("HumanoidRootPart")
            if t then fire(t, id, p, v, lp, ac6_uniqName("p_"..plr.Name)) end
        end
    elseif S.mode == "Specific" and S.specific then
        local ch = S.specific.Character
        local t  = ch and ch:FindFirstChild("HumanoidRootPart")
        if t then
            local nm = ac6_uniqName("spec"); fire(t, id, p, v, lp, nm); S.curName = nm
        end
    end
    S.curLabel = label or "—"
    S.curId = id
end

restartCurrentSound = function()
    if not S.curId then return end
    playMode(S.curId, S.curLabel)
end

-- ============================================================
-- GUI
-- ============================================================
local GUI = mk("ScreenGui",{
    Name="AC6_EliteMixer_v10", ResetOnSpawn=false, IgnoreGuiInset=true,
    ZIndexBehavior=Enum.ZIndexBehavior.Sibling, Parent=PlayerGui,
})
_G.AC6_Gui = GUI

local Main = mk("Frame",{
    Name="Main",
    Size=UDim2.new(0,880,0,600), Position=UDim2.new(0.5,-440,0.5,-300),
    BackgroundColor3=C.Bg, BorderSizePixel=0, Active=true, Draggable=true, Parent=GUI,
})
crn(Main,18); strk(Main, C.StrokeHi, 1, .3)
reg(Main, "Bg", "Bg")
local mainGrad = grad(Main, C.Bg, C.Bg2, 55)
reg(mainGrad, "Grad", "Bg")

local topLine = mk("Frame",{
    Name="TopLine",
    Size=UDim2.new(1,-32,0,2), Position=UDim2.new(0,16,0,0),
    BackgroundColor3=C.Accent, BorderSizePixel=0, Parent=Main,
})
crn(topLine,2); local tg = grad(topLine, C.Accent, C.Accent2, 0)
reg(topLine, "Bg", "Accent"); reg(tg, "Grad", "AccentGrad")

local Side = mk("Frame",{
    Name="Sidebar",
    Size=UDim2.new(0,196,1,-32), Position=UDim2.new(0,16,0,16),
    BackgroundColor3=C.Glass, BorderSizePixel=0, Parent=Main,
})
crn(Side,14); strk(Side, C.Stroke, 1, .5); reg(Side, "Bg", "Glass")

local LogoBox = mk("Frame",{
    Name="LogoBox",
    Size=UDim2.new(1,-20,0,50), Position=UDim2.new(0,10,0,10),
    BackgroundTransparency=1, Parent=Side,
})
local LogoIcon = mk("Frame",{
    Name="LogoIcon",
    Size=UDim2.new(0,40,0,40), Position=UDim2.new(0,0,0,5),
    BackgroundColor3=C.Accent, BorderSizePixel=0, Parent=LogoBox,
})
crn(LogoIcon,11); local lg = grad(LogoIcon, C.Accent, C.Accent2, 45)
reg(LogoIcon, "Bg", "Accent"); reg(lg, "Grad", "AccentGrad")
mk("TextLabel",{Size=UDim2.new(1,0,1,0),BackgroundTransparency=1,Text="A6",
    TextColor3=Color3.new(1,1,1),Font=Enum.Font.GothamBlack,TextSize=17,Parent=LogoIcon})

local logoTitle = mk("TextLabel",{Size=UDim2.new(1,-52,0,18), Position=UDim2.new(0,52,0,6),
    BackgroundTransparency=1, Text="ELITE MIXER", TextColor3=C.Txt,
    Font=Enum.Font.GothamBlack, TextSize=14,
    TextXAlignment=Enum.TextXAlignment.Left, Parent=LogoBox})
reg(logoTitle,"Text","Txt")
local logoSub = mk("TextLabel",{Size=UDim2.new(1,-52,0,14), Position=UDim2.new(0,52,0,24),
    BackgroundTransparency=1, Text="v10.5 FINAL", TextColor3=C.Sub,
    Font=Enum.Font.Gotham, TextSize=10,
    TextXAlignment=Enum.TextXAlignment.Left, Parent=LogoBox})
reg(logoSub,"Text","Sub")

local SndCounter = mk("TextLabel",{
    Name="SndCounter",
    Size=UDim2.new(1,-20,0,18), Position=UDim2.new(0,10,0,66),
    BackgroundTransparency=1, Text="🎵 0 son actif",
    TextColor3=C.Sub, Font=Enum.Font.GothamBold, TextSize=10,
    TextXAlignment=Enum.TextXAlignment.Left, Parent=Side})
reg(SndCounter, "Text", "Sub")

local ProfileCard = mk("Frame",{
    Name="ProfileCard",
    Size=UDim2.new(1,-20,0,66), Position=UDim2.new(0,10,1,-130),
    BackgroundColor3=C.Glass2, BorderSizePixel=0, Parent=Side,
})
crn(ProfileCard,10); strk(ProfileCard, C.Stroke, 1, .5); reg(ProfileCard, "Bg", "Glass2")

local AvatarFrame = mk("Frame",{
    Name="AvatarFrame",
    Size=UDim2.new(0,50,0,50), Position=UDim2.new(0,8,0,8),
    BackgroundColor3=C.Input, BorderSizePixel=0, Parent=ProfileCard,
})
crn(AvatarFrame,12); reg(AvatarFrame, "Bg", "Input")

local AvatarImg = mk("ImageLabel",{
    Name="Avatar",
    Size=UDim2.new(1,-4,1,-4), Position=UDim2.new(0,2,0,2),
    BackgroundTransparency=1, Image="rbxassetid://0",
    ScaleType=Enum.ScaleType.Crop, Parent=AvatarFrame,
})
crn(AvatarImg,10)

local ProfileName = mk("TextLabel",{
    Name="ProfileName",
    Size=UDim2.new(1,-72,0,18), Position=UDim2.new(0,64,0,10),
    BackgroundTransparency=1, Text="Chargement...",
    TextColor3=C.Txt, Font=Enum.Font.GothamBold, TextSize=12,
    TextXAlignment=Enum.TextXAlignment.Left,
    TextTruncate=Enum.TextTruncate.AtEnd, Parent=ProfileCard})
reg(ProfileName, "Text", "Txt")

local ProfileTag = mk("TextLabel",{
    Name="ProfileTag",
    Size=UDim2.new(1,-72,0,16), Position=UDim2.new(0,64,0,32),
    BackgroundTransparency=1, Text="",
    TextColor3=C.Sub, Font=Enum.Font.GothamBold, TextSize=10,
    TextXAlignment=Enum.TextXAlignment.Left, Parent=ProfileCard})

task.spawn(function()
    local role = getRole(LocalPlayer)
    ProfileName.Text = LocalPlayer.DisplayName
    ProfileTag.Text = role.tag
    ProfileTag.TextColor3 = role.color
    local ok, thumb = pcall(function()
        return Players:GetUserThumbnailAsync(
            LocalPlayer.UserId, Enum.ThumbnailType.HeadShot,
            Enum.ThumbnailSize.Size100x100
        )
    end)
    if ok and thumb then AvatarImg.Image = thumb end
end)

local tabContents, tabButtons = {}, {}

local function makeTab(name, icon, ord, accentKey, label)
    local b = mk("TextButton",{
        Name="Btn_"..name,
        Size=UDim2.new(1,-20,0,40), Position=UDim2.new(0,10,0,90 + ord*46),
        BackgroundColor3=C.Glass2, BorderSizePixel=0, Text="",
        AutoButtonColor=false, Parent=Side,
    })
    crn(b,10); reg(b, "Bg", "Glass2")
    local bar = mk("Frame",{
        Name="Indicator",
        Size=UDim2.new(0,3,0,18), Position=UDim2.new(0,0,0,11),
        BackgroundColor3=C[accentKey], BorderSizePixel=0, Parent=b, Visible=false,
    })
    crn(bar,2); reg(bar, "Bg", accentKey)
    local ico = mk("TextLabel",{
        Name="Icon",
        Size=UDim2.new(0,26,1,0), Position=UDim2.new(0,12,0,0),
        BackgroundTransparency=1, Text=icon, TextColor3=C.Txt,
        Font=Enum.Font.GothamBold, TextSize=15, Parent=b,
    })
    reg(ico,"Text","Txt")
    local lbl = mk("TextLabel",{
        Name="Label",
        Size=UDim2.new(1,-50,1,0), Position=UDim2.new(0,42,0,0),
        BackgroundTransparency=1, Text=label, TextColor3=C.Sub,
        Font=Enum.Font.GothamMedium, TextSize=12,
        TextXAlignment=Enum.TextXAlignment.Left, Parent=b,
    })
    reg(lbl, "Text", "Sub")
    b.MouseEnter:Connect(function()
        TweenService:Create(b,TweenInfo.new(.15),{BackgroundColor3=C.InputHi}):Play()
    end)
    b.MouseLeave:Connect(function()
        if not tabButtons[name].active then
            TweenService:Create(b,TweenInfo.new(.15),{BackgroundColor3=C.Glass2}):Play()
        end
    end)
    tabButtons[name] = {btn=b, bar=bar, accentKey=accentKey, lbl=lbl, active=false}
    return b
end

makeTab("AUDIO",      "🎵", 0, "Accent",  "Audio")
makeTab("VEHICULES",  "🚗", 1, "Accent3", "Véhicules")
makeTab("VUE",        "👁", 2, "Accent2", "Vue joueurs")
makeTab("CHAOS",      "⚡", 3, "Orange",  "Chaos")
makeTab("FUN",        "🎮", 4, "Pink",    "FUN")
makeTab("DELIVERY",   "📦", 5, "Accent3", "Delivery")
makeTab("THEME",      "🎨", 6, "Pink",    "Thème")
makeTab("COMMANDES",  "📖", 7, "Green",   "Commandes")

local Footer = mk("Frame",{
    Name="Footer",
    Size=UDim2.new(1,-20,0,44), Position=UDim2.new(0,10,1,-54),
    BackgroundColor3=C.Glass2, BorderSizePixel=0, Parent=Side,
})
crn(Footer,10); reg(Footer, "Bg", "Glass2")
local f1 = mk("TextLabel",{Name="ModeLabel",Size=UDim2.new(1,-16,0,14),Position=UDim2.new(0,10,0,7),
    BackgroundTransparency=1, Text="Mode :",
    TextColor3=C.Sub, Font=Enum.Font.Gotham, TextSize=10,
    TextXAlignment=Enum.TextXAlignment.Left, Parent=Footer})
reg(f1,"Text","Sub")
local ModeIndicator = mk("TextLabel",{
    Name="ModeValue",
    Size=UDim2.new(0,80,0,14), Position=UDim2.new(1,-90,0,7),
    BackgroundTransparency=1, Text="ME", TextColor3=C.Accent,
    Font=Enum.Font.GothamBold, TextSize=10,
    TextXAlignment=Enum.TextXAlignment.Right, Parent=Footer})
reg(ModeIndicator, "Text", "Accent")

local Content = mk("Frame",{
    Name="Content",
    Size=UDim2.new(1,-248,1,-32), Position=UDim2.new(0,232,0,16),
    BackgroundTransparency=1, Parent=Main,
})
local function regTab(name, frameName)
    local f = mk("Frame",{Name=frameName or ("Tab_"..name),
        Size=UDim2.new(1,0,1,0),BackgroundTransparency=1,
        Visible=false,Parent=Content})
    tabContents[name]=f
    return f
end

local function switchTab(n)
    for k,v in pairs(tabContents) do v.Visible = (k == n) end
    for k,d in pairs(tabButtons) do
        local on = (k == n)
        d.active = on
        d.bar.Visible = on
        TweenService:Create(d.btn, TweenInfo.new(.18), {
            BackgroundColor3 = on and C.InputHi or C.Glass2,
        }):Play()
        d.lbl.TextColor3 = on and C.Txt or C.Sub
    end
end
for n,d in pairs(tabButtons) do
    d.btn.MouseButton1Click:Connect(function() switchTab(n) end)
end

local WinCtrl = mk("Frame",{
    Name="WinCtrl",
    Size=UDim2.new(0,110,0,30), Position=UDim2.new(1,-126,0,16),
    BackgroundTransparency=1, Parent=Main})
local BtnHide = mk("TextButton",{
    Name="Btn_Hide",
    Size=UDim2.new(0,72,0,30), BackgroundColor3=C.Glass,
    BorderSizePixel=0, Text="CACHER", TextColor3=C.Txt,
    Font=Enum.Font.GothamBold, TextSize=10, AutoButtonColor=false, Parent=WinCtrl})
crn(BtnHide,9); strk(BtnHide, C.Stroke, 1, .5)
reg(BtnHide, "Bg", "Glass"); reg(BtnHide, "Text", "Txt")
hov(BtnHide, C.Glass, C.InputHi)

local BtnClose = mk("TextButton",{
    Name="Btn_Close",
    Size=UDim2.new(0,30,0,30), Position=UDim2.new(0,78,0,0),
    BackgroundColor3=C.Glass, BorderSizePixel=0, Text="X",
    TextColor3=C.Red, Font=Enum.Font.GothamBlack, TextSize=15,
    AutoButtonColor=false, Parent=WinCtrl})
crn(BtnClose,9); strk(BtnClose, C.Stroke, 1, .5)
reg(BtnClose, "Bg", "Glass"); reg(BtnClose, "Text", "Red")
hov(BtnClose, C.Glass, C.Red)

BtnHide.MouseButton1Click:Connect(function()
    Main.Visible = not Main.Visible
    BtnHide.Text = Main.Visible and "CACHER" or "AFFICHER"
end)
BtnClose.MouseButton1Click:Connect(function()
    pcall(function() GUI:Destroy() end)
    pcall(function() _G.AC6_Toast:Destroy() end)
    for _,hl in pairs(highlights) do pcall(function() hl:Destroy() end) end
    _G.AC6_Gui, _G.AC6_Toast, _G.AC6_HUD = nil, nil, nil
    if _G.AC6_Chat then _G.AC6_Chat:Disconnect() end
end)

-- ═══════════ AUDIO ═══════════
local Audio = regTab("AUDIO", "Tab_Audio")

local aTitle = mk("TextLabel",{
    Name="Title",
    Size=UDim2.new(1,0,0,26), BackgroundTransparency=1, Text="Contrôle Audio",
    TextColor3=C.Txt, Font=Enum.Font.GothamBlack, TextSize=20,
    TextXAlignment=Enum.TextXAlignment.Left, Parent=Audio})
reg(aTitle,"Text","Txt")
local aSub = mk("TextLabel",{
    Name="Sub",
    Size=UDim2.new(1,0,0,14), Position=UDim2.new(0,0,0,26),
    BackgroundTransparency=1, Text="Choisis un mode, une musique, lance.",
    TextColor3=C.Sub, Font=Enum.Font.Gotham, TextSize=11,
    TextXAlignment=Enum.TextXAlignment.Left, Parent=Audio})
reg(aSub,"Text","Sub")

local NowCard = mk("Frame",{
    Name="NowCard",
    Size=UDim2.new(1,0,0,80), Position=UDim2.new(0,0,0,48),
    BackgroundColor3=C.Glass, BorderSizePixel=0, Parent=Audio,
})
crn(NowCard,14); strk(NowCard, C.Stroke, 1, .5); reg(NowCard, "Bg", "Glass")
local ng = grad(NowCard, C.Glass, C.Glass2, 45); reg(ng, "Grad", "GlassGrad")

local NPico = mk("Frame",{
    Name="NowIcon",
    Size=UDim2.new(0,48,0,48), Position=UDim2.new(0,14,0,16),
    BackgroundColor3=C.Accent, BorderSizePixel=0, Parent=NowCard,
})
crn(NPico,13); local npg = grad(NPico, C.Accent, C.Accent2, 45)
reg(NPico, "Bg", "Accent"); reg(npg, "Grad", "AccentGrad")
mk("TextLabel",{Size=UDim2.new(1,0,1,0), BackgroundTransparency=1, Text="🎵",
    TextColor3=Color3.new(1,1,1), Font=Enum.Font.GothamBlack, TextSize=22, Parent=NPico})

task.spawn(function()
    while GUI.Parent and NPico.Parent do
        task.wait(1.2)
        if NPico.Parent then
            TweenService:Create(NPico, TweenInfo.new(.6, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut),
                {Size=UDim2.new(0,52,0,52), Position=UDim2.new(0,12,0,14)}):Play()
            task.wait(.6)
            if NPico.Parent then
                TweenService:Create(NPico, TweenInfo.new(.6, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut),
                    {Size=UDim2.new(0,48,0,48), Position=UDim2.new(0,14,0,16)}):Play()
            end
        end
    end
end)

local NowTitle = mk("TextLabel",{
    Name="NowTitle",
    Size=UDim2.new(1,-220,0,20), Position=UDim2.new(0,74,0,12),
    BackgroundTransparency=1, Text="Aucune musique",
    TextColor3=C.Txt, Font=Enum.Font.GothamBold, TextSize=14,
    TextXAlignment=Enum.TextXAlignment.Left,
    TextTruncate=Enum.TextTruncate.AtEnd, Parent=NowCard})
reg(NowTitle, "Text", "Txt")
local NowSub = mk("TextLabel",{
    Name="NowSub",
    Size=UDim2.new(1,-220,0,14), Position=UDim2.new(0,74,0,32),
    BackgroundTransparency=1, Text="Sélectionne un mode et lance",
    TextColor3=C.Sub, Font=Enum.Font.Gotham, TextSize=10,
    TextXAlignment=Enum.TextXAlignment.Left, Parent=NowCard})
reg(NowSub, "Text", "Sub")

local BarBg = mk("Frame",{
    Name="ProgressBg",
    Size=UDim2.new(1,-220,0,5), Position=UDim2.new(0,74,0,54),
    BackgroundColor3=C.Input, BorderSizePixel=0, Parent=NowCard})
crn(BarBg,3); reg(BarBg, "Bg", "Input")
local BarFill = mk("Frame",{
    Name="ProgressFill",
    Size=UDim2.new(0,0,1,0), BackgroundColor3=C.Accent,
    BorderSizePixel=0, Parent=BarBg})
crn(BarFill,3); local bfg = grad(BarFill, C.Accent, C.Accent2, 0)
reg(BarFill, "Bg", "Accent"); reg(bfg, "Grad", "AccentGrad")

local TimeLbl = mk("TextLabel",{
    Name="TimeLbl",
    Size=UDim2.new(0,90,0,14), Position=UDim2.new(1,-100,0,52),
    BackgroundTransparency=1, Text="0:00 / 0:00", TextColor3=C.Sub,
    Font=Enum.Font.Gotham, TextSize=10,
    TextXAlignment=Enum.TextXAlignment.Right, Parent=NowCard})
reg(TimeLbl, "Text", "Sub")

local mTitle = mk("TextLabel",{
    Name="ModeTitle",
    Size=UDim2.new(1,0,0,12), Position=UDim2.new(0,0,0,142),
    BackgroundTransparency=1, Text="MODE DE CIBLE", TextColor3=C.Muted,
    Font=Enum.Font.GothamBold, TextSize=9,
    TextXAlignment=Enum.TextXAlignment.Left, Parent=Audio})
reg(mTitle,"Text","Muted")

local modeBtns = {}
local function makeMode(lbl, m, x, accKey)
    local b = mk("TextButton",{
        Name="Mode_"..m,
        Size=UDim2.new(0,96,0,34), Position=UDim2.new(0,x,0,160),
        BackgroundColor3=C.Glass, BorderSizePixel=0, Text=lbl,
        TextColor3=C.Txt, Font=Enum.Font.GothamBold, TextSize=11,
        AutoButtonColor=false, Parent=Audio,
    })
    crn(b,9); strk(b, C.Stroke, 1, .5)
    reg(b, "Bg", "Glass"); reg(b, "Text", "Txt")
    modeBtns[m] = {btn=b, accKey=accKey}
    b.MouseEnter:Connect(function()
        if S.mode ~= m then TweenService:Create(b,TweenInfo.new(.15),{BackgroundColor3=C.InputHi}):Play() end
    end)
    b.MouseLeave:Connect(function()
        if S.mode ~= m then TweenService:Create(b,TweenInfo.new(.15),{BackgroundColor3=C.Glass}):Play() end
    end)
end
makeMode("MOI",       "Me",       0,   "Accent")
makeMode("TOUS",      "All",      104, "Accent2")
makeMode("JOUEURS",   "Players",  208, "Accent3")
makeMode("SPÉCIFIQUE","Specific", 312, "Pink")

local function refreshModes()
    for m,d in pairs(modeBtns) do
        local on = (m==S.mode)
        d.btn.BackgroundColor3 = on and C[d.accKey] or C.Glass
        d.btn.TextColor3 = on and Color3.fromRGB(15,20,35) or C.Txt
        local s = d.btn:FindFirstChildOfClass("UIStroke")
        if s then s.Color = on and C[d.accKey] or C.Stroke end
    end
end

local SpecList = mk("ScrollingFrame",{
    Name="SpecList",
    Size=UDim2.new(1,0,0,0), Position=UDim2.new(0,0,0,202),
    BackgroundColor3=C.Glass, BorderSizePixel=0,
    CanvasSize=UDim2.new(0,0,0,0), ScrollBarThickness=4,
    ScrollBarImageColor3=C.Accent, Visible=false, Parent=Audio,
})
crn(SpecList,9); strk(SpecList, C.Stroke, 1, .5); reg(SpecList, "Bg", "Glass")
local SL = mk("UIListLayout",{Padding=UDim.new(0,4),Parent=SpecList})
mk("UIPadding",{PaddingTop=UDim.new(0,6),PaddingBottom=UDim.new(0,6),PaddingLeft=UDim.new(0,6),PaddingRight=UDim.new(0,6)},SpecList)
SL:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    SpecList.CanvasSize = UDim2.new(0,0,0, SL.AbsoluteContentSize.Y + 12)
end)

local function refreshSpec()
    for _,c2 in ipairs(SpecList:GetChildren()) do
        if c2:IsA("TextButton") then c2:Destroy() end
    end
    for _,p in ipairs(Players:GetPlayers()) do
        if p ~= LocalPlayer then
            local b = mk("TextButton",{
                Name="Spec_"..p.Name,
                Size=UDim2.new(1,-8,0,26), BackgroundColor3=C.Input,
                BorderSizePixel=0, Text="  "..p.DisplayName.."  (@"..p.Name..")",
                TextColor3=C.Txt, Font=Enum.Font.Gotham, TextSize=11,
                TextXAlignment=Enum.TextXAlignment.Left, Parent=SpecList,
            })
            crn(b,6); reg(b, "Bg", "Input"); reg(b, "Text", "Txt")
            b.MouseButton1Click:Connect(function()
                S.specific = p; S.mode = "Specific"; refreshModes()
                ModeIndicator.Text = "SPÉCIFIQUE"
                toast("Info","Cible : "..p.DisplayName)
            end)
        end
    end
end

setMode = function(m)
    S.mode = m; refreshModes()
    ModeIndicator.Text = ({Me="MOI",All="TOUS",Players="JOUEURS",Specific="SPÉCIFIQUE"})[m] or string.upper(m)
    if m == "Specific" then
        SpecList.Visible = true; SpecList.Size = UDim2.new(1,0,0,100); refreshSpec()
    else
        SpecList.Visible = false; SpecList.Size = UDim2.new(1,0,0,0)
    end
end
for m,d in pairs(modeBtns) do
    d.btn.MouseButton1Click:Connect(function() setMode(m) end)
end
refreshModes()

local idTitle = mk("TextLabel",{
    Name="IdTitle",
    Size=UDim2.new(1,0,0,12), Position=UDim2.new(0,0,0,242),
    BackgroundTransparency=1, Text="NOM OU ID DE LA MUSIQUE", TextColor3=C.Muted,
    Font=Enum.Font.GothamBold, TextSize=9,
    TextXAlignment=Enum.TextXAlignment.Left, Parent=Audio})
reg(idTitle,"Text","Muted")

local idHolder = mk("Frame",{
    Name="IdHolder",
    Size=UDim2.new(1,0,0,40), Position=UDim2.new(0,0,0,260),
    BackgroundColor3=C.Input, BorderSizePixel=0, Parent=Audio,
})
crn(idHolder,10); strk(idHolder, C.Stroke, 1, .5); reg(idHolder, "Bg", "Input")
local idIco = mk("TextLabel",{
    Size=UDim2.new(0,28,0,40), Position=UDim2.new(0,8,0,0),
    BackgroundTransparency=1, Text="🎵", TextColor3=C.Accent,
    Font=Enum.Font.GothamBold, TextSize=14, Parent=idHolder})
reg(idIco,"Text","Accent")
idInp = mk("TextBox",{
    Name="IdInput",
    Size=UDim2.new(1,-46,1,0), Position=UDim2.new(0,38,0,0),
    BackgroundTransparency=1, Text="",
    PlaceholderText="Ex: squid game  ou  75184805557831",
    PlaceholderColor3=C.Muted, TextColor3=C.Txt,
    Font=Enum.Font.Gotham, TextSize=12,
    TextXAlignment=Enum.TextXAlignment.Left,
    ClearTextOnFocus=false, Parent=idHolder,
})
reg(idInp, "Text", "Txt")
idInp.Focused:Connect(function()
    TweenService:Create(idHolder, TweenInfo.new(.15), {BackgroundColor3=C.InputHi}):Play()
end)
idInp.FocusLost:Connect(function()
    TweenService:Create(idHolder, TweenInfo.new(.15), {BackgroundColor3=C.Input}):Play()
end)

local pTitle = mk("TextLabel",{Name="PitchTitle",Size=UDim2.new(0,80,0,12),Position=UDim2.new(0,0,0,310),
    BackgroundTransparency=1,Text="PITCH",TextColor3=C.Muted,
    Font=Enum.Font.GothamBold,TextSize=9,
    TextXAlignment=Enum.TextXAlignment.Left,Parent=Audio})
reg(pTitle,"Text","Muted")
local vTitle = mk("TextLabel",{Name="VolTitle",Size=UDim2.new(0,80,0,12),Position=UDim2.new(0,96,0,310),
    BackgroundTransparency=1,Text="VOLUME",TextColor3=C.Muted,
    Font=Enum.Font.GothamBold,TextSize=9,
    TextXAlignment=Enum.TextXAlignment.Left,Parent=Audio})
reg(vTitle,"Text","Muted")

local function numInput(x, default, onConfirm, name)
    local h = mk("Frame",{
        Name=name or "NumHolder",
        Size=UDim2.new(0,86,0,34), Position=UDim2.new(0,x,0,326),
        BackgroundColor3=C.Input, BorderSizePixel=0, Parent=Audio})
    crn(h,9); strk(h, C.Stroke, 1, .5); reg(h, "Bg", "Input")
    local inp = mk("TextBox",{
        Name="Input",
        Size=UDim2.new(1,0,1,0), BackgroundTransparency=1,
        Text=default, TextColor3=C.Txt, Font=Enum.Font.GothamBold,
        TextSize=13, Parent=h})
    reg(inp, "Text", "Txt")
    if onConfirm then inp.FocusLost:Connect(onConfirm) end
    return inp, h
end
pitchInp = numInput(0, "1", function() if S.curId then restartCurrentSound() end end, "PitchHolder")
volInp   = numInput(96, "1", function() if S.curId then restartCurrentSound() end end, "VolHolder")

LoopBtn = mk("TextButton",{
    Name="Btn_Loop",
    Size=UDim2.new(0,130,0,34), Position=UDim2.new(0,192,0,326),
    BackgroundColor3=C.Glass, BorderSizePixel=0, Text="🔁  BOUCLE OFF",
    TextColor3=C.Txt, Font=Enum.Font.GothamBold, TextSize=11,
    AutoButtonColor=false, Parent=Audio,
})
crn(LoopBtn,9); strk(LoopBtn, C.Stroke, 1, .5)
reg(LoopBtn, "Bg", "Glass"); reg(LoopBtn, "Text", "Txt")
LoopBtn.MouseEnter:Connect(function()
    if not S.loop then TweenService:Create(LoopBtn,TweenInfo.new(.15),{BackgroundColor3=C.InputHi}):Play() end
end)
LoopBtn.MouseLeave:Connect(function()
    if not S.loop then TweenService:Create(LoopBtn,TweenInfo.new(.15),{BackgroundColor3=C.Glass}):Play() end
end)
LoopBtn.MouseButton1Click:Connect(function()
    S.loop = not S.loop
    LoopBtn.BackgroundColor3 = S.loop and C.Green or C.Glass
    LoopBtn.TextColor3 = S.loop and Color3.fromRGB(15,30,20) or C.Txt
    LoopBtn.Text = S.loop and "🔁  BOUCLE ON" or "🔁  BOUCLE OFF"
    local s = LoopBtn:FindFirstChildOfClass("UIStroke")
    if s then s.Color = S.loop and C.Green or C.Stroke end
    if S.curId then restartCurrentSound() end
end)

local PlayBtn = mk("TextButton",{
    Name="Btn_Play",
    Size=UDim2.new(0,180,0,44), Position=UDim2.new(0,0,0,374),
    BackgroundColor3=C.Green, BorderSizePixel=0, Text="▶   LANCER",
    TextColor3=Color3.fromRGB(15,30,20), Font=Enum.Font.GothamBlack,
    TextSize=15, AutoButtonColor=false, Parent=Audio})
crn(PlayBtn,12); local pgb = grad(PlayBtn, C.Green, C.Accent3, 15)
reg(PlayBtn, "Bg", "Green"); reg(pgb, "Grad", "GreenGrad")
PlayBtn.MouseEnter:Connect(function() TweenService:Create(PlayBtn,TweenInfo.new(.15),{BackgroundColor3=Color3.fromRGB(120,235,175)}):Play() end)
PlayBtn.MouseLeave:Connect(function() TweenService:Create(PlayBtn,TweenInfo.new(.15),{BackgroundColor3=C.Green}):Play() end)

local StopBtn = mk("TextButton",{
    Name="Btn_Stop",
    Size=UDim2.new(0,130,0,44), Position=UDim2.new(0,190,0,374),
    BackgroundColor3=C.Red, BorderSizePixel=0, Text="⏹   STOP",
    TextColor3=C.Txt, Font=Enum.Font.GothamBlack, TextSize=14,
    AutoButtonColor=false, Parent=Audio})
crn(StopBtn,12); reg(StopBtn, "Bg", "Red")
StopBtn.MouseEnter:Connect(function() TweenService:Create(StopBtn,TweenInfo.new(.15),{BackgroundColor3=Color3.fromRGB(255,130,140)}):Play() end)
StopBtn.MouseLeave:Connect(function() TweenService:Create(StopBtn,TweenInfo.new(.15),{BackgroundColor3=C.Red}):Play() end)

local ResetBtn = mk("TextButton",{
    Name="Btn_Reset",
    Size=UDim2.new(0,130,0,44), Position=UDim2.new(0,330,0,374),
    BackgroundColor3=C.Glass, BorderSizePixel=0, Text="🔄   RESET",
    TextColor3=C.Txt, Font=Enum.Font.GothamBold, TextSize=12,
    AutoButtonColor=false, Parent=Audio})
crn(ResetBtn,12); strk(ResetBtn, C.Stroke, 1, .5)
reg(ResetBtn, "Bg", "Glass"); reg(ResetBtn, "Text", "Txt")
hov(ResetBtn, C.Glass, C.InputHi)

PlayBtn.MouseButton1Click:Connect(function()
    local raw = idInp.Text
    if raw == "" then toast("Warning","Aucune musique sélectionnée"); return end
    local id = musicDatabase[string.lower(raw)] or fmtId(raw)
    if not id then toast("Error","ID invalide"); return end
    playMode(id, raw)
    toast("Music","▶ "..raw)
end)
StopBtn.MouseButton1Click:Connect(function()
    stopAll(); toast("Info","Son arrêté")
end)
ResetBtn.MouseButton1Click:Connect(function()
    stopAll()
    pitchInp.Text="1"; volInp.Text="1"; idInp.Text=""
    S.loop = false
    LoopBtn.BackgroundColor3 = C.Glass
    LoopBtn.TextColor3 = C.Txt
    LoopBtn.Text = "🔁  BOUCLE OFF"
    local s = LoopBtn:FindFirstChildOfClass("UIStroke")
    if s then s.Color = C.Stroke end
    toast("Info","Reset effectué")
end)

local DistTitle = mk("TextLabel",{
    Name="DistTitle",
    Size=UDim2.new(1,0,0,12), Position=UDim2.new(0,0,0,428),
    BackgroundTransparency=1, Text="DISTANCE DU SON", TextColor3=C.Muted,
    Font=Enum.Font.GothamBold, TextSize=9,
    TextXAlignment=Enum.TextXAlignment.Left, Parent=Audio})
reg(DistTitle,"Text","Muted")

local distOptions = {
    {name="Local",  value=15,   colKey="Green"},
    {name="Proche", value=50,   colKey="Accent3"},
    {name="Moyen",  value=150,  colKey="Accent"},
    {name="Loin",   value=500,  colKey="Orange"},
    {name="Infini", value=10000,colKey="Red"},
}
local distBtns = {}

local function refreshDistBtns()
    for _, d in ipairs(distBtns) do
        local on = (S.soundDistance == d.value)
        d.btn.BackgroundColor3 = on and C[d.colKey] or C.Glass
        d.btn.TextColor3 = on and Color3.fromRGB(15,20,35) or C.Txt
        local s = d.btn:FindFirstChildOfClass("UIStroke")
        if s then s.Color = on and C[d.colKey] or C.Stroke end
    end
end

for i, opt in ipairs(distOptions) do
    local x = (i-1) * 92
    local b = mk("TextButton",{
        Name="Dist_"..opt.name,
        Size=UDim2.new(0,86,0,30), Position=UDim2.new(0,x,0,446),
        BackgroundColor3=C.Glass, BorderSizePixel=0, Text=opt.name,
        TextColor3=C.Txt, Font=Enum.Font.GothamBold, TextSize=10,
        AutoButtonColor=false, Parent=Audio})
    crn(b,8); strk(b, C.Stroke, 1, .5)
    reg(b, "Bg", "Glass"); reg(b, "Text", "Txt")
    b.MouseEnter:Connect(function()
        if S.soundDistance ~= opt.value then
            TweenService:Create(b,TweenInfo.new(.15),{BackgroundColor3=C.InputHi}):Play()
        end
    end)
    b.MouseLeave:Connect(function()
        if S.soundDistance ~= opt.value then
            TweenService:Create(b,TweenInfo.new(.15),{BackgroundColor3=C.Glass}):Play()
        end
    end)
    b.MouseButton1Click:Connect(function()
        S.soundDistance = opt.value
        refreshDistBtns()
        if S.curId then restartCurrentSound() end
        toast("Info","Distance : "..opt.name)
    end)
    table.insert(distBtns, {btn=b, value=opt.value, colKey=opt.colKey})
end
refreshDistBtns()

-- ═══════════ VEHICULES ═══════════
local Veh = regTab("VEHICULES", "Tab_Vehicules")

local vehTitle = mk("TextLabel",{
    Name="Title",
    Size=UDim2.new(1,-130,0,26), BackgroundTransparency=1, Text="Audio Véhicule",
    TextColor3=C.Txt, Font=Enum.Font.GothamBlack, TextSize=20,
    TextXAlignment=Enum.TextXAlignment.Left, Parent=Veh})
reg(vehTitle,"Text","Txt")
local vehSub = mk("TextLabel",{
    Name="Sub",
    Size=UDim2.new(1,0,0,14), Position=UDim2.new(0,0,0,26),
    BackgroundTransparency=1, Text="👤 perso  •  🚗 DriveSeat  •  🪑 Body.Seat",
    TextColor3=C.Sub, Font=Enum.Font.Gotham, TextSize=11,
    TextXAlignment=Enum.TextXAlignment.Left, Parent=Veh})
reg(vehSub,"Text","Sub")

local RefreshBtn = mk("TextButton",{
    Name="Btn_RefreshVeh",
    Size=UDim2.new(0,110,0,30), Position=UDim2.new(1,-236,0,0),
    BackgroundColor3=C.Accent3, BorderSizePixel=0, Text="🔃  ACTUALISER",
    TextColor3=Color3.fromRGB(10,30,25), Font=Enum.Font.GothamBold,
    TextSize=11, AutoButtonColor=false, Parent=Veh})
crn(RefreshBtn,9); reg(RefreshBtn, "Bg", "Accent3")
RefreshBtn.MouseEnter:Connect(function() TweenService:Create(RefreshBtn,TweenInfo.new(.15),{BackgroundColor3=Color3.fromRGB(120,240,220)}):Play() end)
RefreshBtn.MouseLeave:Connect(function() TweenService:Create(RefreshBtn,TweenInfo.new(.15),{BackgroundColor3=C.Accent3}):Play() end)

local VehSearchHolder = mk("Frame",{
    Name="SearchHolder",
    Size=UDim2.new(1,0,0,30), Position=UDim2.new(0,0,0,50),
    BackgroundColor3=C.Input, BorderSizePixel=0, Parent=Veh})
crn(VehSearchHolder,8); strk(VehSearchHolder, C.Stroke, 1, .5); reg(VehSearchHolder, "Bg", "Input")
mk("TextLabel",{
    Size=UDim2.new(0,26,1,0), Position=UDim2.new(0,8,0,0),
    BackgroundTransparency=1, Text="🔍", TextColor3=C.Accent,
    Font=Enum.Font.GothamBold, TextSize=13, Parent=VehSearchHolder})
local VehSearch = mk("TextBox",{
    Name="SearchInput",
    Size=UDim2.new(1,-38,1,0), Position=UDim2.new(0,34,0,0),
    BackgroundTransparency=1, Text="",
    PlaceholderText="Rechercher un joueur...",
    PlaceholderColor3=C.Muted, TextColor3=C.Txt,
    Font=Enum.Font.Gotham, TextSize=12,
    TextXAlignment=Enum.TextXAlignment.Left,
    ClearTextOnFocus=false, Parent=VehSearchHolder})
reg(VehSearch, "Text", "Txt")

local VehList = mk("ScrollingFrame",{
    Name="VehList",
    Size=UDim2.new(1,0,1,-96), Position=UDim2.new(0,0,0,86),
    BackgroundColor3=C.Glass, BorderSizePixel=0,
    CanvasSize=UDim2.new(0,0,0,0), ScrollBarThickness=5,
    ScrollBarImageColor3=C.Accent3, Parent=Veh})
crn(VehList,12); strk(VehList, C.Stroke, 1, .5); reg(VehList, "Bg", "Glass")
local VL = mk("UIListLayout",{Padding=UDim.new(0,5),Parent=VehList})
mk("UIPadding",{PaddingTop=UDim.new(0,7),PaddingBottom=UDim.new(0,7),PaddingLeft=UDim.new(0,7),PaddingRight=UDim.new(0,7)},VehList)
VL:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    VehList.CanvasSize = UDim2.new(0,0,0, VL.AbsoluteContentSize.Y + 14)
end)

local function getVehicleModel(seat)
    local p = seat.Parent
    while p and p ~= Workspace do
        if p:IsA("Model") then return p end
        p = p.Parent
    end
end

local function refreshVeh()
    for _,c2 in ipairs(VehList:GetChildren()) do
        if c2:IsA("Frame") then c2:Destroy() end
    end
    local filter = string.lower(VehSearch.Text)
    local players = Players:GetPlayers()
    if #players == 0 then
        local empty = mk("TextLabel",{Size=UDim2.new(1,-16,0,36),BackgroundTransparency=1,
            Text="Aucun joueur dans le serveur",TextColor3=C.Muted,
            Font=Enum.Font.Gotham,TextSize=12,Parent=VehList})
        reg(empty,"Text","Muted")
        return
    end

    for _, plr in ipairs(players) do
        local match = (filter == "") or string.find(string.lower(plr.DisplayName), filter, 1, true) or
                       string.find(string.lower(plr.Name), filter, 1, true)
        if match then
            local ch  = plr.Character
            local hum = ch and ch:FindFirstChildOfClass("Humanoid")
            local seat = hum and hum.SeatPart
            local vehName = "—"
            if seat then
                local m = getVehicleModel(seat)
                vehName = m and m.Name or seat.Name
            end

            local row = mk("Frame",{
                Name="Row_"..plr.Name,
                Size=UDim2.new(1,-14,0,62), BackgroundColor3=C.Glass,
                BorderSizePixel=0, Parent=VehList})
            crn(row,10); strk(row, C.Stroke, 1, .5); reg(row, "Bg", "Glass")

            local dotHolder = mk("Frame",{
                Name="Dot",
                Size=UDim2.new(0,10,0,10), Position=UDim2.new(0,12,0,14),
                BackgroundColor3=seat and C.Accent3 or C.Muted,
                BorderSizePixel=0, Parent=row})
            crn(dotHolder,5)
            reg(dotHolder, "Bg", seat and "Accent3" or "Muted")

            local nameL = mk("TextLabel",{
                Name="Name",
                Size=UDim2.new(0,180,0,16), Position=UDim2.new(0,30,0,10),
                BackgroundTransparency=1,
                Text=(plr==LocalPlayer and "★ " or "")..plr.DisplayName,
                TextColor3=C.Txt, Font=Enum.Font.GothamBold, TextSize=12,
                TextXAlignment=Enum.TextXAlignment.Left, Parent=row})
            reg(nameL,"Text","Txt")
            local statL = mk("TextLabel",{
                Name="Status",
                Size=UDim2.new(0,180,0,14), Position=UDim2.new(0,30,0,30),
                BackgroundTransparency=1,
                Text=seat and ("🚗 "..vehName) or "🚶 À pied",
                TextColor3=seat and C.Accent3 or C.Sub,
                Font=Enum.Font.Gotham, TextSize=10,
                TextXAlignment=Enum.TextXAlignment.Left,
                TextTruncate=Enum.TextTruncate.AtEnd, Parent=row})
            reg(statL, "Text", seat and "Accent3" or "Sub")

            local vInpHolder = mk("Frame",{
                Name="IdHolder",
                Size=UDim2.new(0,150,0,30), Position=UDim2.new(0,220,0,16),
                BackgroundColor3=C.Input, BorderSizePixel=0, Parent=row})
            crn(vInpHolder,7); strk(vInpHolder, C.Stroke, 1, .5); reg(vInpHolder, "Bg", "Input")
            local vInp = mk("TextBox",{
                Name="IdInput",
                Size=UDim2.new(1,-16,1,0), Position=UDim2.new(0,10,0,0),
                BackgroundTransparency=1, Text="",
                PlaceholderText="🎵 ID...", PlaceholderColor3=C.Muted,
                TextColor3=C.Txt, Font=Enum.Font.Gotham, TextSize=11,
                TextXAlignment=Enum.TextXAlignment.Left,
                ClearTextOnFocus=false, Parent=vInpHolder})
            reg(vInp, "Text", "Txt")

            local function makeActBtn(x, txt, colKey, hoverCol, btnName)
                local base = C[colKey]
                local b = mk("TextButton",{
                    Name=btnName or "ActBtn",
                    Size=UDim2.new(0,44,0,34), Position=UDim2.new(0,x,0,14),
                    BackgroundColor3=base, BorderSizePixel=0, Text=txt,
                    TextColor3=Color3.fromRGB(15,25,20), Font=Enum.Font.GothamBold,
                    TextSize=16, AutoButtonColor=false, Parent=row})
                crn(b,8)
                reg(b, "Bg", colKey)
                b.MouseEnter:Connect(function() TweenService:Create(b,TweenInfo.new(.15),{BackgroundColor3=hoverCol}):Play() end)
                b.MouseLeave:Connect(function() TweenService:Create(b,TweenInfo.new(.15),{BackgroundColor3=C[colKey]}):Play() end)
                return b
            end

            local PB1 = makeActBtn(378, "👤", "Accent", C.Accent, "Btn_OnPlayer")
            local PB2 = makeActBtn(426, "🚗", "Accent3", C.Accent3, "Btn_OnVehicle")
            if not seat then
                PB2.BackgroundColor3 = C.Glass
                PB2.TextColor3 = C.Muted
            end
            local PB3 = makeActBtn(474, "🪑", "Accent2", C.Accent2, "Btn_OnBodySeat")
            if not seat then
                PB3.BackgroundColor3 = C.Glass
                PB3.TextColor3 = C.Muted
            end
            local SB = makeActBtn(522, "⏹", "Red", C.Red, "Btn_StopRow")
            SB.TextColor3 = C.Txt

            local function resolve()
                local raw = vInp.Text
                if raw == "" then raw = idInp.Text end
                if raw == "" then toast("Warning","Entre un ID"); return nil end
                return raw, musicDatabase[string.lower(raw)] or fmtId(raw)
            end

            PB1.MouseButton1Click:Connect(function()
                local raw, id = resolve()
                if not id then return end
                local c = plr.Character
                local t = c and c:FindFirstChild("HumanoidRootPart")
                if not t then toast("Error","Pas de perso"); return end
                fire(t, id, num(pitchInp.Text,1), num(volInp.Text,1), S.loop, ac6_uniqName("pc_"..plr.Name))
                toast("Music","▶ "..raw.." → "..plr.DisplayName)
            end)

            PB2.MouseButton1Click:Connect(function()
                if not seat then
                    toast("Warning", plr.DisplayName.." n'est pas dans un véhicule"); return
                end
                local raw, id = resolve()
                if not id then return end
                local driveSeat = findDriveSeat(seat)
                if not driveSeat then
                    toast("Error","Pas de DriveSeat trouvé"); return
                end
                local name = "ac6_veh_"..driveSeat:GetFullName():gsub("[^%w]","_")
                if vehicleSounds[driveSeat] then stopNames({vehicleSounds[driveSeat]}) end
                fire(driveSeat, id, num(pitchInp.Text,1), num(volInp.Text,1), S.loop, name)
                vehicleSounds[driveSeat] = name
                toast("Vehicle","🚗 "..raw.." → "..driveSeat.Name)
            end)

            PB3.MouseButton1Click:Connect(function()
                if not seat then
                    toast("Warning", plr.DisplayName.." n'est pas dans un véhicule"); return
                end
                local raw, id = resolve()
                if not id then return end
                local bodySeat = findBodySeat(seat)
                if not bodySeat then
                    toast("Error","Pas de Body.Seat"); return
                end
                local name = "ac6_body_"..bodySeat:GetFullName():gsub("[^%w]","_")
                if vehicleSounds[bodySeat] then stopNames({vehicleSounds[bodySeat]}) end
                fire(bodySeat, id, num(pitchInp.Text,1), num(volInp.Text,1), S.loop, name)
                vehicleSounds[bodySeat] = name
                toast("Vehicle","🪑 "..raw.." → "..bodySeat.Name)
            end)

            SB.MouseButton1Click:Connect(function()
                local killed = false
                if seat then
                    local ds = findDriveSeat(seat)
                    local bs = findBodySeat(seat)
                    if ds and vehicleSounds[ds] then
                        stopNames({vehicleSounds[ds]})
                        vehicleSounds[ds] = nil
                        killed = true
                    end
                    if bs and vehicleSounds[bs] then
                        stopNames({vehicleSounds[bs]})
                        vehicleSounds[bs] = nil
                        killed = true
                    end
                end
                toast("Info", killed and ("Son arrêté sur "..plr.DisplayName) or "Rien à stopper")
            end)
        end
    end
end

RefreshBtn.MouseButton1Click:Connect(function()
    refreshVeh(); toast("Info","Liste actualisée")
end)
VehSearch:GetPropertyChangedSignal("Text"):Connect(function()
    refreshVeh()
end)

-- ═══════════ VUE ═══════════
local View = regTab("VUE", "Tab_Vue")

local vTitle = mk("TextLabel",{
    Name="Title",
    Size=UDim2.new(1,-170,0,26), BackgroundTransparency=1, Text="Vue Joueurs",
    TextColor3=C.Txt, Font=Enum.Font.GothamBlack, TextSize=20,
    TextXAlignment=Enum.TextXAlignment.Left, Parent=View})
reg(vTitle,"Text","Txt")
local vSub = mk("TextLabel",{
    Name="Sub",
    Size=UDim2.new(1,0,0,14), Position=UDim2.new(0,0,0,26),
    BackgroundTransparency=1, Text="📷 suivre  •  ✨ ESP  •  🎯 téléport",
    TextColor3=C.Sub, Font=Enum.Font.Gotham, TextSize=10,
    TextXAlignment=Enum.TextXAlignment.Left, Parent=View})
reg(vSub,"Text","Sub")

local UnspecBtn = mk("TextButton",{
    Name="Btn_BackToMe",
    Size=UDim2.new(0,150,0,30), Position=UDim2.new(1,-270,0,0),
    BackgroundColor3=C.Accent2, BorderSizePixel=0, Text="🔙  REVENIR À MOI",
    TextColor3=Color3.fromRGB(15,15,30), Font=Enum.Font.GothamBold,
    TextSize=10, AutoButtonColor=false, Parent=View})
crn(UnspecBtn,9); reg(UnspecBtn, "Bg", "Accent2")
UnspecBtn.MouseEnter:Connect(function() TweenService:Create(UnspecBtn,TweenInfo.new(.15),{BackgroundColor3=Color3.fromRGB(180,140,255)}):Play() end)
UnspecBtn.MouseLeave:Connect(function() TweenService:Create(UnspecBtn,TweenInfo.new(.15),{BackgroundColor3=C.Accent2}):Play() end)

UnspecBtn.MouseButton1Click:Connect(function()
    S.viewing = nil
    pcall(function()
        local hum = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
        Camera.CameraSubject = hum
        Camera.CameraType = Enum.CameraType.Custom
    end)
    toast("Info","Caméra : moi")
end)

local ViewSearchHolder = mk("Frame",{
    Name="SearchHolder",
    Size=UDim2.new(1,0,0,30), Position=UDim2.new(0,0,0,50),
    BackgroundColor3=C.Input, BorderSizePixel=0, Parent=View})
crn(ViewSearchHolder,8); strk(ViewSearchHolder, C.Stroke, 1, .5); reg(ViewSearchHolder, "Bg", "Input")
mk("TextLabel",{
    Size=UDim2.new(0,26,1,0), Position=UDim2.new(0,8,0,0),
    BackgroundTransparency=1, Text="🔍", TextColor3=C.Accent,
    Font=Enum.Font.GothamBold, TextSize=13, Parent=ViewSearchHolder})
local ViewSearch = mk("TextBox",{
    Name="SearchInput",
    Size=UDim2.new(1,-38,1,0), Position=UDim2.new(0,34,0,0),
    BackgroundTransparency=1, Text="",
    PlaceholderText="Rechercher un joueur...",
    PlaceholderColor3=C.Muted, TextColor3=C.Txt,
    Font=Enum.Font.Gotham, TextSize=12,
    TextXAlignment=Enum.TextXAlignment.Left,
    ClearTextOnFocus=false, Parent=ViewSearchHolder})
reg(ViewSearch, "Text", "Txt")

local ViewList = mk("ScrollingFrame",{
    Name="ViewList",
    Size=UDim2.new(1,0,1,-96), Position=UDim2.new(0,0,0,86),
    BackgroundColor3=C.Glass, BorderSizePixel=0,
    CanvasSize=UDim2.new(0,0,0,0), ScrollBarThickness=5,
    ScrollBarImageColor3=C.Accent2, Parent=View})
crn(ViewList,12); strk(ViewList, C.Stroke, 1, .5); reg(ViewList, "Bg", "Glass")
local VwL = mk("UIListLayout",{Padding=UDim.new(0,5),Parent=ViewList})
mk("UIPadding",{PaddingTop=UDim.new(0,7),PaddingBottom=UDim.new(0,7),PaddingLeft=UDim.new(0,7),PaddingRight=UDim.new(0,7)},ViewList)
VwL:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    ViewList.CanvasSize = UDim2.new(0,0,0, VwL.AbsoluteContentSize.Y + 14)
end)

local playerWidgets = {}

local function actionBtn(parent, x, icon, labelText, colKey, btnName)
    local base = C[colKey]
    local holder = mk("Frame",{
        Name=btnName or "ActionBtn",
        Size=UDim2.new(0,50,0,50), Position=UDim2.new(1,x,0,5),
        BackgroundColor3=base, BorderSizePixel=0, Parent=parent})
    crn(holder,11); reg(holder, "Bg", colKey)
    mk("TextLabel",{
        Size=UDim2.new(1,0,0,26), Position=UDim2.new(0,0,0,4),
        BackgroundTransparency=1, Text=icon,
        TextColor3=Color3.fromRGB(15,20,35),
        Font=Enum.Font.GothamBold, TextSize=16, Parent=holder})
    mk("TextLabel",{
        Size=UDim2.new(1,0,0,12), Position=UDim2.new(0,0,0,31),
        BackgroundTransparency=1, Text=labelText,
        TextColor3=Color3.fromRGB(15,20,35),
        Font=Enum.Font.GothamBold, TextSize=8, Parent=holder})
    local btn = mk("TextButton",{
        Size=UDim2.new(1,0,1,0), BackgroundTransparency=1,
        Text="", Parent=holder})
    holder.MouseEnter:Connect(function()
        TweenService:Create(holder,TweenInfo.new(.15),{BackgroundColor3=Color3.new(math.min(1,C[colKey].R+0.15), math.min(1,C[colKey].G+0.15), math.min(1,C[colKey].B+0.15))}):Play()
    end)
    holder.MouseLeave:Connect(function()
        TweenService:Create(holder,TweenInfo.new(.15),{BackgroundColor3=C[colKey]}):Play()
    end)
    return btn
end

local function refreshView()
    for _,c2 in ipairs(ViewList:GetChildren()) do
        if c2:IsA("Frame") then c2:Destroy() end
    end
    playerWidgets = {}
    local filter = string.lower(ViewSearch.Text)
    for _, plr in ipairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer then
            local match = (filter == "") or string.find(string.lower(plr.DisplayName), filter, 1, true) or
                           string.find(string.lower(plr.Name), filter, 1, true)
            if match then
                local row = mk("Frame",{
                    Name="Row_"..plr.Name,
                    Size=UDim2.new(1,-14,0,58), BackgroundColor3=C.Glass,
                    BorderSizePixel=0, Parent=ViewList})
                crn(row,10); strk(row, C.Stroke, 1, .5); reg(row, "Bg", "Glass")

                local av = mk("Frame",{
                    Name="Avatar",
                    Size=UDim2.new(0,38,0,38), Position=UDim2.new(0,10,0,10),
                    BackgroundColor3=C.Accent2, BorderSizePixel=0, Parent=row})
                crn(av,10); local avg = grad(av, C.Accent2, C.Accent, 45)
                reg(av, "Bg", "Accent2"); reg(avg, "Grad", "Accent2Grad")
                mk("TextLabel",{
                    Size=UDim2.new(1,0,1,0), BackgroundTransparency=1,
                    Text=string.sub(plr.DisplayName,1,1):upper(),
                    TextColor3=Color3.new(1,1,1), Font=Enum.Font.GothamBlack,
                    TextSize=15, Parent=av})

                local nL = mk("TextLabel",{
                    Name="Name",
                    Size=UDim2.new(0,200,0,16), Position=UDim2.new(0,58,0,8),
                    BackgroundTransparency=1, Text=plr.DisplayName,
                    TextColor3=C.Txt, Font=Enum.Font.GothamBold, TextSize=12,
                    TextXAlignment=Enum.TextXAlignment.Left, Parent=row})
                reg(nL,"Text","Txt")
                local hpLbl = mk("TextLabel",{
                    Name="HP",
                    Size=UDim2.new(0,200,0,13), Position=UDim2.new(0,58,0,26),
                    BackgroundTransparency=1, Text="❤  --",
                    TextColor3=C.Green, Font=Enum.Font.Gotham, TextSize=10,
                    TextXAlignment=Enum.TextXAlignment.Left, Parent=row})
                reg(hpLbl, "Text", "Green")
                local distLbl = mk("TextLabel",{
                    Name="Dist",
                    Size=UDim2.new(0,200,0,13), Position=UDim2.new(0,58,0,39),
                    BackgroundTransparency=1, Text="📍 -- studs",
                    TextColor3=C.Sub, Font=Enum.Font.Gotham, TextSize=9,
                    TextXAlignment=Enum.TextXAlignment.Left, Parent=row})
                reg(distLbl, "Text", "Sub")

                local FollowBtn = actionBtn(row, -172, "📷", "SUIVRE", "Accent", "Btn_Follow")
                FollowBtn.MouseButton1Click:Connect(function()
                    S.viewing = plr
                    pcall(function()
                        local hum = plr.Character and plr.Character:FindFirstChildOfClass("Humanoid")
                        if hum then
                            Camera.CameraSubject = hum
                            Camera.CameraType = Enum.CameraType.Custom
                        end
                    end)
                    toast("Info","📷 Suivi : "..plr.DisplayName)
                end)

                local HLBtn = actionBtn(row, -118, "✨", "ESP", "Accent2", "Btn_ESP")
                HLBtn.MouseButton1Click:Connect(function()
                    local ch = plr.Character
                    if not ch then toast("Warning","Pas de perso"); return end
                    if highlights[plr] and highlights[plr].Parent then
                        highlights[plr]:Destroy(); highlights[plr] = nil
                        toast("Info","ESP off : "..plr.DisplayName)
                    else
                        local hl = Instance.new("Highlight")
                        hl.Name = "AC6_HL"; hl.Adornee = ch
                        hl.FillColor = C.Accent2; hl.FillTransparency = .55
                        hl.OutlineColor = Color3.fromRGB(255,255,255)
                        hl.OutlineTransparency = 0
                        hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
                        hl.Parent = ch
                        highlights[plr] = hl
                        toast("Success","ESP on : "..plr.DisplayName)
                    end
                end)

                local TPBtn = actionBtn(row, -64, "🎯", "TP", "Green", "Btn_TP")
                TPBtn.MouseButton1Click:Connect(function()
                    local myRoot = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                    local target = plr.Character and plr.Character:FindFirstChild("HumanoidRootPart")
                    if not myRoot then toast("Error","Pas de perso"); return end
                    if not target then toast("Warning","Cible sans perso"); return end
                    myRoot.CFrame = target.CFrame * CFrame.new(0, 0, 3)
                    toast("Success","🎯 TP sur "..plr.DisplayName)
                end)

                playerWidgets[plr] = {row=row, hp=hpLbl, dist=distLbl}
            end
        end
    end
end

ViewSearch:GetPropertyChangedSignal("Text"):Connect(function()
    refreshView()
end)

task.spawn(function()
    while GUI.Parent do
        task.wait(1)
        if View.Visible then
            local myRoot = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
            local myPos = myRoot and myRoot.Position
            for plr, w in pairs(playerWidgets) do
                if plr.Parent == nil then
                    if w.row.Parent then w.row:Destroy() end
                    playerWidgets[plr] = nil
                else
                    local ch = plr.Character
                    local hum = ch and ch:FindFirstChildOfClass("Humanoid")
                    if hum then
                        w.hp.Text = "❤  "..math.floor(hum.Health).." / "..math.floor(hum.MaxHealth)
                        w.hp.TextColor3 = hum.Health > hum.MaxHealth*0.5 and C.Green or C.Red
                    else
                        w.hp.Text = "❤  --"
                    end
                    local rp = ch and ch:FindFirstChild("HumanoidRootPart")
                    if rp and myPos then
                        w.dist.Text = ("📍 %.0f studs"):format((rp.Position-myPos).Magnitude)
                    else
                        w.dist.Text = "📍 --"
                    end
                end
            end
            if S.viewing and S.viewing.Character then
                local hum = S.viewing.Character:FindFirstChildOfClass("Humanoid")
                if hum and Camera.CameraSubject ~= hum then
                    pcall(function()
                        Camera.CameraSubject = hum
                        Camera.CameraType = Enum.CameraType.Custom
                    end)
                end
            end
        end
    end
end)

-- ═══════════ CHAOS ═══════════
local Chaos = regTab("CHAOS", "Tab_Chaos")

local cTitle = mk("TextLabel",{
    Name="Title",
    Size=UDim2.new(1,0,0,26), BackgroundTransparency=1, Text="Mode Chaos",
    TextColor3=C.Txt, Font=Enum.Font.GothamBlack, TextSize=20,
    TextXAlignment=Enum.TextXAlignment.Left, Parent=Chaos})
reg(cTitle,"Text","Txt")
local cSub = mk("TextLabel",{
    Name="Sub",
    Size=UDim2.new(1,0,0,14), Position=UDim2.new(0,0,0,26),
    BackgroundTransparency=1, Text="⚠ Effets extrêmes — à utiliser avec parcimonie",
    TextColor3=C.Orange, Font=Enum.Font.Gotham, TextSize=10,
    TextXAlignment=Enum.TextXAlignment.Left, Parent=Chaos})
reg(cSub,"Text","Orange")

local chaosStates = { spam=false, pitchB=false }

local function mkChaosCard(title, desc, y, colKey, emoji, name)
    local base = C[colKey]
    local card = mk("Frame",{
        Name=name or "ChaosCard",
        Size=UDim2.new(1,0,0,76), Position=UDim2.new(0,0,0,y),
        BackgroundColor3=C.Glass, BorderSizePixel=0, Parent=Chaos})
    crn(card,12); strk(card, C.Stroke, 1, .5); reg(card, "Bg", "Glass")

    local dot = mk("Frame",{
        Size=UDim2.new(0,4,1,-20), Position=UDim2.new(0,0,0,10),
        BackgroundColor3=base, BorderSizePixel=0, Parent=card})
    crn(dot,2); reg(dot, "Bg", colKey)

    local ico = mk("Frame",{
        Size=UDim2.new(0,40,0,40), Position=UDim2.new(0,14,0,18),
        BackgroundColor3=base, BorderSizePixel=0, Parent=card})
    crn(ico,11); reg(ico, "Bg", colKey)
    mk("TextLabel",{Size=UDim2.new(1,0,1,0),BackgroundTransparency=1,
        Text=emoji,TextColor3=Color3.fromRGB(15,20,35),
        Font=Enum.Font.GothamBold,TextSize=18,Parent=ico})

    local tL = mk("TextLabel",{
        Size=UDim2.new(1,-200,0,16), Position=UDim2.new(0,64,0,10),
        BackgroundTransparency=1, Text=title, TextColor3=C.Txt,
        Font=Enum.Font.GothamBold, TextSize=12,
        TextXAlignment=Enum.TextXAlignment.Left, Parent=card})
    reg(tL,"Text","Txt")
    local dL = mk("TextLabel",{
        Size=UDim2.new(1,-200,0,30), Position=UDim2.new(0,64,0,28),
        BackgroundTransparency=1, Text=desc, TextColor3=C.Sub,
        Font=Enum.Font.Gotham, TextSize=9, TextWrapped=true,
        TextXAlignment=Enum.TextXAlignment.Left,
        TextYAlignment=Enum.TextYAlignment.Top, Parent=card})
    reg(dL,"Text","Sub")
    local btn = mk("TextButton",{
        Name="Btn_"..(name or "Action"),
        Size=UDim2.new(0,110,0,30), Position=UDim2.new(1,-124,0,23),
        BackgroundColor3=base, BorderSizePixel=0, Text="ACTIVER",
        TextColor3=Color3.fromRGB(15,20,35), Font=Enum.Font.GothamBold,
        TextSize=11, AutoButtonColor=false, Parent=card})
    crn(btn,9); reg(btn, "Bg", colKey)
    return btn, colKey
end

local spamBtn, spamKey = mkChaosCard("Spam Sonore",
    "Envoie 20 sons superposés sur toi.",
    48, "Orange", "🔊", "SpamCard")
spamKey = "Orange"
spamBtn.MouseButton1Click:Connect(function()
    chaosStates.spam = not chaosStates.spam
    spamBtn.Text = chaosStates.spam and "STOP" or "ACTIVER"
    spamBtn.BackgroundColor3 = chaosStates.spam and C.Red or C[spamKey]
    if not chaosStates.spam then
        for i=1,20 do stopNames({"ac6_spam_"..i}) end
        return
    end
    local raw = idInp.Text
    local id = musicDatabase[string.lower(raw)] or fmtId(raw)
    if not id then
        chaosStates.spam = false
        spamBtn.Text = "ACTIVER"; spamBtn.BackgroundColor3 = C[spamKey]
        toast("Warning","Mets un ID"); return
    end
    local ch = LocalPlayer.Character
    local t = ch and ch:FindFirstChild("HumanoidRootPart")
    if not t then return end
    task.spawn(function()
        for i=1,20 do
            if not chaosStates.spam then break end
            fire(t, id, 1+i*0.05, 0.3, false, "ac6_spam_"..i)
            task.wait(0.03)
        end
    end)
    toast("Warning","🔊 Spam sonore lancé")
end)

local earBtn = mkChaosCard("Earrape",
    "Volume x100 sur tout le serveur.",
    132, "Red", "💥", "EarCard")
earBtn.MouseButton1Click:Connect(function()
    local raw = idInp.Text
    local id = musicDatabase[string.lower(raw)] or fmtId(raw)
    if not id then toast("Warning","Mets un ID"); return end
    fire(Workspace, id, 1, 100, false, "ac6_ear")
    toast("Error","💥 Earrape envoyé !")
    task.delay(3,function() stopNames({"ac6_ear"}) end)
end)

local pitchCBtn, pitchKey = mkChaosCard("Pitch Chaos",
    "Change le pitch aléatoirement toutes les 0.2s.",
    216, "Pink", "🌀", "PitchCard")
pitchKey = "Pink"
pitchCBtn.MouseButton1Click:Connect(function()
    chaosStates.pitchB = not chaosStates.pitchB
    pitchCBtn.Text = chaosStates.pitchB and "STOP" or "ACTIVER"
    pitchCBtn.BackgroundColor3 = chaosStates.pitchB and C.Red or C[pitchKey]
    if not chaosStates.pitchB then
        stopNames({"ac6_chaos_p"}); return
    end
    local raw = idInp.Text
    local id = musicDatabase[string.lower(raw)] or fmtId(raw)
    if not id then
        chaosStates.pitchB = false
        pitchCBtn.Text = "ACTIVER"; pitchCBtn.BackgroundColor3 = C[pitchKey]
        toast("Warning","Mets un ID"); return
    end
    local ch = LocalPlayer.Character
    local t = ch and ch:FindFirstChild("HumanoidRootPart")
    if not t then return end
    task.spawn(function()
        while chaosStates.pitchB do
            stopNames({"ac6_chaos_p"})
            fire(t, id, 0.5+math.random()*2, 1, false, "ac6_chaos_p")
            task.wait(0.2)
        end
    end)
    toast("Warning","🌀 Pitch chaos ON")
end)

local killBtn = mkChaosCard("Kill All",
    "Stoppe instantanément TOUS les sons de l'exploit.",
    300, "Accent", "🛑", "KillCard")
killBtn.Text = "KILL"
killBtn.MouseButton1Click:Connect(function()
    chaosStates.spam = false
    chaosStates.pitchB = false
    spamBtn.Text = "ACTIVER"; spamBtn.BackgroundColor3 = C[spamKey]
    pitchCBtn.Text = "ACTIVER"; pitchCBtn.BackgroundColor3 = C[pitchKey]
    local l = {}
    for n in pairs(activeSounds) do table.insert(l, n) end
    for i=1,20 do table.insert(l, "ac6_spam_"..i) end
    table.insert(l,"ac6_chaos_p"); table.insert(l,"ac6_ear")
    stopNames(l)
    activeSounds = {}; vehicleSounds = {}
    toast("Success","🛑 Tous les sons arrêtés")
end)

-- ═══════════ FUN ═══════════
local Fun = regTab("FUN", "Tab_Fun")

local funTitle = mk("TextLabel",{
    Name="Title",
    Size=UDim2.new(1,0,0,26), BackgroundTransparency=1, Text="FUN",
    TextColor3=C.Txt, Font=Enum.Font.GothamBlack, TextSize=20,
    TextXAlignment=Enum.TextXAlignment.Left, Parent=Fun})
reg(funTitle,"Text","Txt")
local funSub = mk("TextLabel",{
    Name="Sub",
    Size=UDim2.new(1,0,0,14), Position=UDim2.new(0,0,0,26),
    BackgroundTransparency=1, Text="Téléports, clés, delivery",
    TextColor3=C.Sub, Font=Enum.Font.Gotham, TextSize=10,
    TextXAlignment=Enum.TextXAlignment.Left, Parent=Fun})
reg(funSub,"Text","Sub")

local FunScroll = mk("ScrollingFrame",{
    Name="FunScroll",
    Size=UDim2.new(1,0,1,-46), Position=UDim2.new(0,0,0,46),
    BackgroundTransparency=1, BorderSizePixel=0,
    CanvasSize=UDim2.new(0,0,0,0), ScrollBarThickness=5,
    ScrollBarImageColor3=C.Pink, Parent=Fun})
local FunLayout = mk("UIListLayout",{Padding=UDim.new(0,10),Parent=FunScroll})

local function funSection(title, name)
    local f = mk("Frame",{
        Name=name or "Section",
        Size=UDim2.new(1,-10,0,0), BackgroundTransparency=1,
        Parent=FunScroll, AutomaticSize=Enum.AutomaticSize.Y})
    mk("UIListLayout",{Padding=UDim.new(0,5),Parent=f})
    local tL = mk("TextLabel",{
        Size=UDim2.new(1,0,0,20), BackgroundTransparency=1, Text=title,
        TextColor3=C.Accent, Font=Enum.Font.GothamBlack, TextSize=13,
        TextXAlignment=Enum.TextXAlignment.Left, Parent=f})
    reg(tL,"Text","Accent")
    return f
end

local function funBtn(parent, label, colKey, callback, emoji)
    local base = C[colKey]
    local b = mk("TextButton",{
        Name="Btn_"..label:gsub("%s","_"),
        Size=UDim2.new(1,0,0,34),
        BackgroundColor3=base, BorderSizePixel=0,
        Text=(emoji or "").."  "..label,
        TextColor3=Color3.fromRGB(15,20,35), Font=Enum.Font.GothamBold,
        TextSize=12, AutoButtonColor=false, Parent=parent})
    crn(b,9)
    reg(b, "Bg", colKey)
    b.MouseEnter:Connect(function() TweenService:Create(b,TweenInfo.new(.15),{BackgroundColor3=Color3.new(math.min(1,base.R+0.15),math.min(1,base.G+0.15),math.min(1,base.B+0.15))}):Play() end)
    b.MouseLeave:Connect(function() TweenService:Create(b,TweenInfo.new(.15),{BackgroundColor3=C[colKey]}):Play() end)
    b.MouseButton1Click:Connect(callback)
    return b
end

local function tpTo(x, y, z, label)
    local ch = LocalPlayer.Character
    local hrp = ch and ch:FindFirstChild("HumanoidRootPart")
    if hrp then
        hrp.CFrame = CFrame.new(x, y, z)
        toast("Success","📍 "..label)
    end
end

-- ═══ SECTION 1 : 🚗 TÉLÉPORTS ═══
local secTP = funSection("🚗 TÉLÉPORTS", "Sec_TP")
funBtn(secTP, "Secret Car #2 (LangAo)", "Pink", function() tpTo(11769, 2, -14427, "Secret Car 2") end, "🚗")
funBtn(secTP, "Secret Car #3 (Hiace)", "Pink", function() tpTo(11557, 8, -14295, "Secret Car 3") end, "🚗")
funBtn(secTP, "Chicken", "Orange", function() tpTo(11180, 3, -10451, "Chicken") end, "🐔")
funBtn(secTP, "2021 Icia Soluto", "Accent3", function() tpTo(-5294, -3, 15021, "2021 Icia Soluto") end, "🚗")
funBtn(secTP, "Sunburst Rusty", "Orange", function() tpTo(4161, 1, -8063, "Sunburst Rusty") end, "🚗")
funBtn(secTP, "Xmas 2024", "Red", function() tpTo(12316, -3, -5258, "Xmas 2024") end, "🎄")
funBtn(secTP, "Sus", "Orange", function() tpTo(1013, 3, -978, "Sus") end, "❓")
funBtn(secTP, "Spawn", "Accent", function() tpTo(74, 27, -2140, "Spawn") end, "🏠")

-- ═══ SECTION 2 : 🔑 CLÉS ═══
local secKeys = funSection("🔑 CLÉS", "Sec_Keys")

local keyWatchActive = false
local function checkKeyState()
    local part = Workspace:FindFirstChild("Key")
    if part then part = part:FindFirstChild("Handle") end
    return part ~= nil
end

funBtn(secKeys, "Get Key", "Green", function()
    local part = Workspace:FindFirstChild("Key")
    if part then part = part:FindFirstChild("Handle") end
    local ch = LocalPlayer.Character
    local hrp = ch and ch:FindFirstChild("HumanoidRootPart")
    if part and hrp then
        pcall(function()
            firetouchinterest(part, hrp, 0)
            task.wait()
            firetouchinterest(part, hrp, 1)
        end)
        toast("Success","🔑 Clé récupérée")
    else
        toast("Warning","Clé pas dispo (regen en cours)")
    end
end, "📦")

local watchBtn
watchBtn = funBtn(secKeys, "Surveiller la clé (OFF)", "Accent", function()
    keyWatchActive = not keyWatchActive
    if keyWatchActive then
        watchBtn.Text = "👀  Surveiller la clé (ON)"
        watchBtn.BackgroundColor3 = C.Green
        toast("Info","👀 Surveillance activée")
        task.spawn(function()
            local last = checkKeyState()
            while keyWatchActive and GUI.Parent do
                task.wait(0.5)
                local now = checkKeyState()
                if now and not last then
                    toast("Success","🔑 CLÉ REGÉNÉRÉE !")
                end
                last = now
            end
        end)
    else
        watchBtn.Text = "👀  Surveiller la clé (OFF)"
        watchBtn.BackgroundColor3 = C.Accent
        toast("Info","👀 Surveillance désactivée")
    end
end, "👀")

funBtn(secKeys, "Drop Keys (simul. DELETE)", "Red", function()
    local ch = LocalPlayer.Character
    local hrp = ch and ch:FindFirstChild("HumanoidRootPart")
    if not hrp then toast("Error","Pas de perso"); return end
    hrp.CFrame = CFrame.new(74, 27, -2140)
    toast("Info","📍 TP au spawn...")
    task.wait(0.4)
    if not VirtualInput then
        toast("Error","VirtualInputManager pas dispo")
        return
    end
    local count = 0
    local backpack = LocalPlayer:FindFirstChild("Backpack")
    local char = LocalPlayer.Character

    local function tryDrop(tool)
        if not tool:IsA("Tool") then return end
        local hum = char and char:FindFirstChildOfClass("Humanoid")
        if hum then
            hum:EquipTool(tool)
            task.wait(0.1)
        end
        pcall(function()
            VirtualInput:SendKeyEvent(true, Enum.KeyCode.Delete, false, game)
            task.wait(0.05)
            VirtualInput:SendKeyEvent(false, Enum.KeyCode.Delete, false, game)
        end)
        count = count + 1
        task.wait(0.15)
    end

    if backpack then
        for _, tool in ipairs(backpack:GetChildren()) do
            if tool:IsA("Tool") then tryDrop(tool) end
        end
    end
    if char then
        for _, tool in ipairs(char:GetChildren()) do
            if tool:IsA("Tool") then tryDrop(tool) end
        end
    end

    if count > 0 then
        toast("Success","📦 "..count.." clé(s) droppée(s) via DELETE")
    else
        toast("Warning","📦 Aucune clé à dropper")
    end
end, "📦")

funBtn(secKeys, "Drop Keys (forcé)", "Orange", function()
    local ch = LocalPlayer.Character
    local hrp = ch and ch:FindFirstChild("HumanoidRootPart")
    if not hrp then toast("Error","Pas de perso"); return end
    hrp.CFrame = CFrame.new(74, 27, -2140)
    toast("Info","📍 TP au spawn...")
    task.wait(0.4)
    local count = 0
    local bp = LocalPlayer:FindFirstChild("Backpack")
    local char = LocalPlayer.Character
    if bp then
        for _, tool in ipairs(bp:GetChildren()) do
            if tool:IsA("Tool") then
                tool.Parent = workspace
                count = count + 1
            end
        end
    end
    if char then
        for _, tool in ipairs(char:GetChildren()) do
            if tool:IsA("Tool") then
                tool.Parent = workspace
                count = count + 1
            end
        end
    end
    if count > 0 then
        toast("Success","📦 "..count.." clé(s) droppée(s) (forcé)")
    else
        toast("Warning","📦 Aucune clé à dropper")
    end
end, "📦")

-- ═══ SECTION 3 : 🛠️ OUTILS ═══
local secOutils = funSection("🛠️ OUTILS", "Sec_Outils")

funBtn(secOutils, "Delete KL Block", "Red", function()
    local klb = Workspace:FindFirstChild("KL Block")
    if not klb then
        toast("Error","KL Block introuvable")
        return
    end
    local count = 0
    for _, child in ipairs(klb:GetDescendants()) do
        if child:IsA("BasePart") then
            pcall(function()
                child.CanTouch = false
                child.CanCollide = false
                child.Transparency = 1
                count = count + 1
            end)
        end
    end
    toast("Success","🗑️ "..count.." KL Block désactivé(s)")
end, "🗑️")

funBtn(secOutils, "Multi-Color Vehicle", "Accent2", function()
    local remote = ReplicatedStorage:FindFirstChild("ApplyVehiclePaint")
    if remote and remote:IsA("RemoteEvent") then
        task.spawn(function()
            for i = 1, 10 do
                local r = math.random() * 255
                local g = math.random() * 255
                local b = math.random() * 255
                pcall(function()
                    remote:FireServer(Color3.fromRGB(r, g, b))
                end)
                task.wait(0.3)
            end
        end)
        toast("Success","🎨 Multi-color lancé")
    else
        toast("Error","ApplyVehiclePaint introuvable")
    end
end, "🎨")

-- ═══ SECTION 4 : 💰 AUTO MONEY / AUTO COIN ═══
local MONEY_ZONES = {
    {
        name = "TP THU DUC",
        path = {"base","TP THU DUC","BXMD","Dirt"},
        indices = {14, 12, 11, 10, 9, 8, 13},
        named = {"Respawning Coin"},
        tpPos = nil,
    },
    {
        name = "Petro Vinmart",
        path = {"Petro","vinmart","vin"},
        indices = {22, 21, 25, 24, 18},
        named = {"Respawning Coin"},
        tpPos = Vector3.new(-5398, -5, 7308),
    },
}

local function resolvePath(root, path)
    local cur = root
    for _, k in ipairs(path) do
        cur = cur and cur:FindFirstChild(k)
        if not cur then return nil end
    end
    return cur
end

local function getMoneyParts(zone)
    local container = resolvePath(Workspace, zone.path)
    if not container then return {} end

    local parts = {}
    local kids = container:GetChildren()
    for _, idx in ipairs(zone.indices) do
        local p = kids[idx]
        if p and p:IsA("BasePart") then table.insert(parts, p) end
    end
    for _, nm in ipairs(zone.named) do
        local p = container:FindFirstChild(nm)
        if p and p:IsA("BasePart") then table.insert(parts, p) end
    end
    return parts
end

local function touchAllMoney(zone)
    local ch = LocalPlayer.Character
    local hrp = ch and ch:FindFirstChild("HumanoidRootPart")
    if not hrp then return 0 end

    if zone.tpPos then
        hrp.CFrame = CFrame.new(zone.tpPos)
        task.wait(0.25)
    end

    local parts = getMoneyParts(zone)
    local n = 0
    for _, part in ipairs(parts) do
        pcall(function()
            firetouchinterest(part, hrp, 0)
            task.wait()
            firetouchinterest(part, hrp, 1)
        end)
        n = n + 1
        task.wait(0.05)
    end
    return n
end

funBtn(secOutils, "Auto Money (1x - toutes zones)", "Green", function()
    local total = 0
    for _, zone in ipairs(MONEY_ZONES) do
        total = total + touchAllMoney(zone)
        task.wait(0.3)
    end
    if total > 0 then
        toast("Success","💰 "..total.." pièce(s) touchée(s)")
    else
        toast("Warning","💰 Aucune pièce trouvée")
    end
end, "💰")

funBtn(secOutils, "Auto Money TP THU DUC", "Accent", function()
    local n = touchAllMoney(MONEY_ZONES[1])
    toast(n > 0 and "Success" or "Warning", "💰 "..n.." pièce(s) (TP THU DUC)")
end, "💰")

funBtn(secOutils, "Auto Coin Petro Vinmart", "Accent2", function()
    local n = touchAllMoney(MONEY_ZONES[2])
    toast(n > 0 and "Success" or "Warning", "💰 "..n.." pièce(s) (Petro)")
end, "💰")

local autoCoinActive = false
local autoCoinBtn
autoCoinBtn = funBtn(secOutils, "Auto Coin (loop OFF)", "Accent3", function()
    autoCoinActive = not autoCoinActive
    if autoCoinActive then
        autoCoinBtn.Text = "💰  Auto Coin (loop ON)"
        autoCoinBtn.BackgroundColor3 = C.Red
        toast("Info","💰 Auto Coin activé (TP + touch en boucle)")
        task.spawn(function()
            while autoCoinActive and GUI.Parent do
                for _, zone in ipairs(MONEY_ZONES) do
                    if not autoCoinActive then break end
                    touchAllMoney(zone)
                    task.wait(0.5)
                end
                task.wait(1)
            end
        end)
    else
        autoCoinBtn.Text = "💰  Auto Coin (loop OFF)"
        autoCoinBtn.BackgroundColor3 = C.Accent3
        toast("Info","💰 Auto Coin désactivé")
    end
end, "💰")

funBtn(secOutils, "Retour Spawn", "Orange", function()
    local ch = LocalPlayer.Character
    local hrp = ch and ch:FindFirstChild("HumanoidRootPart")
    if hrp then
        hrp.CFrame = CFrame.new(74, 27, -2140)
        toast("Success","🏠 Retour au spawn")
    end
end, "🏠")

task.spawn(function()
    while GUI.Parent do
        task.wait(0.3)
        FunScroll.CanvasSize = UDim2.new(0,0,0, FunLayout.AbsoluteContentSize.Y + 20)
    end
end)

-- ═══════════ DELIVERY (onglet dédié) ═══════════
local DelTab = regTab("DELIVERY", "Tab_Delivery")

local dTitle = mk("TextLabel",{
    Name="Title",
    Size=UDim2.new(1,0,0,26), BackgroundTransparency=1, Text="📦 Delivery System",
    TextColor3=C.Txt, Font=Enum.Font.GothamBlack, TextSize=20,
    TextXAlignment=Enum.TextXAlignment.Left, Parent=DelTab})
reg(dTitle,"Text","Txt")
local dSub = mk("TextLabel",{
    Name="Sub",
    Size=UDim2.new(1,0,0,14), Position=UDim2.new(0,0,0,26),
    BackgroundTransparency=1, Text="Récupère le colis, livre au DropOff. Guide + TP + Prompt auto.",
    TextColor3=C.Sub, Font=Enum.Font.Gotham, TextSize=10,
    TextXAlignment=Enum.TextXAlignment.Left, Parent=DelTab})
reg(dSub,"Text","Sub")

-- Scroll principal
local DelScroll = mk("ScrollingFrame",{
    Name="DelScroll",
    Size=UDim2.new(1,0,1,-46), Position=UDim2.new(0,0,0,46),
    BackgroundTransparency=1, BorderSizePixel=0,
    CanvasSize=UDim2.new(0,0,0,0), ScrollBarThickness=5,
    ScrollBarImageColor3=C.Accent3, Parent=DelTab})
local DelLayout = mk("UIListLayout",{Padding=UDim.new(0,10),Parent=DelScroll})

local function delSection(title, name)
    local f = mk("Frame",{
        Name=name or "DelSection",
        Size=UDim2.new(1,-10,0,0), BackgroundTransparency=1,
        Parent=DelScroll, AutomaticSize=Enum.AutomaticSize.Y})
    mk("UIListLayout",{Padding=UDim.new(0,5),Parent=f})
    local tL = mk("TextLabel",{
        Size=UDim2.new(1,0,0,20), BackgroundTransparency=1, Text=title,
        TextColor3=C.Accent3, Font=Enum.Font.GothamBlack, TextSize=13,
        TextXAlignment=Enum.TextXAlignment.Left, Parent=f})
    reg(tL,"Text","Accent3")
    return f
end

local function delBtn(parent, label, colKey, callback, emoji)
    local base = C[colKey]
    local b = mk("TextButton",{
        Name="Btn_"..label:gsub("[^%w]","_"),
        Size=UDim2.new(1,0,0,34),
        BackgroundColor3=base, BorderSizePixel=0,
        Text=(emoji or "").."  "..label,
        TextColor3=Color3.fromRGB(15,20,35), Font=Enum.Font.GothamBold,
        TextSize=12, AutoButtonColor=false, Parent=parent})
    crn(b,9)
    reg(b, "Bg", colKey)

    -- 🎨 Flag : si true, les handlers hover ne touchent à rien
    b:SetAttribute("OverrideColor", false)

    b.MouseEnter:Connect(function()
        if b:GetAttribute("OverrideColor") then return end   -- ✅ respecte le flag
        TweenService:Create(b,TweenInfo.new(.15),{BackgroundColor3=Color3.new(
            math.min(1,base.R+0.15),
            math.min(1,base.G+0.15),
            math.min(1,base.B+0.15)
        )}):Play()
    end)
    b.MouseLeave:Connect(function()
        if b:GetAttribute("OverrideColor") then return end   -- ✅ respecte le flag
        TweenService:Create(b,TweenInfo.new(.15),{BackgroundColor3=C[colKey]}):Play()
    end)
    b.MouseButton1Click:Connect(callback)
    return b
end
-- ─── Helpers ───
local function getDeliverySystem()
    return Workspace:FindFirstChild("Delivery System")
end

local function findDropOff(namePattern)
    local ds = getDeliverySystem()
    if not ds then return nil end
    for _, c2 in ipairs(ds:GetChildren()) do
        if c2.Name:match(namePattern) then return c2 end
    end
    return nil
end

local function findPrompt(obj)
    if not obj then return nil end
    if obj:IsA("ProximityPrompt") and obj.Enabled then return obj end
    for _, d in ipairs(obj:GetDescendants()) do
        if d:IsA("ProximityPrompt") and d.Enabled then return d end
    end
    return nil
end

-- TP + trigger prompt avec fallback touche E
local function tpAndPrompt(target, label, waitAfter)
    local ch = LocalPlayer.Character
    local hrp = ch and ch:FindFirstChild("HumanoidRootPart")
    if not hrp then toast("Error","Pas de perso"); return false end
    if not target then toast("Error","Cible introuvable"); return false end

    local pos = target.Position or target.CFrame.Position
    hrp.CFrame = CFrame.new(pos + Vector3.new(0, 3, 0))

    task.wait(waitAfter or 0.4)

    local prompt = findPrompt(target)
    if not prompt then
        local ds = getDeliverySystem()
        if ds then prompt = findPrompt(ds) end
    end

    if not prompt then
        toast("Warning","🎯 "..label.." (pas de prompt)")
        return false
    end

    pcall(function()
        prompt:InputHoldBegin()
        task.wait(math.max(0.05, prompt.HoldDuration or 0.05))
        prompt:InputHoldEnd()
    end)

    task.wait(0.1)
    if VirtualInput then
        pcall(function()
            VirtualInput:SendKeyEvent(true, Enum.KeyCode.E, false, game)
            task.wait(0.1)
            VirtualInput:SendKeyEvent(false, Enum.KeyCode.E, false, game)
        end)
    end

    toast("Success","🎯 "..label.." → prompt")
    return true
end

-- Guide beam
local function deliveryBeam(pos, label)
    pcall(function()
        local ch = LocalPlayer.Character
        local hrp = ch and ch:FindFirstChild("HumanoidRootPart")
        if not hrp then return end
        if _G.AC6_DeliveryBeam then _G.AC6_DeliveryBeam:Destroy() end
        local old = Workspace:FindFirstChild("AC6_DeliveryTarget")
        if old then old:Destroy() end
        if _G.AC6_DeliveryAttach0 then _G.AC6_DeliveryAttach0:Destroy() end
        if _G.AC6_DeliveryAttach1 then _G.AC6_DeliveryAttach1:Destroy() end

        local fake = Instance.new("Part")
        fake.Name = "AC6_DeliveryTarget"
        fake.Position = pos
        fake.Anchored = true
        fake.CanCollide = false
        fake.CanTouch = false
        fake.Transparency = 1
        fake.Parent = Workspace

        local a0 = Instance.new("Attachment", hrp)
        local a1 = Instance.new("Attachment", fake)
        local beam = Instance.new("Beam")
        beam.Attachment0 = a0
        beam.Attachment1 = a1
        beam.Width0 = 1; beam.Width1 = 1
        beam.Color = ColorSequence.new(Color3.fromRGB(0, 255, 255))
        beam.LightEmission = 1
        beam.FaceCamera = true
        beam.ZOffset = 1
        beam.Parent = ch

        _G.AC6_DeliveryBeam = beam
        _G.AC6_DeliveryAttach0 = a0
        _G.AC6_DeliveryAttach1 = a1
        toast("Success","📦 Guide → "..label)
    end)
end

-- ═══ SECTION 1 : ÉTAPE 1 — RÉCUPÉRER LE COLIS ═══
local secStep1 = delSection("① RÉCUPÉRER LE COLIS", "Del_Step1")

delBtn(secStep1, "TP au GetPackage", "Accent", function()
    local ds = getDeliverySystem()
    if not ds then toast("Error","Delivery System introuvable"); return end
    local gp = ds:FindFirstChild("GetPackage")
    if not gp then toast("Error","GetPackage introuvable"); return end
    local ch = LocalPlayer.Character
    local hrp = ch and ch:FindFirstChild("HumanoidRootPart")
    if hrp then
        local p = gp.Position
        hrp.CFrame = CFrame.new(p.X, p.Y + 3, p.Z + 5)
        toast("Success","📦 TP au GetPackage")
    end
end, "📦")
-- ═══ SECTION 3.5 : FULL AUTO INTELLIGENT ═══
local secDetect = delSection("🎯 FULL AUTO", "Del_Detect")

-- 🎯 Lit le Beam du personnage pour trouver le DropOff cible
local function getActiveDropOff()
    local ch = LocalPlayer.Character
    if not ch then return nil end

    local beam = nil
    for _, d in ipairs(ch:GetDescendants()) do
        if d:IsA("Beam") and d.Enabled then
            beam = d
            break
        end
    end
    if not beam then return nil end

    local a1 = beam.Attachment1
    if not a1 or not a1.Parent then return nil end

    local target = a1.Parent
    local cur = target
    while cur and cur ~= Workspace do
        if cur.Name:match("^DropOff_") then return cur end
        cur = cur.Parent
    end

    local ds = getDeliverySystem()
    if ds then
        for _, child in ipairs(ds:GetChildren()) do
            if child.Name:match("^DropOff_") then
                if child == target or target:IsDescendantOf(child) then
                    return child
                end
            end
        end
    end
    return target
end

-- ═══ ÉTAT DU FULL AUTO ═══
local fullAutoActive = false

-- 🚚 Bouton toggle : ON = boucle infinie, OFF = arrêt
local fullAutoBtn
fullAutoBtn = delBtn(secDetect, "🚚 FULL AUTO (OFF)", "Green", function()
    local ds = getDeliverySystem()
    if not ds then toast("Error","Delivery System introuvable"); return end

    fullAutoActive = not fullAutoActive

    if fullAutoActive then
        -- Passage en ON
        fullAutoBtn:SetAttribute("OverrideColor", true)   -- ✅ bloque le hover
        fullAutoBtn.Text = "🛑  FULL AUTO (ON)"
        fullAutoBtn.BackgroundColor3 = C.Red
        toast("Info","🚚 FULL AUTO activé (boucle)")

        task.spawn(function()
            local livraisons = 0
            while fullAutoActive and GUI.Parent do
                local gp = ds:FindFirstChild("GetPackage")
                if not gp then
                    toast("Warning","GetPackage introuvable")
                    task.wait(1)
                    continue
                end

                toast("Info","📦 Récupération...")
                tpAndPrompt(gp, "GetPackage", 0.2)
                task.wait(0.6)
                if not fullAutoActive then break end

                local drop = getActiveDropOff()
                if not drop then
                    toast("Warning","Pas de DropOff détecté, retry...")
                    task.wait(1)
                    continue
                end

                if not fullAutoActive then break end

                toast("Info","🚚 Livraison...")
                tpAndPrompt(drop, "DropOff", 0.2)
                task.wait(0.2)

                livraisons = livraisons + 1
                toast("Success","✅ Livré ! ("..livraisons..")")
                task.wait(3 + math.random() * 2)
            end

            toast("Info","🚚 FULL AUTO arrêté ("..livraisons.." livraisons)")
        end)
    else
        -- Passage en OFF
        fullAutoBtn:SetAttribute("OverrideColor", false)   -- ✅ ré-autorise le hover
        fullAutoBtn.Text = "🚚  FULL AUTO (OFF)"
        fullAutoBtn.BackgroundColor3 = C.Green
        toast("Info","🚚 FULL AUTO désactivé")
    end
end, "🚚")

task.spawn(function()
    while GUI.Parent do
        task.wait(0.3)
        DelScroll.CanvasSize = UDim2.new(0,0,0, DelLayout.AbsoluteContentSize.Y + 20)
    end
end)
-- ═══════════ THEME ═══════════
local ThemeTab = regTab("THEME", "Tab_Theme")

local thTitle = mk("TextLabel",{
    Name="Title",
    Size=UDim2.new(1,0,0,26), BackgroundTransparency=1, Text="Thème",
    TextColor3=C.Txt, Font=Enum.Font.GothamBlack, TextSize=20,
    TextXAlignment=Enum.TextXAlignment.Left, Parent=ThemeTab})
reg(thTitle,"Text","Txt")
local thSub = mk("TextLabel",{
    Name="Sub",
    Size=UDim2.new(1,0,0,14), Position=UDim2.new(0,0,0,26),
    BackgroundTransparency=1, Text="Change l'apparence (sauvegardé auto)",
    TextColor3=C.Sub, Font=Enum.Font.Gotham, TextSize=10,
    TextXAlignment=Enum.TextXAlignment.Left, Parent=ThemeTab})
reg(thSub,"Text","Sub")

local themeKeys = {"Blue","Red","Green","Purple","Mono","Cyberpunk","Sunset","Ocean"}
local themeBtns = {}

local function applyTheme(key)
    local T2 = THEMES[key]
    if not T2 then return end
    _G.AC6_LastTheme = key
    for k,v in pairs(T2) do
        if k ~= "name" then C[k] = v end
    end
    for _, ref in ipairs(themeRefs) do
        pcall(function()
            if ref.kind == "Bg" then
                if ref.obj:IsA("UIGradient") then return end
                ref.obj.BackgroundColor3 = C[ref.key]
            elseif ref.kind == "Text" then
                ref.obj.TextColor3 = C[ref.key]
            elseif ref.kind == "Grad" then
                if ref.key == "Bg" then
                    ref.obj.Color = ColorSequence.new(C.Bg, C.Bg2)
                elseif ref.key == "AccentGrad" then
                    ref.obj.Color = ColorSequence.new(C.Accent, C.Accent2)
                elseif ref.key == "GlassGrad" then
                    ref.obj.Color = ColorSequence.new(C.Glass, C.Glass2)
                elseif ref.key == "GreenGrad" then
                    ref.obj.Color = ColorSequence.new(C.Green, C.Accent3)
                elseif ref.key == "Accent2Grad" then
                    ref.obj.Color = ColorSequence.new(C.Accent2, C.Accent)
                end
            end
        end)
    end
    Main.BackgroundColor3 = C.Bg
    mainGrad.Color = ColorSequence.new(C.Bg, C.Bg2)
    for k,d in pairs(themeBtns) do
        local on = (k==key)
        d.btn.BackgroundColor3 = on and T2.Accent or C.Glass
        d.btn.TextColor3 = on and Color3.fromRGB(15,20,35) or C.Txt
        local s = d.btn:FindFirstChildOfClass("UIStroke")
        if s then s.Color = on and T2.Accent or C.Stroke end
    end
    refreshModes()
    refreshDistBtns()
    if not S.loop then
        LoopBtn.BackgroundColor3 = C.Glass
        LoopBtn.TextColor3 = C.Txt
    end
    toast("Success","Thème : "..T2.name)
end

for i,k in ipairs(themeKeys) do
    local T2 = THEMES[k]
    local b = mk("TextButton",{
        Name="Btn_Theme_"..k,
        Size=UDim2.new(1,0,0,48), Position=UDim2.new(0,0,0,52 + (i-1)*56),
        BackgroundColor3=C.Glass, BorderSizePixel=0, Text="",
        AutoButtonColor=false, Parent=ThemeTab})
    crn(b,10); strk(b, C.Stroke, 1, .5)
    reg(b, "Bg", "Glass")

    local swatch = mk("Frame",{
        Size=UDim2.new(0,28,0,28), Position=UDim2.new(0,12,0,10),
        BackgroundColor3=T2.Accent, BorderSizePixel=0, Parent=b})
    crn(swatch,8)
    grad(swatch, T2.Accent, T2.Accent2, 45)

    local nameLbl = mk("TextLabel",{
        Size=UDim2.new(1,-80,0,18), Position=UDim2.new(0,52,0,8),
        BackgroundTransparency=1, Text=T2.name, TextColor3=C.Txt,
        Font=Enum.Font.GothamBold, TextSize=13,
        TextXAlignment=Enum.TextXAlignment.Left, Parent=b})
    reg(nameLbl, "Text", "Txt")
    local subLbl = mk("TextLabel",{
        Size=UDim2.new(1,-80,0,14), Position=UDim2.new(0,52,0,26),
        BackgroundTransparency=1, Text="Clique pour appliquer",
        TextColor3=C.Sub, Font=Enum.Font.Gotham, TextSize=9,
        TextXAlignment=Enum.TextXAlignment.Left, Parent=b})
    reg(subLbl, "Text", "Sub")

    b.MouseButton1Click:Connect(function() applyTheme(k) end)
    b.MouseEnter:Connect(function()
        TweenService:Create(b,TweenInfo.new(.15),{BackgroundColor3=C.InputHi}):Play()
    end)
    b.MouseLeave:Connect(function()
        TweenService:Create(b,TweenInfo.new(.15),{BackgroundColor3=C.Glass}):Play()
    end)

    themeBtns[k] = {btn=b}
end

-- ═══════════ COMMANDES ═══════════
local CmdTab = regTab("COMMANDES", "Tab_Commandes")

local cmdTitle = mk("TextLabel",{
    Name="Title",
    Size=UDim2.new(1,0,0,26), BackgroundTransparency=1, Text="Commandes & Aide",
    TextColor3=C.Txt, Font=Enum.Font.GothamBlack, TextSize=20,
    TextXAlignment=Enum.TextXAlignment.Left, Parent=CmdTab})
reg(cmdTitle,"Text","Txt")

local CmdScroll = mk("ScrollingFrame",{
    Name="CmdScroll",
    Size=UDim2.new(1,0,1,-36), Position=UDim2.new(0,0,0,36),
    BackgroundTransparency=1, BorderSizePixel=0,
    CanvasSize=UDim2.new(0,0,0,0), ScrollBarThickness=5,
    ScrollBarImageColor3=C.Green, Parent=CmdTab})
local CmdLayout = mk("UIListLayout",{Padding=UDim.new(0,10),Parent=CmdScroll})

local function cmdSection(title, name)
    local f = mk("Frame",{
        Name=name or "Section",
        Size=UDim2.new(1,-10,0,0), BackgroundTransparency=1,
        Parent=CmdScroll, AutomaticSize=Enum.AutomaticSize.Y})
    mk("UIListLayout",{Padding=UDim.new(0,4),Parent=f})
    local tL = mk("TextLabel",{
        Size=UDim2.new(1,0,0,22), BackgroundTransparency=1, Text=title,
        TextColor3=C.Accent, Font=Enum.Font.GothamBlack, TextSize=13,
        TextXAlignment=Enum.TextXAlignment.Left, Parent=f})
    reg(tL,"Text","Accent")
    return f
end

local function cmdRow(parent, cmd, desc)
    local row = mk("Frame",{
        Size=UDim2.new(1,0,0,28),
        BackgroundColor3=C.Glass2, BorderSizePixel=0, Parent=parent})
    crn(row,7); strk(row, C.Stroke, 1, .6); reg(row, "Bg", "Glass2")
    local cL = mk("TextLabel",{
        Size=UDim2.new(0,170,1,0), Position=UDim2.new(0,10,0,0),
        BackgroundTransparency=1, Text=cmd,
        TextColor3=C.Green, Font=Enum.Font.Code, TextSize=12,
        TextXAlignment=Enum.TextXAlignment.Left, Parent=row})
    reg(cL,"Text","Green")
    local dL = mk("TextLabel",{
        Size=UDim2.new(1,-186,1,0), Position=UDim2.new(0,180,0,0),
        BackgroundTransparency=1, Text=desc,
        TextColor3=C.Sub, Font=Enum.Font.Gotham, TextSize=11,
        TextXAlignment=Enum.TextXAlignment.Left,
        TextTruncate=Enum.TextTruncate.AtEnd, Parent=row})
    reg(dL,"Text","Sub")
end

local sec1 = cmdSection("⚡ Commandes principales", "Sec_Main")
cmdRow(sec1, "/play <musique>",      "Joue la musique dans le mode actif")
cmdRow(sec1, "/stop",                "Stoppe tous les sons")
cmdRow(sec1, "/vol <nombre>",        "Change le volume + relance")
cmdRow(sec1, "/loop",                "Active/désactive la boucle")

local sec2 = cmdSection("🎯 Modes & cibles", "Sec_Modes")
cmdRow(sec2, "/set me",              "Joue seulement pour toi")
cmdRow(sec2, "/set all",             "Joue pour tout le serveur")
cmdRow(sec2, "/set players",         "Joue sur chaque joueur")
cmdRow(sec2, "/set specific",        "Joue pour une cible choisie")

local sec3 = cmdSection("👤 Actions joueurs", "Sec_Actions")
cmdRow(sec3, "/playto <joueur> <mus>",  "Joue une musique pour un joueur")
cmdRow(sec3, "/playveh <joueur> <mus>", "Joue depuis le véhicule d'un joueur")
cmdRow(sec3, "/tpto <joueur>",          "Se téléporter sur un joueur")
cmdRow(sec3, "/follow <joueur>",        "Caméra qui suit un joueur")
cmdRow(sec3, "/esp <joueur>",           "Outline (ESP) sur un joueur")

local sec4 = cmdSection("📖 Guide interface", "Sec_Guide")
local guideLines = {
    "1. Mode : MOI / TOUS / JOUEURS / SPÉCIFIQUE",
    "2. Musique : tape le nom ou l'ID",
    "3. Pitch : vitesse (1 = normal)",
    "4. Volume : 1 = normal, 2 = fort",
    "5. Boucle : répète",
    "6. Distance : Local / Proche / Moyen / Loin / Infini",
    "7. VÉHICULES : 👤 = joueur, 🚗 = DriveSeat, 🪑 = Body.Seat",
    "8. FUN : téléports, clés, delivery, KL Block",
    "9. THÈME : sauvegardé automatiquement",
}
for i, line in ipairs(guideLines) do
    local l = mk("TextLabel",{
        Size=UDim2.new(1,-10,0,20),
        BackgroundTransparency=1, Text=line,
        TextColor3=C.Txt, Font=Enum.Font.Gotham, TextSize=11,
        TextXAlignment=Enum.TextXAlignment.Left, Parent=sec4})
    reg(l, "Text", "Txt")
end

task.spawn(function()
    while GUI.Parent do
        task.wait(0.5)
        CmdScroll.CanvasSize = UDim2.new(0,0,0, CmdLayout.AbsoluteContentSize.Y + 20)
    end
end)

-- ═══════════ PROGRESS + COMPTEUR ═══════════
local function fmtTime(s)
    s = math.max(0, math.floor(s or 0))
    return string.format("%d:%02d", math.floor(s/60), s%60)
end
task.spawn(function()
    while GUI.Parent do
        task.wait(0.5)
        local n = S.curName
        if not n then
            BarFill.Size = UDim2.new(0,0,1,0)
            NowTitle.Text = "Aucune musique"
            NowSub.Text   = "Sélectionne un mode et lance"
            TimeLbl.Text  = "0:00 / 0:00"
        else
            local cached = Workspace:FindFirstChild(n, true)
            if cached and cached:IsA("Sound") then
                local d, p = cached.TimeLength, cached.TimePosition
                if d and d > 0 then
                    BarFill.Size = UDim2.new(math.clamp(p/d,0,1),0,1,0)
                    TimeLbl.Text = fmtTime(p).." / "..fmtTime(d)
                end
                NowTitle.Text = S.curLabel
                NowSub.Text = (cached.IsPlaying and "En lecture  •  " or "Pause  •  ")..S.mode
            end
        end
        local count = 0
        for _ in pairs(activeSounds) do count = count + 1 end
        SndCounter.Text = "🎵 "..count.." son"..(count > 1 and "s" or "").." actif"..(count > 1 and "s" or "")
    end
end)

-- ═══════════ PLAYER EVENTS ═══════════
Players.PlayerAdded:Connect(function()
    task.wait(0.3); refreshSpec(); refreshView(); refreshVeh()
end)
Players.PlayerRemoving:Connect(function(p)
    if highlights[p] then
        pcall(function() highlights[p]:Destroy() end)
        highlights[p] = nil
    end
    if S.viewing == p then
        S.viewing = nil
        pcall(function()
            local hum = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
            Camera.CameraSubject = hum
            Camera.CameraType = Enum.CameraType.Custom
        end)
    end
    task.wait(0.3); refreshSpec(); refreshView(); refreshVeh()
end)

-- ═══════════ CHAT COMMANDS ═══════════
_G.AC6_Chat = LocalPlayer.Chatted:Connect(function(msg)
    if string.sub(msg, 1, 1) ~= "/" then return end
    task.spawn(function()
        local a = string.split(msg, " ")
        local c = string.lower(a[1] or "")

        local function findPlayer(query)
            if not query or query == "" then return nil end
            local q = string.lower(query)
            for _, p in ipairs(Players:GetPlayers()) do
                if p ~= LocalPlayer and string.find(string.lower(p.Name), q, 1, true) then return p end
            end
            for _, p in ipairs(Players:GetPlayers()) do
                if p ~= LocalPlayer and string.find(string.lower(p.DisplayName), q, 1, true) then return p end
            end
            return nil
        end

        local function findTrack(query)
            if not query or query == "" then return nil end
            local q = string.lower(query)
            if musicDatabase[q] then return musicDatabase[q] end
            for k, v in pairs(musicDatabase) do
                if string.find(k, q, 1, true) then return v end
            end
            return nil
        end

        local function splitTarget(startIdx)
            if not a[startIdx] then return nil, nil end
            local name = a[startIdx]
            local parts = {}
            for i = startIdx + 1, #a do table.insert(parts, a[i]) end
            return name, string.lower(table.concat(parts, " "))
        end

        if c == "/play" then
            local parts = {}
            for i = 2, #a do table.insert(parts, a[i]) end
            local song = string.lower(table.concat(parts, " "))
            local id = findTrack(song)
            if not id then toast("Error","Musique introuvable"); return end
            playMode("rbxassetid://"..id, song)
            toast("Music","▶ "..song)

        elseif c == "/stop" then
            stopAll(); toast("Info","Son arrêté")

        elseif c == "/vol" or c == "/volume" then
            local v = tonumber(a[2])
            if v then
                volInp.Text = tostring(v)
                if S.curId then restartCurrentSound() end
                toast("Info","Volume = "..v)
            end

        elseif c == "/loop" then
            S.loop = not S.loop
            LoopBtn.BackgroundColor3 = S.loop and C.Green or C.Glass
            LoopBtn.TextColor3 = S.loop and Color3.fromRGB(15,30,20) or C.Txt
            LoopBtn.Text = S.loop and "🔁  BOUCLE ON" or "🔁  BOUCLE OFF"
            local s = LoopBtn:FindFirstChildOfClass("UIStroke")
            if s then s.Color = S.loop and C.Green or C.Stroke end
            if S.curId then restartCurrentSound() end
            toast("Info","Boucle "..(S.loop and "ON" or "OFF"))

        elseif c == "/set" then
            local sub = string.lower(a[2] or "")
            local m
            if sub == "me" then m = "Me"
            elseif sub == "all" then m = "All"
            elseif sub == "players" then m = "Players"
            elseif sub == "specific" then m = "Specific" end
            if m then setMode(m); toast("Info","Mode : "..m) end

        elseif c == "/playto" or c == "/pt" then
            local targetName, song = splitTarget(2)
            if not targetName or not song or song == "" then
                toast("Warning","/playto <joueur> <musique>"); return
            end
            local plr = findPlayer(targetName)
            if not plr then toast("Error","Joueur introuvable"); return end
            local id = findTrack(song)
            if not id then toast("Error","Musique introuvable"); return end
            local ch = plr.Character
            local rp = ch and ch:FindFirstChild("HumanoidRootPart")
            if not rp then toast("Error","Pas de perso"); return end
            fire(rp, "rbxassetid://"..id,
                num(pitchInp.Text,1), num(volInp.Text,1), S.loop,
                ac6_uniqName("pt_"..plr.Name))
            toast("Music","▶ "..song.." → "..plr.DisplayName)

        elseif c == "/playveh" or c == "/pv" or c == "/playcar" then
            local targetName, song = splitTarget(2)
            if not targetName or not song or song == "" then
                toast("Warning","/playveh <joueur> <musique>"); return
            end
            local plr = findPlayer(targetName)
            if not plr then toast("Error","Joueur introuvable"); return end
            local id = findTrack(song)
            if not id then toast("Error","Musique introuvable"); return end
            local ch = plr.Character
            local hum = ch and ch:FindFirstChildOfClass("Humanoid")
            local seat = hum and hum.SeatPart
            if not seat then
                toast("Warning", plr.DisplayName.." n'est pas dans un véhicule"); return
            end
            local ds = findDriveSeat(seat)
            if not ds then toast("Error","Pas de DriveSeat"); return end
            local nm = "ac6_veh_"..ds:GetFullName():gsub("[^%w]","_")
            if vehicleSounds[ds] then stopNames({vehicleSounds[ds]}) end
            fire(ds, "rbxassetid://"..id,
                num(pitchInp.Text,1), num(volInp.Text,1), S.loop, nm)
            vehicleSounds[ds] = nm
            toast("Vehicle","🚗 "..song.." → "..plr.DisplayName)

        elseif c == "/tpto" or c == "/tp" then
            local plr = findPlayer(a[2])
            if not plr then toast("Error","Joueur introuvable"); return end
            local myRoot = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
            local tRoot = plr.Character and plr.Character:FindFirstChild("HumanoidRootPart")
            if myRoot and tRoot then
                myRoot.CFrame = tRoot.CFrame * CFrame.new(0, 0, 3)
                toast("Success","🎯 TP sur "..plr.DisplayName)
            end

        elseif c == "/follow" then
            local plr = findPlayer(a[2])
            if not plr then toast("Error","Joueur introuvable"); return end
            S.viewing = plr
            pcall(function()
                local hum = plr.Character and plr.Character:FindFirstChildOfClass("Humanoid")
                if hum then
                    Camera.CameraSubject = hum
                    Camera.CameraType = Enum.CameraType.Custom
                end
            end)
            toast("Info","📷 Suivi : "..plr.DisplayName)

        elseif c == "/esp" then
            local plr = findPlayer(a[2])
            if not plr then toast("Error","Joueur introuvable"); return end
            local ch = plr.Character
            if not ch then toast("Error","Pas de perso"); return end
            if highlights[plr] and highlights[plr].Parent then
                highlights[plr]:Destroy(); highlights[plr] = nil
                toast("Info","ESP off : "..plr.DisplayName)
            else
                local hl = Instance.new("Highlight")
                hl.Name = "AC6_HL"; hl.Adornee = ch
                hl.FillColor = C.Accent2; hl.FillTransparency = .55
                hl.OutlineColor = Color3.fromRGB(255,255,255)
                hl.OutlineTransparency = 0
                hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
                hl.Parent = ch
                highlights[plr] = hl
                toast("Success","ESP on : "..plr.DisplayName)
            end

        elseif c == "/ac6" or c == "/help" then
            toast("Info","/play /playto /playveh /tpto /follow /esp /stop /set /loop /vol")
        end
    end)
end)

-- ═══════════ INIT FINAL ═══════════
switchTab("AUDIO")
refreshSpec()
refreshVeh()
refreshView()

task.delay(0.1, function()
    if _G.AC6_LastTheme and THEMES[_G.AC6_LastTheme] then
        applyTheme(_G.AC6_LastTheme)
    end
end)

task.delay(0.3, function()
    toast("Success","AC6 Elite Mixer v10.5 FINAL chargé")
end)
print("✅ AC6 Elite Mixer v10.5 FINAL — /ac6 pour les commandes")
