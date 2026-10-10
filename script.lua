local Pl = game:GetService("Players")
local p = Pl.LocalPlayer

local KEYWORDS = {
    "potion of strength","strength","bull essence","bull",
    "frog potion","frog","speed potion","speed","boba",
    "permanent","perma","heal","health",
    "ice cube","icecube","fury sphere","fury",
    "true power","truepower","tomahawk"
}

local USE_KEYWORDS = {
    "permanent","perma","potion of strength","strength",
    "bull essence","frog potion","speed potion",
    "fury sphere","true power","ice cube","heal"
}

local CONFIG = {
    walkspeed = 40,          -- скорость ходьбы к предмету
    arriveDistance = 4,      -- на каком расстоянии считаем что дошли
    walkTimeout = 4,         -- максимум секунд на один предмет
    delayBetween = 0.4,
    maxPerCycle = 3,
    autoUse = true,
    useDelay = 0.15,
}

local looted = {}
local run = true

local function chr()
    local c = p.Character
    if not c then return nil end
    local h = c:FindFirstChildOfClass("Humanoid")
    local r = c:FindFirstChild("HumanoidRootPart")
    if h and h.Health > 0 and r then
        return c, h, r
    end
    return nil
end

local function matches(name, list)
    local n = name:lower()
    for _, k in ipairs(list) do
        if n:find(k, 1, true) then return true end
    end
    return false
end

local function isLoot(inst)
    if inst:IsDescendantOf(p.Character) then return false end
    if Pl:GetPlayerFromCharacter(inst.Parent) then return false end
    return matches(inst.Name, KEYWORDS)
end

local function getPart(inst)
    if inst:IsA("BasePart") then return inst end
    return inst:FindFirstChildWhichIsA("BasePart", true)
end

-- ходьба к точке без тп
local function walkTo(pos)
    local c, hum, root = chr()
    if not hum or not root then return false end

    local oldSpeed = hum.WalkSpeed
    hum.WalkSpeed = CONFIG.walkspeed

    local start = tick()
    while tick() - start < CONFIG.walkTimeout do
        if not run then break end
        c, hum, root = chr()
        if not root or not hum or hum.Health <= 0 then break end
        local d = (root.Position - pos).Magnitude
        if d <= CONFIG.arriveDistance then break end
        pcall(function()
            hum:MoveTo(pos)
        end)
        task.wait(0.05)
    end

    pcall(function() hum:MoveTo(root.Position) end)
    pcall(function() hum.WalkSpeed = oldSpeed end)
    return true
end

-- подбор через prompt/click/touch
local function tryPickup(inst, root, part)
    if inst.Parent and inst:FindFirstChildWhichIsA("ProximityPrompt", true) then
        local prompt = inst:FindFirstChildWhichIsA("ProximityPrompt", true)
        pcall(function()
            prompt:InputHoldBegin()
            task.wait(math.min(prompt.HoldDuration or 0.2, 0.8))
            prompt:InputHoldEnd()
        end)
        task.wait(0.1)
    end
    if inst.Parent and inst:FindFirstChildWhichIsA("ClickDetector", true) and fireclickdetector then
        pcall(function() fireclickdetector(inst:FindFirstChildWhichIsA("ClickDetector", true)) end)
        task.wait(0.1)
    end
    if inst.Parent and firetouchinterest then
        pcall(function()
            firetouchinterest(root, part, 0)
            task.wait()
            firetouchinterest(root, part, 1)
        end)
    end
end

local function grab(inst)
    local c, hum, root = chr()
    if not root then return false end
    if looted[inst] or not inst.Parent then return false end

    local part = getPart(inst)
    if not part then return false end

    looted[inst] = true

    walkTo(part.Position)
    task.wait(0.25)

    if inst.Parent then
        tryPickup(inst, root, part)
    end

    task.wait(0.15)
    return true
end

-- авто-использование перм баффов из бекпака
local function useBuffs()
    if not CONFIG.autoUse then return end
    local c, hum = chr()
    if not c or not hum then return end
    local bp = p:FindFirstChild("Backpack")
    if not bp then return end
    for _, t in ipairs(bp:GetChildren()) do
        if t:IsA("Tool") and matches(t.Name, USE_KEYWORDS) then
            local ok = pcall(function()
                hum:EquipTool(t)
            end)
            if ok then
                task.wait(0.1)
                pcall(function() t:Activate() end)
                task.wait(CONFIG.useDelay)
                -- снять и вернуть в бекпак если не израсходовался
                if t.Parent == c then
                    pcall(function() hum:UnequipTools() end)
                end
            end
        end
    end
end

task.spawn(function()
    while run do
        task.wait(0.4)
        if not chr() then continue end

        local items = {}
        for _, inst in ipairs(workspace:GetDescendants()) do
            if isLoot(inst) and not looted[inst] then
                local part = getPart(inst)
                if part then
                    table.insert(items, {inst = inst, part = part})
                end
            end
        end

        if #items > 0 then
            local c, hum, root = chr()
            if root then
                table.sort(items, function(a, b)
                    return (a.part.Position - root.Position).Magnitude
                        < (b.part.Position - root.Position).Magnitude
                end)

                local count = 0
                for _, it in ipairs(items) do
                    if count >= CONFIG.maxPerCycle or not run then break end
                    if grab(it.inst) then
                        count = count + 1
                        task.wait(CONFIG.delayBetween + math.random() * 0.2)
                    end
                end
            end
        end

        useBuffs()
    end
end)

game:GetService("StarterGui"):SetCore("SendNotification", {
    Title = "ELAN",
    Text = "loot online (walk mode)"
})
