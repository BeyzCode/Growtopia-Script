-- Setup Here
targetid = FindItemID("lava")
allitem = false

batas = 1
for a=0, 5, 1 do
for i=0, 5, 1 do
pkt = {}
pkt.x = GetLocal().posX-((i)*32)
pkt.y = GetLocal().posY-(a*32)
pkt.type = 0
pkt.px = -1
pkt.py = -1
pkt.state = 38
SendPacketRaw(false, pkt)
for _, v in pairs(GetInventory())
do
if allitem == false and v.id == targetid then
SendPacket(2, "action|drop\n|itemID|"..v.id);
SendPacket(2, "action|dialog_return\ndialog_name|drop_item\nitemID|"..v.id.."|\ncount|1");
Sleep(80);
if(a == batas)then
Sleep(100)
batas = batas+1
end
end
if allitem == true then
SendPacket(2, "action|drop\n|itemID|"..v.id);
SendPacket(2, "action|dialog_return\ndialog_name|drop_item\nitemID|"..v.id.."|\ncount|1");
Sleep(80);
if(a == batas)then
Sleep(100)
batas = batas+1
end
end
end
end
end