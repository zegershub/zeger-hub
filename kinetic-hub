-- kinetic auto farmer by elan
local Pl=game:GetService("Players")
local UIS=game:GetService("UserInputService")
local RS=game:GetService("RunService")
local p=Pl.LocalPlayer

local CONFIG={
    autoEquip=true,
    autoBlock=true,         -- держит блок чтоб копить энергию
    autoSwing=true,         -- бьёт когда есть заряд
    killAura=true,          -- авто-удар по ближайшему в радиусе
    auraRange=15,
    faceTarget=true,        -- доворачивает камеру на цель
    swingDelay=0.3,         -- задержка между ударами (не спамит чтоб не кикнуло)
}

local function isKinetic(t)
    if not t or not t:IsA("Tool") then return false end
    local n=t.Name:lower()
    return n:find("kinetic",1,true) or n:find("kinet",1,true)
end

local function getChar()
    local c=p.Character
    if not c then return nil end
    local hum=c:FindFirstChildOfClass("Humanoid")
    local hrp=c:FindFirstChild("HumanoidRootPart")
    if hum and hum.Health>0 and hrp then return c,hum,hrp end
    return nil
end

local function getEquippedKinetic()
    local c=getChar()
    if not c then return nil end
    for _,t in ipairs(c:GetChildren()) do
        if isKinetic(t) then return t end
    end
    return nil
end

-- авто-эквип
task.spawn(function()
    while task.wait(1) do
        if not CONFIG.autoEquip then continue end
        local c,hum=getChar()
        if not c or not hum then continue end
        if getEquippedKinetic() then continue end
        local bp=p:FindFirstChild("Backpack")
        if not bp then continue end
        for _,t in ipairs(bp:GetChildren()) do
            if isKinetic(t) then
                pcall(function() hum:EquipTool(t) end)
                break
            end
        end
    end
end)

-- блок держим через virtualinput
local function pressBlock()
    local vu=game:GetService("VirtualUser")
    pcall(function()
        vu:CaptureController()
        vu:ClickButton2(Vector2.new())
    end)
end

task.spawn(function()
    while task.wait(0.4) do
        if not CONFIG.autoBlock then continue end
        local c=getChar()
        if not c then continue end
        if getEquippedKinetic() then
            pressBlock()
        end
    end
end)

-- поиск ближайшего игрока
local function nearestTarget(maxDist)
    local c,hum,hrp=getChar()
    if not c or not hrp then return nil end
    local best,bestD=nil,maxDist or CONFIG.auraRange
    for _,pl in ipairs(Pl:GetPlayers()) do
        if pl~=p and pl.Character then
            local tHrp=pl.Character:FindFirstChild("HumanoidRootPart")
            local tHum=pl.Character:FindFirstChildOfClass("Humanoid")
            if tHrp and tHum and tHum.Health>0 then
                local d=(tHrp.Position-hrp.Position).Magnitude
                if d<bestD then best=pl bestD=d end
            end
        end
    end
    return best,bestD
end

-- доворот камеры на цель
local function faceTarget(target)
    if not target or not target.Character then return end
    local c,hum,hrp=getChar()
    if not hrp then return end
    local tHrp=target.Character:FindFirstChild("HumanoidRootPart")
    if not tHrp then return end
    local look=Vector3.new(tHrp.Position.X,hrp.Position.Y,tHrp.Position.Z)
    hrp.CFrame=CFrame.new(hrp.Position,look)
end

-- авто-удар
local lastSwing=0
local function trySwing(target)
    local c,hum=getChar()
    if not c or not hum then return end
    local tool=getEquippedKinetic()
    if not tool then return end
    if tick()-lastSwing<CONFIG.swingDelay then return end
    lastSwing=tick()
    pcall(function()
        tool:Activate()
    end)
    pcall(function()
        local vu=game:GetService("VirtualUser")
        vu:CaptureController()
        vu:ClickButton1(Vector2.new())
    end)
end

RS.Heartbeat:Connect(function()
    local target,dist=nearestTarget()
    if target then
        if CONFIG.faceTarget then faceTarget(target) end
        if CONFIG.killAura and CONFIG.autoSwing then
            trySwing(target)
        end
    elseif CONFIG.autoSwing then
        -- если рядом никого нет — бьём вслепую чтоб не простаивать
        local tool=getEquippedKinetic()
        if tool and tick()-lastSwing>1 then
            lastSwing=tick()
            pcall(function() tool:Activate() end)
        end
    end
end)

print("[zeger] kinetic online")
