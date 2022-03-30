breaking = true;

function break_tile(x, y)
id = GetTiles(x, y)
if id ~= 0 then
hit_tile(x, y)
Sleep(40)
id = GetTiles(x, y)
Sleep(40)
end
end

function CheckCaveBackground()
for _, tile in pairs(GetTiles()) do
if tile.fg ~= 8 or tile.fg ~= 3760 then
if tile.bg == 14 then
if GetTiles(tile.x, tile.y - 2).fg == 0 then
FindPath(tile.x, tile.y - 2)
Sleep(90)
break_tile(tile.x, tile.y)
return true
else if GetTiles(tile.x, tile.y - 2).fg == 0 then
FindPath(tile.x, tile.y - 2)
Sleep(90)
break_tile(tile.x, tile.y)
return true
end
end
end
end
end
return false
end

function hit_tile(x, y)
pkt = {}
pkt.type = 3
pkt.value = 18
pkt.px = x
pkt.py = y
pkt.x = GetLocal().posX
pkt.y = GetLocal().posY
SendPacketRaw(false, pkt)
end
function main()
while breaking do
breaking = true
while breaking do
breaking = CheckCaveBackground()
end
end
end
main()