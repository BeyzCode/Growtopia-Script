Item = "Dirt Seed"
gl = FindItemID(Item)

function place(x, y, id)
mgl = {}
mgl.px = x
mgl.py = y
mgl.x = GetLocal().posX
mgl.y = GetLocal().posY
mgl.type = 3
mgl.value = gl
SendPacketRaw(false, mgl)
end

function LihatSeed()
for _, tile in pairs (GetTiles()) do
if tile.fg == 2 and GetTiles(tile.x, tile.y - 1).fg == 0 then
FindPath(tile.x, tile.y - 1)
Sleep(200)
place(tile.x, tile.y - 1)
Sleep(200)
end
end
end

function OnSendMessage(message)
if (message == "action|input\n|text|/start") then
running = true
elseif (message == "action|input\n|text|/stop") then
running = false
Hook.Remove()
end

Hook.Attach("OnSendPacket", "Command", OnSendMessage)


-- main
while true do
LihatSeed()
Sleep(100)
end