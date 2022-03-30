Item = "Laser Grid Seed" -- Item Name
Delay = 150 -- Delay Harvest

function ARR(x, y)
arr = {}
arr.type = 3
arr.px = x
arr.py = y
arr.x = GetLocal().posX
arr.y = GetLocal().posY
arr.value = 18
SendPacketRaw(false, arr)
main()
end

function CheckSeed()
for _, tile in pairs (GetTiles()) do
if tile.fg == ItemID and tile.readyharvest == 1 then
FindPath(tile.x, tile.y)
Sleep(Delay + 200)
ARR(tile.x, tile.y)
Sleep(Delay + 20)
end
end
end

function main()
CheckSeed()
Sleep(100)
end

ItemID = FindItemID(Item)
main()