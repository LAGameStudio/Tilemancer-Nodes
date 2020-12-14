-- freely gifted by lostastronaut.com
function init()
    setName("Border")
    setDesc("Creates a square border from a texture on a texture")
    setSize(108, 24+128+8)
    addInput("Texture Border", 24+64+16)
    addInput("Texture Fill", 24+64+32)
    addOutput(24+32)
    addInputParameter("Thickness", "How much border", 24+64+48, 25, 0, 100,true)
end
 
function apply()
    size = getTileSize()
    thickness = math.floor(getValue(2,0,0,1)/100.0 * size)
    for x = 0, size -1 do
        for y = 0, size -1 do
            if ( x <= thickness or y <= thickness or x >= size-thickness or y >= size-thickness ) then
              r, g, b = getValue(0, x, y, 100.0) -- border texture
            else
              r, g, b = getValue(1, x, y, 100.0) -- fill texture
            end
            setPixel(0, x, y, r, g, b)
        end
    end
end
