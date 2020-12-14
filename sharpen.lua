function init()
    setName("Sharpen")
    setDesc("Sharpen texture")
    setSize(95,24+64+8+8+7+4+18)
    addOutput(24+32)
    addInput("Texture",24+64+8+8)
    addParameter("Intensity","Intensity",24+64+8+8+18,50,0,100,true)
end
-- Ugly way to use channels
function apply()
    tileSize = getTileSize()
    inte = (getValue(1,0,0,1) / 25) + 1
    for i=0, tileSize*tileSize-1 do
        x = i%tileSize
        y = math.floor(i/tileSize)
        cr, cg, cb = getValue(0, x, y, 1.0)
        cr=cr*5*inte
        cg=cg*5*inte
        cb=cb*5*inte
        crL, cgL, cbL = getValue(0,x-1,y,1.0)
        crR, cgR, cbR = getValue(0,x+1,y,1.0)
        crU, cgU, cbU = getValue(0,x,y-1,1.0)
        crD, cgD, cbD = getValue(0,x,y+1,1.0)
        cr = cr-((crL+crR+crU+crD)*inte)
        cg = cg-((cgL+cgR+cgU+cgD)*inte)
        cb = cb-((cbL+cbR+cbU+cbD)*inte)
        setPixel(0,x,y,cr,cg,cb)
    end
end
