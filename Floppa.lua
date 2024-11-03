-- locals
local players = game:GetService("Players")
local teleportService = game:GetService("TeleportService")
local replicatedStorage = game:GetService("ReplicatedStorage")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local remotes = replicatedStorage:WaitForChild("Remotes")
local remote = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("Data"):WaitForChild("UpdateHotbar")
local senv = getsenv(players.LocalPlayer.PlayerGui:WaitForChild("Inventory"):WaitForChild("InventoryHandle"))
local FireServer = senv._G.FireServer
local inventoryRemote = remotes.Information.InventoryManage
local localPlayer = players.LocalPlayer
local Moves = {}
local lp = game:GetService("Players").LocalPlayer
local variables = {
    ToDrop = {},
    DropToggle = false,
}
local potionRecipes = {
    ["Heartbreaking Elixir"] = { { "Everthistle", 3 }, { "Carnastool", 1 } },
    ["Heartsoothing Remedy"] = { { "Everthistle", 3 }, { "Cryastem", 1 } },
    ["Abhorrent Elixir"] = { { "Everthistle", 2 }, { "Cryastem", 1 } },
    ["Alluring Elixir"] = { { "Everthistle", 2 }, { "Carnastool", 1 } },
    ["Small Healing Potion"] = { { "Everthistle", 1 }, { "Slime Chunk", 1 } },
    ["Medium Healing Potion"] = { { "Everthistle", 1 }, { "Slime Chunk", 1 }, { "Carnastool", 1 }, { "Hightail", 1 } },
    ["Minor Energy Elixir"] = { { "Everthistle", 1 }, { "Carnastool", 1 } },
    ["Average Energy Elixir"] = { { "Everthistle", 1 }, { "Cryastem", 1 }, { "Restless Fragment", 1 } },
    ["Minor Empowering Elixir"] = { { "Cryastem", 1 }, { "Carnastool", 1 }, { "Sand Core", 1 } },
    ["Minor Absorbing Potion"] = { { "Hightail", 1 }, { "Mushroom Cap", 1 } },
    ["Ferrus Skin Potion"] = { { "Carnastool", 1 }, { "Mushroom Cap", 1 }, { "Sand Core", 1 } },
    ["Invisibility Potion"] = { { "Driproot", 1 }, { "Hightail", 1 }, { "Haze Chunk", 1 } },
    ["Light of Grace"] = { { "Phoenix Tear", 1 }, { "Crylight", 1 }, { "Haze Chunk", 1 }, { "Sand Core", 1 }, { "Driproot", 1 } }
}
-- fuctions


local function GetUniqueToolNames()
    local uniqueToolNames = {}
    local toolsFolder = localPlayer.Backpack:FindFirstChild("Tools")
    if toolsFolder then
        for _, tool in ipairs(toolsFolder:GetChildren()) do
            if not table.find(uniqueToolNames, tool.Name) then
                table.insert(uniqueToolNames, tool.Name)
            end
        end
    end
    return uniqueToolNames
end
print(type(GetUniqueToolNames()))  -- Output: table

function getproximity()
    for _, Cauldrons in next, game:GetService("Workspace").Cauldrons:GetDescendants() do
        if Cauldrons:IsA("ProximityPrompt") then
            fireproximityprompt(Cauldrons)
        end
    end
end
 
function getclicker()
    for _, CauldronsClick in next, game:GetService("Workspace").Cauldrons:GetDescendants() do
        if CauldronsClick:IsA("ClickDetector") then
            fireclickdetector(CauldronsClick)
        end
    end
end
-- Anti Afk
if getconnections then
    for _, v in next, getconnections(game:GetService("Players").LocalPlayer.Idled) do
        v:Disable()
    end
end

if not getconnections then
    game:GetService("Players").LocalPlayer.Idled:connect(
        function()
            game:GetService("VirtualUser"):ClickButton2(Vector2.new())
        end
    )
end

local function brewPotion(recipe)
    for _, ingredient in ipairs(recipe) do
        local itemName, quantity = unpack(ingredient)
        for i = 1, quantity do
            equipItem(itemName)
            repeat
                task.wait()
            until lp.Character:FindFirstChild(itemName) or tick() - maxTime >= debounce
            if not lp.Character:FindFirstChild(itemName) then
                return
            end
        end
    end
    task.wait(0.1)
    getclicker()
end
--end

loadstring(game:HttpGet("https://raw.githubusercontent.com/Pixeluted/adoniscries/main/Source.lua",true))()

local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local Window = Fluent:CreateWindow({
    Title = "Fluent " .. Fluent.Version,
    SubTitle = "by dawid",
    TabWidth = 50,
    Size = UDim2.fromOffset(580, 460),
    Acrylic = true,
    Theme = "Dark"
})

local Tabs = {
    Main = Window:AddTab({ Title = "Main", Icon = "" }),
    Automatic = Window:AddTab({ Title = "Automation", Icon = "" }),
    Combat = Window:AddTab({ Title = "Combat", Icon = "" }),
    Teleports = Window:AddTab({ Title = "Teleports", Icon = "" }),
    Dupe = Window:AddTab({ Title = "Dupe", Icon = "" }),
    Settings = Window:AddTab({ Title = "Settings", Icon = "settings" }),
    Brew = Window:AddTab({ Title = "Auto Brew", Icon = ""})
}


