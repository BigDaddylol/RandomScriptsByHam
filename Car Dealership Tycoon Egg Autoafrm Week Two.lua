local function afkidle()
    game:service("VirtualUser"):CaptureController()
    game:service("VirtualUser"):ClickButton2(Vector2.new())
end

game:service("Players").LocalPlayer.Idled:Connect(afkidle)

while wait(1) do
    if game:GetService("Players").LocalPlayer.PlayerGui.EggHuntGuide.Enabled == true then
        if game.Players.LocalPlayer.Character.Humanoid.SeatPart ~= nil then
            game.Players.LocalPlayer.Character.Humanoid.Jump = true
            game:GetService("ReplicatedStorage").Remotes.ExitSeat:FireServer()
        end
        wait(0.6)
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.ReplicatedStorage.EggGuidePart.CFrame
        wait(0.2)
        for i, v in pairs(game.Workspace.MagicEgg:GetChildren()) do
            if v:FindFirstChild("MagicEgg") and v.Active.Value == true then
                game:GetService("ReplicatedStorage").Remotes.CollectPart:FireServer(unpack({[1] = workspace.MagicEgg[v.Name].MagicEgg}))
            end
        end
        wait(0.2)
        for o, b in pairs(game.Workspace.Tycoons:GetChildren()) do
            if b.Owner.Value == game.Players.LocalPlayer.Name then
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = b.Base.CFrame + Vector3.new(0,3,0)
            end
        end
    end
end
