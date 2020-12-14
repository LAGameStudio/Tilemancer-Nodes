-- navot's Preview
function init()
    setName("Tiled Preview")
    setDesc("Preview in a tiled grid")
    setSize(80+32, 24+128+8+8+7+4)
    addOutput(24+32)
    addInput("Texture", 88+8*2)
    addParameter("Amount","Tile Amount",88+8*4,2,1,4)
end
function apply()
    tileSize = getTileSize()
    tileSize = 64
    count = getValue(1,0,0,1)
    for i=0, tileSize*tileSize-1 do
        x = i%tileSize
        y = math.floor(i/tileSize)
        cr, cg, cb = getValue(0, x*count, y*count, 1.0)
        setPixel(0, x, y, cr, cg, cb)
    end
end