Tabs.Main:AddButton({
    Title = "Pickup All Plants",
    Callback = function()
        local avoidCFrame = CFrame.new(1465.6145, 48.1683693, -3372.54272, -0.406715393, 0, -0.913554907, 0, 1, 0,
            0.913554907, 0, -0.406715393)
        local trinkets = {}
        local originalLocation = lp.Character.HumanoidRootPart.CFrame

        for _, Trinket in pairs(game:GetService("Workspace").SpawnedItems:GetDescendants()) do
            if Trinket:IsA("Part") and Trinket.Name == "ClickPart" and Trinket.CFrame ~= avoidCFrame then
                table.insert(trinkets, Trinket)
            end
        end

        for _, Trinket in ipairs(trinkets) do
            lp.Character.HumanoidRootPart.CFrame = Trinket.CFrame
            task.wait(0.35)
            for _, v in pairs(game:GetService("Workspace").SpawnedItems:GetDescendants()) do
                if v:IsA("ClickDetector") and lp:DistanceFromCharacter(v.Parent.Position) <= 10 then
                    fireclickdetector(v)
                end
            end
        end
        lp.Character.HumanoidRootPart.CFrame = originalLocation
    end
})



Tabs.Main:AddButton({
    Title = "Teleport To Merchant",
    Callback = function()
        if game:GetService("Workspace").NPCs:FindFirstChild("Mysterious Merchant") then
            lp.Character.HumanoidRootPart.CFrame = game:GetService("Workspace").NPCs:FindFirstChild(
                "Mysterious Merchant").HumanoidRootPart.CFrame
        else
            Fluent:Notify({
                Title = "Mysterious Merchant Has Not Spawned",
                Content = "Can't Teleport To Mysterious Merchant, Has Not Appeared",
                Duration = 5
            })
        end
    end
})

local Walk = 1.6
local Walkspeeder = false 

local Speed1 = Tabs.Main:AddToggle("Speed1", {Title = "Enable Sprint Speed", Default = false })

Speed1:OnChanged(function(Value)
    Walkspeeder = Value
    
    while Walkspeeder do
        task.wait()
        if lp.Character and lp.Character:FindFirstChild("Effects") and lp.Character.Effects:FindFirstChild("RunBuff") then
            lp.Character.Effects.RunBuff.Value = Walk 
        end
    end

    print("Toggle changed:", Value)
end)

Speed1:SetValue(false)


local Slider = Tabs.Main:AddSlider("Slider", {
    Title = "Speed Modificator",
    Content = "Change Sprint Speed",
    Default = 2,
    Min = 1,
    Max = 10,
    Rounding = 1,
    Callback = function(Value)
        Walk = Value
        if Walkspeeder then
            lp.Character.Effects.RunBuff.Value = Value
        end
    end
})
Slider:OnChanged(function(Value)
    print("Slider changed:", Value)
end)

Slider:SetValue(1)

function serverhop()
    local PlaceID = game.PlaceId
    local AllIDs = {}
    local foundAnything = ""
    local actualHour = os.date("!*t").hour
    local Deleted = false

    function TPReturner()
        local Site;
        if foundAnything == "" then
            Site = game.HttpService:JSONDecode(game:HttpGet('https://games.roblox.com/v1/games/' .. PlaceID .. '/servers/Public?sortOrder=Asc&limit=100'))
        else
            Site = game.HttpService:JSONDecode(game:HttpGet('https://games.roblox.com/v1/games/' .. PlaceID .. '/servers/Public?sortOrder=Asc&limit=100&cursor=' .. foundAnything))
        end
        local ID = ""
        if Site.nextPageCursor and Site.nextPageCursor ~= "null" and Site.nextPageCursor ~= nil then
            foundAnything = Site.nextPageCursor
        end
        local num = 0;
        for i,v in pairs(Site.data) do
            local Possible = true
            ID = tostring(v.id)
            if tonumber(v.maxPlayers) > tonumber(v.playing) then
                for _,Existing in pairs(AllIDs) do
                    if num ~= 0 then
                        if ID == tostring(Existing) then
                            Possible = false
                        end
                    else
                        if tonumber(actualHour) ~= tonumber(Existing) then
                            local delFile = pcall(function()
                                -- delfile("NotSameServers.json")
                                AllIDs = {}
                                table.insert(AllIDs, actualHour)
                            end)
                        end
                    end
                    num = num + 1
                end
                if Possible == true then
                    table.insert(AllIDs, ID)
                    wait()
                    pcall(function()
                        -- writefile("NotSameServers.json", game:GetService('HttpService'):JSONEncode(AllIDs))
                        wait()
                        game:GetService("TeleportService"):TeleportToPlaceInstance(PlaceID, ID, game.Players.LocalPlayer)
                    end)
                    wait(4)
                end
            end
        end
    end

    function Teleport()
        while wait() do
            pcall(function()
                TPReturner()
                if foundAnything ~= "" then
                    TPReturner()
                end
            end)
        end
    end

    Teleport()
end
Tabs.Main:AddButton({    
    Title = "Server Hop",
    Default = false,
Callback = function()
    serverhop()
end

})

local merchNotiEnabled = false

local merchant = Tabs.Main:AddToggle("merchant", {Title = "Mysterious Merchant Detector", Default = false})

merchant:OnChanged(function(value)
    merchNotiEnabled = value
    if merchNotiEnabled then
        while merchNotiEnabled do
            wait(1)
            local merchantNPC = game:GetService("Workspace").NPCs:FindFirstChild("Mysterious Merchant")
            if merchantNPC then
                Fluent:Notify({
                    Title = "Mysterious Merchant Detected",
                    Content = "The Mysterious Merchant Has Appeared!",
                    Duration = 5
                })
            end
            wait(10)
        end
    end
end)

merchant:SetValue(false)


