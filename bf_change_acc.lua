local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")
local config = HttpService:JSONDecode(readfile("blox_fruit.json"))
local player = Players.LocalPlayer
local data = player:WaitForChild("Data", 9e9)
local Level = data:WaitForChild("Level", 9e9)
local Beli = data:WaitForChild("Beli", 9e9)
local Fragments = data:WaitForChild("Fragments", 9e9)
getgenv().file_name = player.Name .. ".txt"
getgenv().content = "completed-" .. player.Name
local config_count = 0
local function check_item(item,inventory)
  for _,v in inventory do
    if v.Name == item then
      return true
    end
  end
  return false
end
for _ in pairs(config) do config_count = config_count + 1 end
while task.wait(30) do
    local Level_value = Level.Value
    local Beli_value = Beli.Value
    local Fragments_value = Fragments.Value
    local success = {}
    local Godhuman = game.ReplicatedStorage.Remotes.CommF_:InvokeServer("BuyGodhuman", true)
    local inventory = game.ReplicatedStorage.Remotes.CommF_:InvokeServer("getInventory")
    for k, v in pairs(config) do
        if k == "Level" and Level_value >= v then
          table.insert(success, "Level")
        elseif k == "Beli" and Beli_value >= v then
          table.insert(success, "Beli")
        elseif k == "Fragments" and Fragments_value >= v then
          table.insert(success, "Fragments")
        elseif k == "Godhuman" and Godhuman then
          table.insert(success, "Godhuman")
        elseif k == "Cursed Dual Katana" and check_item("Cursed Dual Katana",inventory) then
          table.insert(success, "Cursed Dual Katana")
        elseif k == "Hallow Scythe" and check_item("Hallow Scythe",inventory) then
          table.insert(success, "Hallow Scythe")
        elseif k == "Mirror Fractal" and check_item("Mirror Fractal",inventory) then
          table.insert(success, "Mirror Fractal")
        elseif k == "Valkyrie Helm" and check_item("Valkyrie Helm",inventory) then
          table.insert(success, "Valkyrie Helm")
        elseif k == "Soul Guitar" and check_item("Soul Guitar",inventory) then
          table.insert(success, "Soul Guitar")
        elseif k == "True Triple Katana" and check_item("True Triple Katana",inventory) then
          table.insert(success, "True Triple Katana")
        elseif k == "Shark Anchor" and check_item("Shark Anchor",inventory) then
          table.insert(success, "Shark Anchor")
        end
    end
    if config_count == #success then
        local s, e = pcall(function()
            writefile(getgenv().file_name, getgenv().content)
        end)
        if not s then
            warn("Error while write file: ", e)
        else
            print("Success write file: ", player.Name)
            break
        end
    end
end
