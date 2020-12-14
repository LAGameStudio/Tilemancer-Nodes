function init()
    setName("IsoBlock")
    setDesc("Isometric Block Simulation")
    setSize(100, 24+64+8+8+18+7+4+18)
    addOutput(24+32)
	addInput("z",24+8+8+8)
	addInput("x",24+8+8+8+8)
	addInput("y",24+8+8+8+8+8)
	addInput("fi",24+8+8+8+8+8+8)
    addParameter("Depth", "Depth of the block", 24+64+8+8, 0, 0, (getTileSize()/2)-1)
    addParameter("Width", "Width of the block", 24+64+8+8+18, getTileSize(), 0, getTileSize())
    addParameter("Length", "Length of the block", 24+64+8+8+18+18, getTileSize(), 0, getTileSize())
end

function apply()
    tileSize = getTileSize()
	Depth = getValue(4,0,0,1)
	Width = getValue(5,0,0,1)
	Length = getValue(6,0,0,1)
	
    for i=0, tileSize*tileSize-1 do
        x = i%tileSize
        y = math.floor(i/tileSize)
	r,g,b=getValue(3,x,y,1)
	setPixel(0,x,y, r,g,b);
		s = (getTileSize()/2)-0.5
		outr,outg,outb = getValue(0,x,y,1)
		if (x >= tileSize-Width and y > tileSize-Length) then
			setPixel(0, s+((x-y)/2), s+math.ceil((x+y)/4)-Depth, outr, outg, outb )
		end
    end
	for i=0, tileSize*tileSize-1 do
        x = i%tileSize
        y = math.floor(i/tileSize)
		s = (getTileSize()/2)-0.5
		outr,outg,outb = getValue(1,x,y,1)
		if (x <= Length and y < Depth*2-1) then
			setPixel(0, s+(x/2), ((y/2)-math.ceil(x/4))-Depth, outr, outg, outb )
		end
    end
	for i=0, tileSize*tileSize-1 do
        x = i%tileSize
        y = math.floor(i/tileSize)
		s = (getTileSize()/2)-0.5
		outr,outg,outb = getValue(2,x,y,1)
		if (x <= Width and y < Depth*2-1) then
			setPixel(0, s-(x/2), ((y/2)-math.ceil(x/4))-Depth, outr, outg, outb )
		end
    end
	
end
