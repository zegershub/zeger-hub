local Pl = game:GetService("Players")
local p = Pl.LocalPlayer

local KEYWORDS = {
    "potion of strength","strength","bull essence","bull",
    "frog potion","frog","speed potion","speed","boba",
    "permanent","perma","heal","health",
    "ice cube","icecube","fury sphere","fury",
    "true power","truepower","tomahawk"
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
    if not root then return end
    if looted[inst] then return end
    local part = getPart(inst)
    if not part then return end
    looted[inst] = true
    local old = root.CFrame
    root.CFrame = part.CFrame + Vector3.new(0, 3, 0)
    task.wait(0.06 + math.random() * 0.08)

    if firetouchinterest then
        pcall(function()
            firetouchinterest(root, part, 0)
            task.wait()
            firetouchinterest(root, part, 1)
        end)
    end

    local prompt = inst:FindFirstChildWhichIsA("ProximityPrompt", true)
    if prompt then
        pcall(function()
            prompt:InputHoldBegin()
            task.wait(prompt.HoldDuration or 0.1)
            prompt:InputHoldEnd()
        end)
    end

    local click = inst:FindFirstChildWhichIsA("ClickDetector", true)
    if click and fireclickdetector then
        pcall(function() fireclickdetector(click) end)
    end

    task.wait(0.04 + math.random() * 0.08)
    if root and root.Parent then
        root.CFrame = old
    end
end

task.spawn(function()
    while task.wait(0.3) do
        if not run then continue end
        if not chr() then continue end
        for _, inst in ipairs(workspace:GetDescendants()) do
            if isLoot(inst) then
                pcall(grab, inst)
            end
        end
    end
end)

game:GetService("StarterGui"):SetCore("SendNotification", {
    Title = "ELAN",
    Text = "royale auto loot online"
})
