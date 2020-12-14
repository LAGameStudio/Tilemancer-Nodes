function init()
    setName("Sine")
    setDesc("Puts texture into sin(x)")
    setSize(80,24+64+8+8+7+4+18+18)
    addOutput(24+32)
    addInput("Texture",24+64+8+8)
    addParameter("Freq","Frequency",24+64+8+8+18,1,1,50)
    addParameter("Positive","Absolute number",24+64+8+8+18+18,1,0,1)
end


function apply()
    tileSize = getTileSize()
    pos = getValue(2,0,0,1)
    for i=0, tileSize*tileSize-1 do
        x = i%tileSize
        y = math.floor(i/tileSize)
        cr, cg, cb = getValue(0, x, y, 1.0)
        setPixel(0,x,y,(math.sin(cr*freq)+pos)/(pos+1),(math.sin(cg*freq)+pos)/(pos+1),(math.sin(cb*freq)+pos)/(pos+1))
    end
end