game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Data"):WaitForChild("ClassMasteryData"):FireServer()
local playerGui = lp.PlayerGui
local classMastery = playerGui:WaitForChild("ClassMastery")
local main = classMastery:WaitForChild("Main")
local points = main:WaitForChild("Points")

local Mastery = Tabs.Main:AddToggle("Mastery1", {
    Title = "Check Mastery Tree Points", 
    Default = false,
    Flag = "MasteryPoints"
})

local function removeHTMLTags(text)
    return text:gsub("<[^>]+>", "")
end

Mastery:OnChanged(function(value)
    local MasteryPoints = value
    if MasteryPoints then
        local cleanText = removeHTMLTags(points.Text)
        Fluent:Notify({
            Title = "Soul Points",
            Content = cleanText,
            Duration = 10
        })
    end
end)

local MasteryPoint = Tabs.Main:AddToggle("Points", {
    Title = "Mastery Point Notifier", 
    Default = false,
    Flag = "MasteryNotifier"
})
MasteryPoint:OnChanged(function(value)
    Callback = function(Value)
        getgenv().MasteryNoti = Value
        lp.PlayerGui.ClassMastery.Main.Points:GetPropertyChangedSignal("Text"):Connect(function()
            if MasteryNoti then
                Fluent:Notify({
                    Title = "You Got Mastery Points ",
                    Duration = 10
                })
            end
        end)
    end
end)
local Floppa = false

function FloppaCollectItems()
    for _,v in pairs(workspace.Dropped:GetDescendants()) do
        if v.ClassName == "TouchTransmitter" then
            firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, v.Parent, 0) 
            firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, v.Parent, 1) 
        end
    end
end

local Steal = Tabs.Automatic:AddToggle("Steal", {Title = "Pickup Aura (Steal Items)", Default = false, Flag = "Floppa"})

Steal:OnChanged(function(Value)
    Floppa = Value
    if Floppa then
        while Floppa do
            FloppaCollectItems()
            task.wait()
        end
    end
end)
local AutoDodge = Tabs.Combat:AddToggle("AutoDodge", {Title = "AutoDodge", Default = false, Flag = "AutoDodge"}) 

AutoDodge:OnChanged(function(Value)
    getgenv().AutoDodge = Value
    if getgenv().AutoDodge then
        while getgenv().AutoDodge do
            task.wait()
            local Floppa1 = {
                [1] = true,
                [2] = true
            }
            local Floppa2 = "DodgeMinigame"
            game:GetService("ReplicatedStorage").Remotes.Information.RemoteFunction:FireServer(Floppa1, Floppa2)
            task.wait()
        end
    end
end)

local Autoblock = Tabs.Combat:AddToggle("Autoblock", {Title = "Autoblock", Default = false, Flag = "Autoblock"}) 

Autoblock:OnChanged(function(Value)
    getgenv().Autoblock = Value
    if getgenv().Autoblock then
        while getgenv().Autoblock do
            task.wait()
            local Floppa1 = {
                [1] = true,
                [2] = false
            }
            local Floppa2 = "DodgeMinigame"
            game:GetService("ReplicatedStorage").Remotes.Information.RemoteFunction:FireServer(Floppa1, Floppa2)
            task.wait()
        end
    end
end)

-- Thorian Minigame
local Thorian = Tabs.Automatic:AddToggle("Thorian", {Title = "Auto-Minigame Thorian", Default = false, Flag = "AutOFloppa" })
Thorian:OnChanged(function(Value) 
    getgenv().AutOFloppa = Value 
    while getgenv().AutOFloppa and game:GetService("Workspace").Living[lp.Name]:WaitForChild("FightInProgress") do 
        task.wait() 
        local Floppa1 = { 
            [1] = true, 
            [2] = true 
        }
        local Floppa2 = "ThorianQTE"
        game:GetService("ReplicatedStorage").Remotes.Information.RemoteFunction:FireServer(Floppa1, Floppa2) 
        task.wait()
    end
end)

local InstaQte = Tabs.Combat:AddToggle("InstaQte", {Title = "Insta Auto-QTE", Default = false, Flag = "AutoQTE" })

InstaQte:OnChanged(function(Value)
    getgenv().AutoQTE = Value
    local BaseClass = lp.PlayerGui.StatMenu.Holder.ContentFrame.Stats.Body.RightColumn.Content.BaseClass.Type.Text
    while getgenv().AutoQTE do
        task.wait()
        if BaseClass == "Wizard" then
            local Floppa1 = true
            local Floppa2 = "MagicQTE"
            game:GetService("ReplicatedStorage").Remotes.Information.RemoteFunction:FireServer(Floppa1, Floppa2)
            lp.PlayerGui.Combat.MagicQTE.Visible = false
        elseif BaseClass == "Thief" then
            local Floppa1 = true
            local Floppa2 = "DaggerQTE"
            game:GetService("ReplicatedStorage").Remotes.Information.RemoteFunction:FireServer(Floppa1, Floppa2)
            lp.PlayerGui.Combat.DaggerQTE.Visible = false
        elseif BaseClass == "Slayer" then
            local Floppa1 = true
            local Floppa2 = "SpearQTE"
            game:GetService("ReplicatedStorage").Remotes.Information.RemoteFunction:FireServer(Floppa1, Floppa2)
            lp.PlayerGui.Combat.SpearQTE.Visible = false
        elseif BaseClass == "Martial Artist" then
            local Floppa1 = true
            local Floppa2 = "FistQTE"
            game:GetService("ReplicatedStorage").Remotes.Information.RemoteFunction:FireServer(Floppa1, Floppa2)
            lp.PlayerGui.Combat.FistQTE.Visible = false
        elseif BaseClass == "Warrior" then
            local Floppa1 = true
            local Floppa2 = "SwordQTE"
            game:GetService("ReplicatedStorage").Remotes.Information.RemoteFunction:FireServer(Floppa1, Floppa2)
            lp.PlayerGui.Combat.SwordQTE.Visible = false
        end
    end
end)

