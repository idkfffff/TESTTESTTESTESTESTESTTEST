local LatestRoom = game:GetService("ReplicatedStorage").GameData.LatestRoom
local ChaseStart = game:GetService("ReplicatedStorage").GameData.ChaseStart
local player = game.Players.LocalPlayer
local event = game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest



local BookChams = {}

for i,v in pairs(BookChams) do
	v.Enabled = true
end

local FigureChams = {}

for i,v in pairs(FigureChams) do
	v.Enabled = true
end

local KeyChams = {}

for i,v in pairs(KeyChams) do
	v.Enabled = true
end

local function ApplyKeyChams(inst)
	wait()
	local Cham = Instance.new("Highlight")
	Cham.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
	Cham.FillColor = Color3.new(0.980392, 0.670588, 0)
	Cham.FillTransparency = 0.5
	Cham.OutlineColor = Color3.new(0.792156, 0.792156, 0.792156)
	Cham.Parent = game:GetService("CoreGui")
	Cham.Adornee = inst
	Cham.Enabled = true
	Cham.RobloxLocked = true
	return Cham
end

local KeyCoroutine = coroutine.create(function()
	workspace.CurrentRooms.DescendantAdded:Connect(function(inst)
		if inst.Name == "KeyObtain" then
			table.insert(KeyChams,ApplyKeyChams(inst))
		end
	end)
end)
for i,v in ipairs(workspace:GetDescendants()) do
	if v.Name == "KeyObtain" then
		table.insert(KeyChams,ApplyKeyChams(v))
	end
end
coroutine.resume(KeyCoroutine)

local function ApplyBookChams(inst)
	if inst:IsDescendantOf(game:GetService("Workspace").CurrentRooms:FindFirstChild("50")) and game:GetService("ReplicatedStorage").GameData.LatestRoom.Value == 50 then
		wait()
		local Cham = Instance.new("Highlight")
		Cham.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
		Cham.FillColor = Color3.new(0, 1, 0.749019)
		Cham.FillTransparency = 0.5
		Cham.OutlineColor = Color3.new(0.792156, 0.792156, 0.792156)
		Cham.Parent = game:GetService("CoreGui")
		Cham.Enabled = true
		Cham.Adornee = inst
		Cham.RobloxLocked = true
		return Cham
	end
end

local function ApplyEntityChams(inst)
	wait()
	local Cham = Instance.new("Highlight")
	Cham.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
	Cham.FillColor = Color3.new(1, 0, 0)
	Cham.FillTransparency = 0.5
	Cham.OutlineColor = Color3.new(0.792156, 0.792156, 0.792156)
	Cham.Parent = game:GetService("CoreGui")
	Cham.Enabled = true
	Cham.Adornee = inst
	Cham.RobloxLocked = true
	return Cham
end

local BookCoroutine = coroutine.create(function()
	task.wait(1)
	for i,v in pairs(game:GetService("Workspace").CurrentRooms["50"].Assets:GetDescendants()) do
		if v.Name == "LiveHintBook" then
			table.insert(BookChams,ApplyBookChams(v))
		end
	end
end)
local EntityCoroutine = coroutine.create(function()
	local Entity = game:GetService("Workspace").CurrentRooms["50"].FigureSetup:WaitForChild("FigureRagdoll",5)
	Entity:WaitForChild("Torso",2.5)
	table.insert(FigureChams,ApplyEntityChams(Entity))
end)


LatestRoom.Changed:Connect(function()
	local n = ChaseStart.Value - LatestRoom.Value
	if 0 < n and n < 4 then
        event:FireServer("Event in " .. tostring(n) .. " rooms.", "All")
    elseif n == 0 then
        event:FireServer("Hide Now", "All")
    end
	if LatestRoom.Value == 50 then
		coroutine.resume(BookCoroutine)
	end
	
	if LatestRoom.Value == 50 then
		coroutine.resume(EntityCoroutine)
	end
end)
