local cG,TS,UIS,RS,Pl=game:GetService("CoreGui"),game:GetService("TweenService"),game:GetService("UserInputService"),game:GetService("RunService"),game:GetService("Players")
if cG:FindFirstChild("ZegersHub_Premium") then cG.ZegersHub_Premium:Destroy() end
local Th={Bg=Color3.fromRGB(4,2,8),Sb=Color3.fromRGB(10,4,16),Cd=Color3.fromRGB(15,6,24),Tx=Color3.fromRGB(255,255,255),Mu=Color3.fromRGB(140,130,160),On=Color3.fromRGB(0,255,160),Of=Color3.fromRGB(255,50,90)}
local SG=Instance.new("ScreenGui",cG) SG.Name="ZegersHub_Premium" SG.ZIndexBehavior=Enum.ZIndexBehavior.Sibling
local MF=Instance.new("Frame",SG) MF.Name="MainFrame" MF.Size=UDim2.new(0,360,0,280) MF.Position=UDim2.new(0.1,0,0.3,0) MF.BackgroundColor3=Th.Bg MF.Active=true MF.Draggable=true MF.ClipsDescendants=true
Instance.new("UICorner",MF).CornerRadius=UDim.new(0,16)
local MS=Instance.new("UIStroke",MF) MS.Thickness=2
local G1=Instance.new("UIStroke",MF) G1.Thickness=4 G1.Transparency=0.6
local G2=Instance.new("UIStroke",MF) G2.Thickness=8 G2.Transparency=0.85
local S=Instance.new("Frame",MF) S.Size=UDim2.new(0,12,1,0) S.BackgroundColor3=Th.Sb
Instance.new("UICorner",S).CornerRadius=UDim.new(0,16)
local SF=Instance.new("Frame",S) SF.Size=UDim2.new(0,6,1,0) SF.Position=UDim2.new(1,-6,0,0) SF.BackgroundColor3=Th.Sb SF.BorderSizePixel=0
local SL=Instance.new("Frame",S) SL.Size=UDim2.new(0,2,1,0) SL.Position=UDim2.new(1,0,0,0) SL.BorderSizePixel=0
local pC={}
for i=1,12 do
    local p=Instance.new("Frame",MF)
    p.Size=UDim2.new(0,2,0,math.random(10,25))
    p.Position=UDim2.new(math.random(2,98)/100,0,math.random(-20,100)/100,0)
    p.BorderSizePixel=0
    p.BackgroundTransparency=0.6
    pC[i]={obj=p,spd=math.random(15,35)/1000}
end
local TC=Instance.new("Frame",MF) TC.Size=UDim2.new(1,-28,1,0) TC.Position=UDim2.new(0,20,0,0) TC.BackgroundTransparency=1
local T=Instance.new("TextLabel",TC) T.Size=UDim2.new(1,0,0,45) T.BackgroundTransparency=1 T.Font=Enum.Font.FredokaOne T.Text="🌌 ZEGER'S <font color='#00ffff'>CYBER</font> HUB" T.RichText=true T.TextColor3=Th.Tx T.TextSize=16 T.TextXAlignment=0
local ST=Instance.new("TextLabel",TC) ST.Size=UDim2.new(1,0,0,15) ST.Position=UDim2.new(0,0,0,32) ST.BackgroundTransparency=1 ST.Font=Enum.Font.SourceSansItalic ST.Text="Press [T] to collapse reality" ST.TextColor3=Th.Mu ST.TextSize=11 ST.TextXAlignment=0
local LC=Instance.new("Frame",TC) LC.Size=UDim2.new(1,0,1,-60) LC.Position=UDim2.new(0,0,0,60) LC.BackgroundTransparency=1
local UL=Instance.new("UIListLayout",LC) UL.Padding=UDim.new(0,8) UL.SortOrder=Enum.SortOrder.LayoutOrder
local function cR(txt,lo)
    local Cd=Instance.new("Frame",LC) Cd.Size=UDim2.new(1,-10,0,38) Cd.BackgroundColor3=Th.Cd Cd.LayoutOrder=lo
    Instance.new("UICorner",Cd).CornerRadius=UDim.new(0,10)
    local CS=Instance.new("UIStroke",Cd) CS.Color=Th.Cd CS.Thickness=1.5
    local L=Instance.new("TextLabel",Cd) L.Size=UDim2.new(0.7,0,1,0) L.Position=UDim2.new(0,14,0,0) L.BackgroundTransparency=1 L.Font=Enum.Font.GothamBold L.Text=txt L.TextColor3=Th.Mu L.TextSize=11 L.TextXAlignment=0
    local Sw=Instance.new("TextButton",Cd) Sw.Size=UDim2.new(0,46,0,20) Sw.Position=UDim2.new(1,-56,0.5,-10) Sw.BackgroundColor3=Color3.fromRGB(20,12,32) Sw.Text="" Sw.AutoButtonColor=false
    Instance.new("UICorner",Sw).CornerRadius=UDim.new(1,0)
    local D=Instance.new("Frame",Sw) D.Size=UDim2.new(0,14,0,14) D.Position=UDim2.new(0,3,0.5,-7) D.BackgroundColor3=Th.Of
    Instance.new("UICorner",D).CornerRadius=UDim.new(1,0)
    local DG=Instance.new("UIStroke",D) DG.Color=Th.Of DG.Thickness=3 DG.Transparency=0.4
    Cd.MouseEnter:Connect(function()TS:Create(L,TweenInfo.new(0.2),{TextColor3=Th.Tx}):Play()end)
    Cd.MouseLeave:Connect(function()TS:Create(L,TweenInfo.new(0.2),{TextColor3=Th.Mu}):Play()end)
    return Sw,D,CS,DG