local Legit = Tabs.Combat:AddToggle("Legit", {Title = "Legit AutoQTE", Default = false, Flag = "Value"})

Legit:OnChanged(function(Value)
    local LegitTimer = 2.5

local baseToString = {
    ["Wizard"] = "MagicQTE", 
    ["Thief"] = "DaggerQTE", 
    ["Slayer"] = "SpearQTE", 
    ["Matrial Artist"] = "FistQTE", 
    ["Warrior"] = "SwordQTE"
}
local replicatedStorage = game:GetService("ReplicatedStorage")
local players = game:GetService("Players")
local player = players.LocalPlayer 

local remotes = replicatedStorage:WaitForChild("Remotes")
local actionRemote = remotes:WaitForChild("Information"):WaitForChild("RemoteFunction")

local playerClass, breakTimer = nil, tick()
while task.wait() do 
    local result, class = pcall(function()
        return player.PlayerGui.StatMenu.Holder.ContentFrame.Stats.Body.RightColumn.Content.BaseClass.Type.Text
    end)
    if class then 
        playerClass = class
        break 
    end 
    if breakTimer-tick() >= 30 then 
        break 
    end
end 

if not playerClass or playerClass == "None" then 
    warn("Player has no class!")
    return
end 
print(playerClass)

local classTranslation = baseToString[playerClass]
local classUi = player.PlayerGui.Combat[classTranslation]

classUi:GetPropertyChangedSignal("Visible"):Connect(function()
    local newValue = classUi.Visible 
    if newValue then 
        classUi.Visible = false
        task.wait(math.clamp(LegitTimer, 0.1, 2.5))
        actionRemote:FireServer(true, classTranslation)
    end 
end)
end)

local NoFall = Tabs.Teleports:AddToggle("NoFall", {Title = "No Fall-DMG (This will Make you safe for Tp)", Default = true,Flag = "NoFall" })

NoFall:OnChanged(function()
    Callback = function(Value)
        getgenv().NoFall = (Value)

        local OldNameCall = nil
        OldNameCall = hookmetamethod(game, "__namecall", function(self,...)
            local Arg = {... }
            if self.Name == "EnviroEffects" and getgenv().NoFall then
                return
            end
            return OldNameCall(self,...)
        end)
    end
end)

local Dropdown = Tabs.Teleports:AddDropdown("Dropdown", {
    Title = "Spawns/Zones",
    Values = {"Level Up Room", "Caldera", "Ruins/Sand Town","Volcano (Dragon Door)","Thorian Door","Way of Life (Covenant)","Blades Of World (Covenant)","Fractured Realm","Tundra Door"},
    Multi = false,
    Default = 0,
})

Dropdown:OnChanged(function(Value)
    local lp = game.Players.LocalPlayer
    
    if Value == "Caldera" then
        local Vector3End = Vector3.new(-221.396332, 46.5463257, -3328.51367)
        local Time = 0
        local tween = game:GetService("TweenService"):Create(lp.Character.HumanoidRootPart,
            TweenInfo.new(Time), { CFrame = CFrame.new(Vector3End) })
        tween:Play()
    elseif Value == "Ruins/Sand Town" then
        local Vector3End = Vector3.new(-2405.2, 42.8, -2977.7)
        local Time = 0
        local tween = game:GetService("TweenService"):Create(lp.Character.HumanoidRootPart,
            TweenInfo.new(Time), { CFrame = CFrame.new(Vector3End) })
        tween:Play()
    elseif Value == "Way of Life (Covenant)" then
        local Vector3End = Vector3.new(2612.2, 354.0, -3293.0)
        local Time = 0
        local tween = game:GetService("TweenService"):Create(lp.Character.HumanoidRootPart,
            TweenInfo.new(Time), { CFrame = CFrame.new(Vector3End) })
        tween:Play()
    elseif Value == "Blades Of World (Covenant)" then
        local Vector3End = Vector3.new(-2830.5, -35.4, -2118.4)
        local Time = 0
        local tween = game:GetService("TweenService"):Create(lp.Character.HumanoidRootPart,
            TweenInfo.new(Time), { CFrame = CFrame.new(Vector3End) })
        tween:Play()
    elseif Value == "Fractured Realm" then
        local Vector3End = Vector3.new(160.5, 232.1, 1192.0)
        local Time = 0
        local tween = game:GetService("TweenService"):Create(lp.Character.HumanoidRootPart,
            TweenInfo.new(Time), { CFrame = CFrame.new(Vector3End) })
        tween:Play()
    elseif Value == "Volcano (Dragon Door)" then
        local Vector3End = Vector3.new(-4768, 51, -3424)
        local Time = 0
        local tween = game:GetService("TweenService"):Create(lp.Character.HumanoidRootPart,
            TweenInfo.new(Time), { CFrame = CFrame.new(Vector3End) })
        tween:Play()
    elseif Value == "Tundra Door" then
        local Vector3End = Vector3.new(-17, 293, -5999)
        local Time = 0
        local tween = game:GetService("TweenService"):Create(lp.Character.HumanoidRootPart,
            TweenInfo.new(Time), { CFrame = CFrame.new(Vector3End) })
        tween:Play()
    elseif Value == "Level Up Room" then
        local Vector3End = Vector3.new(789, 235, 2121)
        local Time = 0
        local tween = game:GetService("TweenService"):Create(lp.Character.HumanoidRootPart,
            TweenInfo.new(Time), { CFrame = CFrame.new(Vector3End) })
        tween:Play()
    elseif Value == "Thorian Door" then
        local Vector3End = Vector3.new(2235, 24, -373)
        local Time = 0
        local tween = game:GetService("TweenService"):Create(lp.Character.HumanoidRootPart,
            TweenInfo.new(Time), { CFrame = CFrame.new(Vector3End) })
        tween:Play()
    end
end)

