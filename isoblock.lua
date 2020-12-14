function init()
    setName("IsoBlock")
    setDesc("Isometric Block Simulation")
    setSize(100, 24+64+8+8+18+7+4+18)
    addOutput(24+32)
	addInput("z",24+8+8+8)
	addInput("x",24+8+8+8+8)
	addInput("y",24+8+8+8+8+8)
	addInput("fi",24+8+8+8+8+8+8+8)
    addParameter("Height", "Height of the block", 24+64+8+8, 0, 0, 100)
    addParameter("Width", "Width of the block", 24+64+8+8+18, 100, 0, 100)
    addParameter("Depth", "Depth of the block", 24+64+8+8+18+18, 100, 0, 100)
end

function apply()
    tileSize = getTileSize()
	Height = math.floor(getValue(4,0,0,1)/100*tileSize/2-tileSize/2)
	Width = math.floor(getValue(5,0,0,1)/100*tileSize)
	Depth = math.floor(getValue(6,0,0,1)/100*tileSize)
-- Left side of cube
    for i=0, tileSize*tileSize-1 do
        x = i%tileSize
        y = math.floor(i/tileSize)
	r,g,b=getValue(3,x,y,1)
	setPixel(0,x,y, r,g,b);
	if (x >= tileSize-Width and y >= tileSize-Depth) then
		s = tileSize/2
		outr,outg,outb = getValue(0,x,y,1)
		setPixel(0, s+((x-y)/2), s+math.ceil((x+y)/4)-Height, outr, outg, outb )
	end
    end
-- Right side of cube
    for i=0, tileSize*tileSize-1 do
        x = i%tileSize
        y = math.floor(i/tileSize)
	if (x <= Depth and y <= Height*2) then
		s = tileSize/2
		outr,outg,outb = getValue(1,x,y,1)
		setPixel(0, s+(x/2), ((y/2)-math.ceil(x/4))-Height, outr, outg, outb )
	end
    end
-- Top of cube
    for i=0, tileSize*tileSize-1 do
        x = i%tileSize
        y = math.floor(i/tileSize)
	if (x <= Width and y <= Height*2) then
		s = tileSize/2
		outr,outg,outb = getValue(2,x,y,1)
		setPixel(0, s-(x/2), ((y/2)-math.ceil(x/4))-Height, outr, outg, outb )
	end
    end
	
end
