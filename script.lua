local Pl = game:GetService("Players")
local p = Pl.LocalPlayer

local KEYWORDS = {
    "potion of strength","strength","bull essence","bull",
    "frog potion","frog","speed potion","speed","boba",
    "permanent","perma","heal","health",
    "ice cube","icecube","fury sphere","fury",
    "true power","truepower","tomahawk"
}

local CONFIG = {
    delayBetweenItems = 1.2,
    waitAfterTP = 0.5,
    maxPerCycle = 5,
    checkPickup = true,
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

local function isLoot(inst)
    if inst:IsDescendantOf(p.Character) then return false end
    if Pl:GetPlayerFromCharacter(inst.Parent) then return false end
    local n = inst.Name:lower()
    for _, k in ipairs(KEYWORDS) do
        if n:find(k, 1, true) then return true end
    end
    return false
end

local function getPart(inst)
    if inst:IsA("BasePart") then return inst end
    return inst:FindFirstChildWhichIsA("BasePart", true)
end

local function grab(inst)
    local c, hum, root = chr()
    if not root then return false end
    if looted[inst] or not inst.Parent then return false end

    local part = getPart(inst)
    if not part then return false end

    looted[inst] = true

    -- один тп без возврата
    pcall(function()
        root.CFrame = CFrame.new(part.Position + Vector3.new(0, 2, 0))
    end)

    task.wait(CONFIG.waitAfterTP)

    -- проверяем не собралось ли автоматически
    if inst.Parent and CONFIG.checkPickup then
        -- пробуем ProximityPrompt
        local prompt = inst:FindFirstChildWhichIsA("ProximityPrompt", true)
        if prompt then
            pcall(function()
                prompt:InputHoldBegin()
                task.wait(math.min(prompt.HoldDuration or 0.3, 1))
                prompt:InputHoldEnd()
            end)
        end
    end

    if inst.Parent and CONFIG.checkPickup then
        -- пробуем ClickDetector
        local click = inst:FindFirstChildWhichIsA("ClickDetector", true)
        if click and fireclickdetector then
            pcall(function() fireclickdetector(click) end)
            task.wait(0.2)
        end
    end

    if inst.Parent and CONFIG.checkPickup and firetouchinterest then
        -- touch в последнюю очередь
        pcall(function()
            firetouchinterest(root, part, 0)
            task.wait()
            firetouchinterest(root, part, 1)
        end)
        task.wait(0.2)
    end

    return true
end

task.spawn(function()
    while run do
        task.wait(0.5)
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

        if #items == 0 then continue end

        -- сортируем по расстоянию от нас
        local c, hum, root = chr()
        if not root then continue end
        table.sort(items, function(a, b)
            return (a.part.Position - root.Position).Magnitude
                < (b.part.Position - root.Position).Magnitude
        end)

        local count = 0
        for _, it in ipairs(items) do
            if count >= CONFIG.maxPerCycle then break end
            if not run then break end
            if grab(it.inst) then
                count = count + 1
                task.wait(CONFIG.delayBetweenItems + math.random() * 0.3)
            end
        end
    end
end)

game:GetService("StarterGui"):SetCore("SendNotification", {
    Title = "ELAN",
    Text = "loot online (safe mode)"
})