local DropdownMisc = Tabs.Teleports:AddDropdown("DropdownMisc", {
    Title = "Misc",
    Values = {"Floppa (Thanasius)", "BlackSmith", "Mark Npc", "Sería(alchemist)", "Merchant(Item Seller)", "Atalar(Shard Fusioner)", "Doctor(westwood)", "The SoulMaster", "Floppa Doctor"},
    Multi = false,
    Default = 0,
})

DropdownMisc:OnChanged(function(Value)
    local lp = game.Players.LocalPlayer

    if Value == "BlackSmith" then
        local Vector3End = Vector3.new(2633.7, 386.4, -3687.0)
        local Time = 0
        local tween = game:GetService("TweenService"):Create(lp.Character.HumanoidRootPart,
            TweenInfo.new(Time), { CFrame = CFrame.new(Vector3End) })
        tween:Play()
    elseif Value == "Mark Npc" then
        local Vector3End = Vector3.new(-67.9, 42.9, -3280.7)
        local Time = 0
        local tween = game:GetService("TweenService"):Create(lp.Character.HumanoidRootPart,
            TweenInfo.new(Time), { CFrame = CFrame.new(Vector3End) })
        tween:Play()
    elseif Value == "Sería(alchemist)" then
        local Vector3End = Vector3.new(2585.1, 386.3, -4027.0)
        local Time = 0
        local tween = game:GetService("TweenService"):Create(lp.Character.HumanoidRootPart,
            TweenInfo.new(Time), { CFrame = CFrame.new(Vector3End) })
        tween:Play()
    elseif Value == "Merchant(Item Seller)" then
        local Vector3End = Vector3.new(-147.9, 43.5, -3449.0)
        local Time = 0
        local tween = game:GetService("TweenService"):Create(lp.Character.HumanoidRootPart,
            TweenInfo.new(Time), { CFrame = CFrame.new(Vector3End) })
        tween:Play()
    elseif Value == "Atalar(Shard Fusioner)" then
        local Vector3End = Vector3.new(-367, 44, -3385)
        local Time = 0
        local tween = game:GetService("TweenService"):Create(lp.Character.HumanoidRootPart,
            TweenInfo.new(Time), { CFrame = CFrame.new(Vector3End) })
        tween:Play()
    elseif Value == "Doctor(westwood)" then
        local Vector3End = Vector3.new(2518.4, 386.3, -3625.0)
        local Time = 0
        local tween = game:GetService("TweenService"):Create(lp.Character.HumanoidRootPart,
            TweenInfo.new(Time), { CFrame = CFrame.new(Vector3End) })
        tween:Play()
    elseif Value == "Floppa Doctor" then
        local Vector3End = Vector3.new(-1838.1, 47.5, -3187.6)
        local Time = 0
        local tween = game:GetService("TweenService"):Create(lp.Character.HumanoidRootPart,
            TweenInfo.new(Time), { CFrame = CFrame.new(Vector3End) })
        tween:Play()
    elseif Value == "Floppa (Thanasius)" then
        local Vector3End = Vector3.new(1695, 12, -1654)
        local Time = 0
        local tween = game:GetService("TweenService"):Create(lp.Character.HumanoidRootPart,
            TweenInfo.new(Time), { CFrame = CFrame.new(Vector3End) })
        tween:Play()
    end
end)

-- Dropdown for Enchants
local DropdownEnchants = Tabs.Teleports:AddDropdown("DropdownEnchants", {
    Title = "Enchants",
    Values = { "Inferno Enchant Trigger", "Inferno Enchant End", "Reaper Enchant", "Midas Enchant", "Lifesong Enchant", "Cursed Enchant" },
    Multi = false,
    Default = 0,
})

DropdownEnchants:OnChanged(function(Value)
    local lp = game.Players.localPlayer

    if Value == "Inferno Enchant Trigger" then
        local Vector3End = Vector3.new(-4344, 74, -2090)
        local Time = 0
        local tween = game:GetService("TweenService"):Create(lp.Character.HumanoidRootPart,
            TweenInfo.new(Time), { CFrame = CFrame.new(Vector3End) })
        tween:Play()
    elseif Value == "Inferno Enchant End" then
        local Vector3End = Vector3.new(-4340, 67, -1587)
        local Time = 0
        local tween = game:GetService("TweenService"):Create(lp.Character.HumanoidRootPart,
            TweenInfo.new(Time), { CFrame = CFrame.new(Vector3End) })
        tween:Play()
    elseif Value == "Reaper Enchant" then
        local Vector3End = Vector3.new(-2402, 47, -3718)
        local Time = 0
        local tween = game:GetService("TweenService"):Create(lp.Character.HumanoidRootPart,
            TweenInfo.new(Time), { CFrame = CFrame.new(Vector3End) })
        tween:Play()
    elseif Value == "Midas Enchant" then
        local Vector3End = Vector3.new(-293, 44, -3176)
        local Time = 0
        local tween = game:GetService("TweenService"):Create(lp.Character.HumanoidRootPart,
            TweenInfo.new(Time), { CFrame = CFrame.new(Vector3End) })
        tween:Play()
    elseif Value == "Lifesong Enchant" then
        local Vector3End = Vector3.new(5988, 53, -3467)
        local Time = 0
        local tween = game:GetService("TweenService"):Create(lp.Character.HumanoidRootPart,
            TweenInfo.new(Time), { CFrame = CFrame.new(Vector3End) })
        tween:Play()
    elseif Value == "Cursed Enchant" then
        local Vector3End = Vector3.new(1651, 54, -3480)
        local Time = 0
        local tween = game:GetService("TweenService"):Create(lp.Character.HumanoidRootPart,
            TweenInfo.new(Time), { CFrame = CFrame.new(Vector3End) })
        tween:Play()
    end
end)

