function init()
    setName("Simple Rotate")
    setDesc("Simple 90 Rotations")
    setSize(120,18+24+64+8+8+7+4)
    addOutput(24+32)
	addInput("Texture",24+64+8+8)
    addInputParameter("Rotation","Image Rotation",18+24+64+8+8,0,0,3)
end
-- Ugly way to use channels
function apply()
	x = 0
	y = 0
    tileSize = getTileSize()
    for i=0, tileSize*tileSize-1 do
		x = i%tileSize
		y = math.floor(i/tileSize)
		if (getValue(1,0,0,1) == 0) then
			outr, outg, outb = getValue(0,x,y,1)
			setPixel(0,x,y,outr,outg,outb)
		end
		if (getValue(1,0,0,1) == 1) then
			outr, outg, outb = getValue(0,x,y,1)
			setPixel(0,y,tileSize-x,outr,outg,outb)
		end
		if (getValue(1,0,0,1) == 2) then
			outr, outg, outb = getValue(0,x,y,1)
			setPixel(0,tileSize-x,tileSize-y,outr,outg,outb)
		end
		if (getValue(1,0,0,1) == 3) then
			outr, outg, outb = getValue(0,x,y,1)
			setPixel(0,tileSize-y,x,outr,outg,outb)
		end
    end
end
