
seedid = 5     --Seed ID
blockid = 4    --Block ID
platbreak = 100     --ID Block/Plat for break block
platplant = 102     --ID Block/Plat for plant seed
delay = 30000     --Growtime tree
hitcount = 3     --Hit break block 
vendx = 70
vendy = 22

function checkamount(id)
for _, item in pairs(GetInventory()) do
if (item.id == id) then
return item.amount
        end    
    end
    return 0
end

function wrench()
pkt = {}
pkt.type = 3
pkt.px = vendx
pkt.py = vendy
pkt.x = GetLocal().posX
pkt.y = GetLocal().posY
pkt.value = 32
SendPacketRaw (false, pkt)
end

function plants(x , y)
pkt = {}
pkt.px = x;
pkt.py = y;
pkt.x = x*32
pkt.y = ((GetLocal().posY/32)-1)*32
pkt.type = 3;
pkt.value = seedid;
SendPacketRaw (false, pkt);
end

function putb(x , y)
pkt = {}
pkt.px = x;
pkt.py = y;
pkt.x = ((GetLocal().posX/32)-1)*32
pkt.y = ((GetLocal().posY/32)-1)*32
pkt.type = 3;
pkt.value = blockid;
SendPacketRaw (false, pkt);
end

function punch(x , y)
pkt = {}
pkt.px = x;
pkt.py = y;
pkt.x = ((GetLocal().posX/32)-1)*32
pkt.y = ((GetLocal().posY/32)-1)*32
pkt.type = 3;
pkt.value = 18;
SendPacketRaw (false, pkt);
end

function punchs(x , y)
pkt = {}
pkt.px = x;
pkt.py = y;
pkt.x = x*32
pkt.y = y*32
pkt.type = 3;
pkt.value = 18;
SendPacketRaw (false, pkt);
end

function plant()
for _, tile in pairs(GetTiles())do
if(tile.fg == platplant)then
FindPath(tile.x, tile.y-1)
Sleep(150)
plants(tile.x, tile.y-1)
Sleep(150)
end
end
end

function pnb()
for _, tile in pairs(GetTiles())do
if(tile.fg == platbreak)then
FindPath(tile.x, tile.y-1)
Sleep(300)
end
end
end

function pnb1()
for _, tile in pairs(GetTiles())do
if(tile.fg == platbreak)then
putb(tile.x-1, tile.y-1)
Sleep(150)
putb(tile.x-2, tile.y-1)
Sleep(150)
for i = 1, hitcount do
punch(tile.x-1, tile.y-1)
Sleep(200)
punch(tile.x-2, tile.y-1)
Sleep(200)
end
end
end
end

function harvest()
for _, tile in pairs(GetTiles())do
if(tile.fg == seedid)then
FindPath(tile.x, tile.y)
Sleep(150)
punchs(tile.x, tile.y)
Sleep(300)
end
end
end

function findvend()
for _, tile in pairs(GetTiles()) do
if (tile.fg == 2978) then
vendx = tile.x
vendy = tile.y
Sleep(500)
end
end
end

farming = true
harvesting = false
planting = false

function pabrik()
    while farming do
        pnb()
        if (checkamount(blockid) >= 1) then
            if (checkamount(seedid) < 200) then 
             pnb1()

            else
                planting = true
                while planting do
                    planting = plant()
                    if (checkamount(seedid) <= 1) then
                        planting = false
                    end
                end
                pnb()
                Sleep(300)
                wrench()
                Sleep(10000)
                SendPacket(2, "action|dialog_return\ndialog_name|vending\ntilex|"..tostring(vendx).."|\ntiley|"..tostring(vendy).."|\nbuttonClicked|addstock")
                Sleep(delay)
            end
        else
            harvesting = true
            while harvesting do
                harvesting = harvest()
                if (checkamount(blockid) >= 180) then
                    harvesting = false
                end
            end
            if (checkamount(blockid) < 10) then
                planting = true
                while planting do
                    planting = plant()
                    if (checkamount(seedid) <= 10) then
                        planting = false
                    end
                end
                Sleep(delay)
            end
        end
    end
end

findvend()
pabrik()