-- Dropdown for Base Class Trainer
local DropdownBaseClass = Tabs.Teleports:AddDropdown("DropdownBaseClass", {
    Title = "Base Class Trainer",
    Values = { "Ysa(Warrior)", "Tivek (Spear)", "Boots(Thief)", "Arandor(Wizard)", "Doran(Martial Artist)" },
    Multi = false,
    Default = 0,
})

DropdownBaseClass:OnChanged(function(Value)
    local lp = game.Players.LocalPlayer

    if Value == "Doran(Martial Artist)" then
        local Vector3End = Vector3.new(483, 117, -2653)
        local Time = 0
        local tween = game:GetService("TweenService"):Create(lp.Character.HumanoidRootPart,
            TweenInfo.new(Time), { CFrame = CFrame.new(Vector3End) })
        tween:Play()
    elseif Value == "Arandor(Wizard)" then
        local Vector3End = Vector3.new(593.8, 124.1, -3608.0)
        local Time = 0
        local tween = game:GetService("TweenService"):Create(lp.Character.HumanoidRootPart,
            TweenInfo.new(Time), { CFrame = CFrame.new(Vector3End) })
        tween:Play()
    elseif Value == "Tivek (Spear)" then
        local Vector3End = Vector3.new(657.7, 97.2, -3984.5)
        local Time = 0
        local tween = game:GetService("TweenService"):Create(lp.Character.HumanoidRootPart,
            TweenInfo.new(Time), { CFrame = CFrame.new(Vector3End) })
        tween:Play()
    elseif Value == "Ysa(Warrior)" then
        local Vector3End = Vector3.new(-472.4, 42.9, -3283.1)
        local Time = 0
        local tween = game:GetService("TweenService"):Create(lp.Character.HumanoidRootPart,
            TweenInfo.new(Time), { CFrame = CFrame.new(Vector3End) })
        tween:Play()
    elseif Value == "Boots(Thief)" then
        local Vector3End = Vector3.new(-423.1, 42.9, -3529.1)
        local Time = 0
        local tween = game:GetService("TweenService"):Create(lp.Character.HumanoidRootPart,
            TweenInfo.new(Time), { CFrame = CFrame.new(Vector3End) })
        tween:Play()
    end
end)

-- Dropdown for Super Class Trainer (Chaotic)
local DropdownSuperClassChaotic = Tabs.Teleports:AddDropdown("DropdownSuperClassChaotic", {
    Title = "Super Class Trainer (Chaotic)",
    Values = { "DarkFist Trainer", "Berserker Trainer", "Ulys(Necromancer)", "Orín(Impaler)", "Inette(Assassin)" },
    Multi = false,
    Default = 0,
})

DropdownSuperClassChaotic:OnChanged(function(Value)
    local lp = game.Players.LocalPlayer

    if Value == "DarkFist Trainer" then
        local Vector3End = Vector3.new(1955.6, 32.3, -1420.0)
        local Time = 0
        local tween = game:GetService("TweenService"):Create(lp.Character.HumanoidRootPart,
            TweenInfo.new(Time), { CFrame = CFrame.new(Vector3End) })
        tween:Play()
    elseif Value == "Berserker Trainer" then
        local Vector3End = Vector3.new(5349.8, -91.3, -3255.6)
        local Time = 0
        local tween = game:GetService("TweenService"):Create(lp.Character.HumanoidRootPart,
            TweenInfo.new(Time), { CFrame = CFrame.new(Vector3End) })
        tween:Play()
    elseif Value == "Ulys(Necromancer)" then
        local Vector3End = Vector3.new(5950.9, 53.8, -2858.0)
        local Time = 0
        local tween = game:GetService("TweenService"):Create(lp.Character.HumanoidRootPart,
            TweenInfo.new(Time), { CFrame = CFrame.new(Vector3End) })
        tween:Play()
    elseif Value == "Orín(Impaler)" then
        local Vector3End = Vector3.new(2319.5, 385.7, -3622.0)
        local Time = 0
        local tween = game:GetService("TweenService"):Create(lp.Character.HumanoidRootPart,
            TweenInfo.new(Time), { CFrame = CFrame.new(Vector3End) })
        tween:Play()
    elseif Value == "Inette(Assassin)" then
        local Vector3End = Vector3.new(1181.3, -7.5, -2311.1)
        local Time = 0
        local tween = game:GetService("TweenService"):Create(lp.Character.HumanoidRootPart,
            TweenInfo.new(Time), { CFrame = CFrame.new(Vector3End) })
        tween:Play()
    end
end)
-- Dropdown para Super Class Trainer (Oderly)
local DropdownSuperClassOderly = Tabs.Teleports:AddDropdown("DropdownSuperClassOderly", {
    Title = "Super Class Trainer (Oderly)",
    Values = {
        "Paladin Trainer", "Luther(Monk)", "Fernain(Saint)", "Landrum(Elementalist)", "Orkin(Ranger)"
    },
    Multi = false,
    Default = 0,
})

