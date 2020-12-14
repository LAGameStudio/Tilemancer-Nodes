function init()
    setName("CrossCut")
    setDesc("Bend texture into a shape")
    setSize(100, 4+18+18+24+64+8+8+18+18+7+4)
    addOutput(24+32)
	addOutput(64+24+32)
    addInput("", 24+32)
    addInputParameter("Direction", "0:horizontal 1:vertical", 64+24+64+8, 0, 0, 1)
	addInputParameter("Position", "Position cut", 64+24+64+8+18, 0, 0, getTileSize())
end

function normalize(x, y, z)
    l = math.sqrt(x*x+y*y+z*z)
    return x/l, y/l, z/l
end

function apply()
    tileSize = getTileSize()
    for i=0, tileSize*tileSize-1 do
        x = i%tileSize
        y = math.floor(i/tileSize)
		t = getValue(2,x,y,1)
		if (getValue(1,0,0,1) == 0) then
			outr,outg,outb = getValue(0,x,y,0)
			if (y == t) then
				outr,outg,outb = 1-getValue(0,x,y,0)
			end
			setPixel(0, x, y, outr, outg, outb)
			outr,outg,outb = getValue(0,x,t,0)
		end
		if (getValue(1,0,0,1) == 1) then
			outr,outg,outb = getValue(0,x,y,0)
			if (x == t) then
				outr,outg,outb = 1-getValue(0,x,y,0)
			end
			setPixel(0, x, y, outr, outg, outb)
			outr,outg,outb = getValue(0,t,y,0)
		end
        setPixel(1, x, y, outr, outg, outb)
    end
end
