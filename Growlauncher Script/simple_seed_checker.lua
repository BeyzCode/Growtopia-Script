seedname = "pepper tree seed" --change this
seedid = FindItemID(seedname) -- 881 wheat seed 4585 pepper

harvestable = 0
unharvestable = 0


for _, tile in pairs(GetTiles()) do
    if (tile.fg == seedid and tile.readyharvest == 1) then
        harvestable = harvestable + 1
    elseif (tile.fg == seedid and tile.readyharvest < 1) then
        unharvestable = unharvestable + 1
    end
end

LogToConsole("Seed Selected: "..seedname.." ID: "..FindItemID(seedname))
LogToConsole("Harvestable: "..harvestable)
LogToConsole("Unharvestable: "..unharvestable)
LogToConsole("Total: "..harvestable+unharvestable)