DropdownSuperClassOderly:OnChanged(function(Value)
    local lp = game.Players.localPlayer

    -- Casos para la clase Oderly
    if Value == "Paladin Trainer" then
        local Vector3End = Vector3.new(-2515.8, 43.1, -2958.2)
        local Time = 0
        local tween = game:GetService("TweenService"):Create(lp.Character.HumanoidRootPart,
            TweenInfo.new(Time), { CFrame = CFrame.new(Vector3End) })
        tween:Play()

    elseif Value == "Luther(Monk)" then
        local Vector3End = Vector3.new(-1693.2, 114.9, -2942.3)
        local Time = 0
        local tween = game:GetService("TweenService"):Create(lp.Character.HumanoidRootPart,
            TweenInfo.new(Time), { CFrame = CFrame.new(Vector3End) })
        tween:Play()

    elseif Value == "Fernain(Saint)" then
        local Vector3End = Vector3.new(-2663.9, 121.9, -3432.0)
        local Time = 0
        local tween = game:GetService("TweenService"):Create(lp.Character.HumanoidRootPart,
            TweenInfo.new(Time), { CFrame = CFrame.new(Vector3End) })
        tween:Play()

    elseif Value == "Landrum(Elementalist)" then
        local Vector3End = Vector3.new(-2572.7, 42.7, -2485.6)
        local Time = 0
        local tween = game:GetService("TweenService"):Create(lp.Character.HumanoidRootPart,
            TweenInfo.new(Time), { CFrame = CFrame.new(Vector3End) })
        tween:Play()

    elseif Value == "Orkin(Ranger)" then
        local Vector3End = Vector3.new(2588.2, 386.3, -3175.8)
        local Time = 0
        local tween = game:GetService("TweenService"):Create(lp.Character.HumanoidRootPart,
            TweenInfo.new(Time), { CFrame = CFrame.new(Vector3End) })
        tween:Play()
    end
end)
-- Dropdown para Super Class Trainer (Neutral)
local DropdownSuperClassNeutral = Tabs.Teleports:AddDropdown("DropdownSuperClassNeutral", {
    Title = "Super Class Trainer (Neutral)",
    Values = {
        "Gren(Brawler)", "Aberon(Rogue)", "Relan(Lancer)", "Leoran(Blade dancer)", "Ophelia(Hexer)"
    },
    Multi = false,
    Default = 0,
})

DropdownSuperClassNeutral:OnChanged(function(Value)
    local lp = game.Players.LocalPlayer 

    -- Casos para la clase Neutral
    if Value == "Gren(Brawler)" then
        local Vector3End = Vector3.new(235.3, 98.6, -4652.1)
        local Time = 0
        local tween = game:GetService("TweenService"):Create(lp.Character.HumanoidRootPart,
            TweenInfo.new(Time), { CFrame = CFrame.new(Vector3End) })
        tween:Play()

    elseif Value == "Aberon(Rogue)" then
        local Vector3End = Vector3.new(-2505.9, 43.6, -2862.3)
        local Time = 0
        local tween = game:GetService("TweenService"):Create(lp.Character.HumanoidRootPart,
            TweenInfo.new(Time), { CFrame = CFrame.new(Vector3End) })
        tween:Play()

    elseif Value == "Relan(Lancer)" then
        local Vector3End = Vector3.new(-58.9, 159.1, -5605.8)
        local Time = 0
        local tween = game:GetService("TweenService"):Create(lp.Character.HumanoidRootPart,
            TweenInfo.new(Time), { CFrame = CFrame.new(Vector3End) })
        tween:Play()

    elseif Value == "Leoran(Blade dancer)" then
        local Vector3End = Vector3.new(61.6, 113.5, -5364.3)
        local Time = 0
        local tween = game:GetService("TweenService"):Create(lp.Character.HumanoidRootPart,
            TweenInfo.new(Time), { CFrame = CFrame.new(Vector3End) })
        tween:Play()

    elseif Value == "Ophelia(Hexer)" then
        local Vector3End = Vector3.new(-658.9, 42.7, -4196.1)
        local Time = 0
        local tween = game:GetService("TweenService"):Create(lp.Character.HumanoidRootPart,
            TweenInfo.new(Time), { CFrame = CFrame.new(Vector3End) })
        tween:Play()
    end
end)
-- Dropdown para Mark Portals
local DropdownMarkPortals = Tabs.Teleports:AddDropdown("DropdownMarkPortals", {
    Title = "Mark Portals",
    Values = {
        "Venia Orb 1", "Venia Orb 2", "Venia Orb 3", "Venia Orb 4"
    },
    Multi = false,
    Default = 0,
})

DropdownMarkPortals:OnChanged(function(Value)
    local lp = game.Players.LocalPlayer 

    -- Casos para Mark Portals
    if Value == "Venia Orb 1" then
        local Vector3End = Vector3.new(-3174, -45, -2428)
        local Time = 0
        local tween = game:GetService("TweenService"):Create(lp.Character.HumanoidRootPart,
            TweenInfo.new(Time), { CFrame = CFrame.new(Vector3End) })
        tween:Play()

    elseif Value == "Venia Orb 2" then
        local Vector3End = Vector3.new(1709, 35, -2825)
        local Time = 0
        local tween = game:GetService("TweenService"):Create(lp.Character.HumanoidRootPart,
            TweenInfo.new(Time), { CFrame = CFrame.new(Vector3End) })
        tween:Play()

    elseif Value == "Venia Orb 3" then
        local Vector3End = Vector3.new(463, 138, -2683)
        local Time = 0
        local tween = game:GetService("TweenService"):Create(lp.Character.HumanoidRootPart,
            TweenInfo.new(Time), { CFrame = CFrame.new(Vector3End) })
        tween:Play()

    elseif Value == "Venia Orb 4" then
        local Vector3End = Vector3.new(-46, 293, -5944)
        local Time = 0
        local tween = game:GetService("TweenService"):Create(lp.Character.HumanoidRootPart,
            TweenInfo.new(Time), { CFrame = CFrame.new(Vector3End) })
        tween:Play()
    end
end)

