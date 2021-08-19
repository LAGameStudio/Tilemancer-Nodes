--Made by LeandroGabriel.net
--Probably it has a few flaws but, IT WORKS!
--TILEMANCER ROCKS!!!!!!!!!
function init()
    setName("Mosaic")
    setDesc("Applies a mosaic to the input")
    setSize(100, 24+64+8+8+18+7+4)
    addOutput(24+32)
    addInput("Texture", 24+64+8+8)
    addParameter("Multiplier", "Sets the multiplier for the mosaic output", 24+64+8+8+18, 1, 1, 16)
end

function apply()
    tileSize = getTileSize()
    multiplier = getValue(1, 0, 0, 1)
    cr, cg, cb = getValue(0, 0, 0, 1.0)
    
    for i=0, tileSize*tileSize-1 do
        x = i%tileSize
        y = math.floor(i/tileSize)
        if x%multiplier==0 and y%multiplier==0 then
            cr, cg, cb = getValue(0, x, y, 1.0)
            for j=0, multiplier do
                for k=0, multiplier do
                    setPixel(0, x+j, y+k, math.abs(cr), math.abs(cg), math.abs(cb))
                end
            end
        end
    end
end
