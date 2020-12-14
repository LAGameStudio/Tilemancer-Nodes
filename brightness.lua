--- navot's brightness
function init()
    setName("Brightness")
    setDesc("Change the Brightness")
    setSize(80, 88+8*10+7+4)
    addOutput(24+32)
    addInput("Texture", 88+8*2)
    addInputParameter("Mode","Brighten modes\n(0=Add 1=Multiply 2=Range)",88+8*4,0,0,2)
    addInputParameter("Factor","Brightness Factor", 88+8*6,50,0, 100,true)
    addInputParameter("min","Only for Range mode",88+8*8,0,0,255)
    addInputParameter("max","Only for Range mode",88+8*10,255,0,255)
end

function apply()
    tileSize = getTileSize()
    mode = getValue(1, 0, 0, 1)
    factor = getValue(2, x, y, 100.0)
    min = getValue(3,x,y,255)
    max = getValue(4,x,y,255)

    for i=0, tileSize*tileSize-1 do
        x = i%tileSize
        y = math.floor(i/tileSize)
        ar, ag, ab = getValue(0, x, y, 1)
        factor = getValue(2, x, y, 100.0)
        if mode==0 then --add
            fr = ar+(factor*2-1)
            fg = ag+(factor*2-1)
            fb = ab+(factor*2-1)
            setPixel(0, x, y, math.min(math.max(fr,0),1), math.min(math.max(fg,0),1), math.min(math.max(fb,0),1))
        elseif mode==1 then --multiply
            fr = ar*(factor*2)
            fg = ag*(factor*2)
            fb = ab*(factor*2)
            setPixel(0, x, y, math.min(math.max(fr,0),1), math.min(math.max(fg,0),1), math.min(math.max(fb,0),1))
        elseif mode==2 then --range
            fr = math.min(ar*1/(max - min)-min/(max-min),1)*(factor*2)
            fg = math.min(ag*1/(max - min)-min/(max-min),1)*(factor*2)
            fb = math.min(ab*1/(max - min)-min/(max-min),1)*(factor*2)
            setPixel(0, x, y, math.min(math.max(fr,0),1), math.min(math.max(fg,0),1), math.min(math.max(fb,0),1))
        end
    end
end