local Pociones = Tabs.Brew:AddDropdown("Potions", {
    Title = "Auto Brew Potions",
    Values = {
        "Small Healing Potion", "Medium Healing Potion", "Minor Energy Elixir", "Average Energy Elixir", 
        "Minor Empowering Elixir", "Minor Absorbing Potion", "Ferrus Skin Potion", "Invisibility Potion", 
        "Light of Grace", "Heartbreaking Elixir", "Heartsoothing Remedy", "Abhorrent Elixir", "Alluring Elixir"
    },
    Multi = false,
    Default = 0,
    Callback = function(Value)
        Potion = Value
    end
})

local Toggle = Tabs.Dupe:AddToggle("Potions", {Title = "Enable Auto Brew", Default = false })

Toggle:OnChanged(function(state)
    getgenv().AutoBrew = state  -- Usa el estado del toggle para activar o desactivar
    while getgenv().AutoBrew do
        lp.Character.HumanoidRootPart.CFrame = CFrame.new(
            2659.95288, 389.135986, -3946.76294, 
            0.993850768, 4.01330915e-08, 0.110727936, 
            -4.54039046e-08, 1, 4.50799895e-08, 
            -0.110727936, -4.98302626e-08, 0.993850768
        )
        
        task.wait(0.3)

        local recipe = potionRecipes[Potion]
        if recipe then
            local canBrew = true
            for _, ingredient in ipairs(recipe) do
                local itemName = unpack(ingredient)
                if not lp.Backpack.Tools:FindFirstChild(itemName) then
                    canBrew = false
                    Fluent:Notify({
                        Title = "Missing Required Ingredient For:",
                        Content = tostring(Potion),
                        Duration = 10
                    })
                    break
                end
            end

            if canBrew then
                brewPotion(recipe)
            end
        end
        if not getgenv().AutoBrew then
            break
        end
    end
end)


-- Rejoin
Tabs.Dupe:AddButton({
    Title = "Rejoin",
    Callback = function()
        game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, game.JobId, game:GetService("Players").LocalPlayer)
    end
})

local FireServer = senv._G.FireServer
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local remote = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("Data"):WaitForChild("UpdateHotbar")

local Toggle = Tabs.Dupe:AddToggle("MyToggle", {Title = "Enable Rollback", Default = false })

local toggleState = false

Toggle:OnChanged(function(state)
    if state ~= toggleState then
        toggleState = state
        if toggleState then
            coroutine.wrap(function()
                while toggleState do
                    task.wait()
                    FireServer(remote, {[255] = "\255"})
                    FireServer(remote, {[2] = "\255"})
                    print("Rollback Setup")
                end
            end)()
        end
    end
end)





local itemListDropdown = Tabs.Dupe:AddDropdown("Select Item", {
    Title = "Select an item to drop",
    Values = GetUniqueToolNames(),
    Multi = false,
})

-- Refresh button
Tabs.Dupe:AddButton({
    Title = "Refresh",
    Callback = function()
        itemListDropdown:SetValues(GetUniqueToolNames())
        itemListDropdown:SetValue("") 
    end
})

local currentItem = ""
local Dropitem = Tabs.Dupe:AddToggle("Dropitem", {Title = "Drop Item", Default = false})

Dropitem:OnChanged(function(Value)
    variables["DropToggle"] = Value
    if Value then
        currentItem = itemListDropdown.Value
        coroutine.wrap(function()
            while variables["DropToggle"] do
                task.wait()
                if currentItem ~= itemListDropdown.Value then
                    currentItem = itemListDropdown.Value
                end
                if currentItem ~= "" then
                    inventoryRemote:FireServer("Drop", currentItem)
                end
            end
        end)()
    end
end)

local Floppa = false
local inventory = Tabs.Dupe:AddToggle("inventory", {Title = "Drop All Inventory", Default = false, Flag = "Floppa"})

inventory:OnChanged(function(Value)
    Floppa = Value
    if Floppa then
        coroutine.wrap(function()
            while Floppa do
                task.wait()
                for _, item in ipairs(GetUniqueToolNames()) do
                    inventoryRemote:FireServer("Drop", item)
                end
            end
        end)()
    end
end)

-- Resetting the toggle states (if necessary)
Dropitem:SetValue(false)
inventory:SetValue(false)



local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/SaveManager.lua"))()
local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/UnknowsitoTheBerst/Interface/refs/heads/main/InterfaceFloppa.lua"))()

SaveManager:SetLibrary(Fluent)
InterfaceManager:SetLibrary(Fluent)

SaveManager:IgnoreThemeSettings()
SaveManager:SetIgnoreIndexes({})

InterfaceManager:SetFolder("FluentScriptHub")
SaveManager:SetFolder("FluentScriptHub/specific-game")

InterfaceManager:BuildInterfaceSection(Tabs.Settings)
SaveManager:BuildConfigSection(Tabs.Settings)

Window:SelectTab(1)

SaveManager:LoadAutoloadConfig()