end
local HB,HD,HS,HG=cR("🎯  SOFT CYAN HITBOXES",1)
local EB,ED,ES,EG=cR("👁️  CHROMA ESP AURA",2)
local IB,ID,IS,IG=cR("📦  STATIC ITEMS LOCATOR",3)
local KB,KD,KS,KG=cR("🛡️  LIGHT ANTI-KNOCK",4)
getgenv().ZActive,getgenv().EActive,getgenv().IActive,getgenv().KActive=false,false,false,false
local rg,p=15.0,Pl.LocalPlayer
local function aT(act,btn,dot,str,dtG)
    local tp=act and UDim2.new(1,-17,0.5,-7) or UDim2.new(0,3,0.5,-7)
    local tb=act and Color3.fromRGB(15,45,35) or Color3.fromRGB(20,12,32)
    TS:Create(dot,TweenInfo.new(0.2,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{Position=tp}):Play()
    TS:Create(btn,TweenInfo.new(0.2),{BackgroundColor3=tb}):Play()
    if not act then
        TS:Create(dot,TweenInfo.new(0.2),{BackgroundColor3=Th.Of}):Play()
        TS:Create(str,TweenInfo.new(0.2),{Color=Th.Cd}):Play()
        TS:Create(dtG,TweenInfo.new(0.2),{Color=Th.Of}):Play()
    end
end
HB.MouseButton1Click:Connect(function()
    getgenv().ZActive=not getgenv().ZActive aT(getgenv().ZActive,HB,HD,HS,HG)
    if not getgenv().ZActive then
        for _,pl in pairs(Pl:GetPlayers()) do
            if pl~=p and pl.Character and pl.Character:FindFirstChild("HumanoidRootPart") then
                pl.Character.HumanoidRootPart.Size=Vector3.new(2,2,2)
                pl.Character.HumanoidRootPart.Transparency=1
                pl.Character.HumanoidRootPart.Material=Enum.Material.Plastic
            end
        end
    end
end)
EB.MouseButton1Click:Connect(function()
    getgenv().EActive=not getgenv().EActive aT(getgenv().EActive,EB,ED,ES,EG)
    if not getgenv().EActive then
        for _,pl in pairs(Pl:GetPlayers()) do
            if pl.Character and pl.Character:FindFirstChild("ZH_Highlight") then pl.Character.ZH_Highlight:Destroy() end
            if pl.Character and pl.Character:FindFirstChild("HumanoidRootPart") and pl.Character.HumanoidRootPart:FindFirstChild("ZEsp") then pl.Character.HumanoidRootPart.ZEsp:Destroy() end
        end
    end
end)
IB.MouseButton1Click:Connect(function()
    getgenv().IActive=not getgenv().IActive aT(getgenv().IActive,IB,ID,IS,IG)
    if not getgenv().IActive then
        for _,it in ipairs(workspace:GetDescendants()) do
            if it.Name=="ZEsp" and it.Parent and not Pl:GetPlayerFromCharacter(it.Parent.Parent) then it:Destroy() end
        end
    end
end)
KB.MouseButton1Click:Connect(function()
    getgenv().KActive=not getgenv().KActive aT(getgenv().KActive,KB,KD,KS,KG)
end)
-- LIGHT ANTI-KNOCK
local VEL_NAMES={Velocity=true,Knockback=true,knockback=true}
local function isVel(v)
    return v:IsA("BodyVelocity") or v:IsA("LinearVelocity") or v:IsA("VectorForce") or v:IsA("BodyForce") or v:IsA("BodyAngularVelocity") or v:IsA("AngularVelocity") or v:IsA("AlignPosition") or VEL_NAMES[v.Name]
end
local function hookChar(char)
    if not char then return end
    char.DescendantAdded:Connect(function(v)
        if getgenv().KActive and isVel(v) then
            task.defer(function() if v and v.Parent then v:Destroy() end end)
        end
    end)
end
if p.Character then hookChar(p.Character) end
p.CharacterAdded:Connect(hookChar)
task.spawn(function()
    while task.wait(0.5) do
        if getgenv().KActive and p.Character then
            for _,v in ipairs(p.Character:GetDescendants()) do
                if isVel(v) then v:Destroy() end
            end
        end
    end
end)
local mV=true
UIS.InputBegan:Connect(function(i,pr)
    if not pr and i.KeyCode==Enum.KeyCode.T then
        mV=not mV
        local ts=mV and UDim2.new(0,360,0,280) or UDim2.new(0,360,0,0)
        TS:Create(MF,TweenInfo.new(0.25,Enum.EasingStyle.Quart,Enum.EasingDirection.Out),{Size=ts}):Play()
        TC.Visible=mV S.Visible=mV
    end
end)
local function cBB(par,txt,col)
    local ex=par:FindFirstChild("ZEsp")
    if ex then ex.TextLabel.Text=txt ex.TextLabel.TextColor3=col return end
    local bg=Instance.new("BillboardGui",par) bg.Name="ZEsp" bg.Size=UDim2.new(0,200,0,60) bg.AlwaysOnTop=true bg.ExtentsOffset=Vector3.new(0,4.5,0)
    local tl=Instance.new("TextLabel",bg) tl.BackgroundTransparency=1 tl.Size=UDim2.new(1,0,1,0) tl.Font=Enum.Font.GothamBold tl.Text=txt tl.TextColor3=col tl.TextSize=12 tl.TextStrokeTransparency=0.3 tl.TextStrokeColor3=Color3.fromRGB(0,0,0)
end
RS.RenderStepped:Connect(function()
    local rHub=tick()*0.4%1
    local rCol=Color3.fromHSV(rHub,0.9,1)
    MS.Color=rCol G1.Color=rCol G2.Color=rCol SL.BackgroundColor3=rCol
    local pS=(math.sin(tick()*5)+1)/2
    G1.Thickness=4+(pS*3)
    G2.Thickness=8+(pS*4)
    for _,drop in ipairs(pC) do
        drop.obj.BackgroundColor3=rCol
        local nY=drop.obj.Position.Y.Scale+drop.spd
        if nY>1.1 then
            drop.obj.Position=UDim2.new(math.random(2,98)/100,0,-0.1,0)
            drop.spd=math.random(15,35)/1000
        else
            drop.obj.Position=UDim2.new(drop.obj.Position.X.Scale,0,nY,0)
        end
    end
    if getgenv().ZActive then HD.BackgroundColor3=Th.On HG.Color=Th.On HS.Color=Th.On else HS.Color=Color3.fromHSV(rHub,0.4,0.4) end
    if getgenv().EActive then ED.BackgroundColor3=Th.On EG.Color=Th.On ES.Color=Th.On else ES.Color=Color3.fromHSV((rHub+0.3)%1,0.4,0.4) end
    if getgenv().IActive then ID.BackgroundColor3=Th.On IG.Color=Th.On IS.Color=Th.On else IS.Color=Color3.fromHSV((rHub+0.6)%1,0.5,0.5) end
    if getgenv().KActive then KD.BackgroundColor3=Th.On KG.Color=Th.On KS.Color=Th.On else KS.Color=Color3.fromHSV((rHub+0.8)%1,0.5,0.5) end
    for _,pl in pairs(Pl:GetPlayers()) do
        if pl~=p and pl.Character and pl.Character:FindFirstChild("HumanoidRootPart") and pl.Character:FindFirstChild("Humanoid") then
            local hrp=pl.Character.HumanoidRootPart
            if getgenv().ZActive then
                hrp.Size=Vector3.new(rg,rg,rg)
                hrp.Transparency=0.88
                hrp.Color=Color3.fromRGB(0,210,255)
                hrp.Material=Enum.Material.Plastic
                hrp.CanCollide=false
            end
            if getgenv().EActive then
                if not pl.Character:FindFirstChild("ZH_Highlight") then
                    local hl=Instance.new("Highlight",pl.Character) hl.Name="ZH_Highlight" hl.FillTransparency=0.6 hl.OutlineTransparency=0
                end
                local hl=pl.Character.ZH_Highlight
                hl.FillColor=rCol
                hl.OutlineColor=Color3.fromHSV((rHub+0.5)%1,1,1)
                local cG="None"
                for _,ch in ipairs(pl.Character:GetChildren()) do
                    if ch:IsA("Tool") or (ch:IsA("Model") and ch.Name:lower():find("glove")) then cG=ch.Name break end
                end
                cBB(hrp,string.format("⭐ %s\n🥊 [%s]\n⚡ Kills: %s | Power: %s",pl.Name,cG,tostring(pl:FindFirstChild("leaderstats") and pl.leaderstats:FindFirstChild("Kills") and pl.leaderstats.Kills.Value or 0),tostring(pl:FindFirstChild("leaderstats") and pl.leaderstats:FindFirstChild("Power") and pl.leaderstats.Power.Value or 0)),Th.Tx,false)
            end
        end
    end
end)
task.spawn(function()
    while task.wait(1.5) do
        if getgenv().IActive then
            for _,it in ipairs(workspace:GetDescendants()) do
                if it:IsA("Tool") or it.Name:lower():find("box") or it.Name:lower():find("chest") or it.Name:lower():find("potion") then
                    local h=it:FindFirstChild("Handle") or it:FindFirstChildOfClass("Part") or it:FindFirstChildOfClass("MeshPart")
                    if h and not it:IsDescendantOf(p.Character) and not Pl:GetPlayerFromCharacter(it.Parent) then
                        cBB(h,"📦 "..it.Name,Color3.fromRGB(255,255,255),true)
                    end
                end
            end
        end
    end
end)
