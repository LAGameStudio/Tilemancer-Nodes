-- freely gifted by lostastronaut.com
function init()
    setName("Border")
    setDesc("Creates a square border from a texture on a texture")
    setSize(108, 24+64+8+8+18+7+4)
    addInput("Texture Border", 24+64+16)
    addInput("Texture Fill", 24+64+16+64+16)
    addOutput(24+32)
    addInputParameter("Thickness", "How much border", 24+128+32+16, 1, 0, 100,true)
end
 
function apply()
    size = getTileSize()
    thickness = getValue(2,0,0,1)/100.0
    for i=0, size*size-1 do
        x = i%tileSize
        y = math.floor(i/tileSize)
        if ( x <= thickness or y <= thickness or x >= size-thickness-1 or y >= size-thickness-1 ) then
          r, g, b = getValue(0, x, y, 100.0) -- border texture
        else
          r, g, b = getValue(1, x, y, 100.0) -- fill texture
        end
        setPixel(0, x, y, r, g, b)
    end
end
