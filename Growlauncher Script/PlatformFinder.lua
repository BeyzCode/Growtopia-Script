-- 0 1 98 99

function detectplat()
    for _, tile in pairs(GetTiles()) do
        if(tile.x>1 and tile.x<98)then
            if(tile.flag == 2) then
                FindPath(tile.x, tile.y-1)
                LogToConsole("pathfinding")
                return true
            end
        end
    end
    return false
end

detectplat()

LogToConsole("script ended")