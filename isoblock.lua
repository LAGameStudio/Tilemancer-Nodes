-- improved by LostAstronaut.com
function init()
    setName("IsoBlock")
    setDesc("Isometric Block Simulation")
    setSize(100, 24+64+8+8+18+7+4+18)
    addOutput(24+32)
	addInput("z",24+8+8+8)
	addInput("x",24+8+8+8+8)
	addInput("y",24+8+8+8+8+8)
	addInput("fi",24+8+8+8+8+8+8+8)
    addParameter("Height", "Height of the block", 24+64+8+8, 0, 0, 100,true)
    addParameter("Width", "Width of the block", 24+64+8+8+18, 100, 0, 100,true)
    addParameter("Depth", "Depth of the block", 24+64+8+8+18+18, 100, 0, 100,true)
end

function apply()
  tileSize = getTileSize()
  Height = (getValue(4,0,0,1)/100)/2-1
  sizeHeight = Height*tileSize
  Width  = (getValue(5,0,0,1)/100)
  sizeWidth = Width*tileSize
  Depth  = (getValue(6,0,0,1)/100)
  sizeDepth = Depth*tileSize
    for i=0, tileSize*tileSize-1 do
        x = i%tileSize
        y = math.floor(i/tileSize)
	rx = x / tileSize
	ry = y / tileSize
-- Fill background
	r,g,b=getValue(3,x,y,1)
	setPixel(0,x,y, r,g,b);
	s = math.floor(tileSize/2 - 0.5)
-- Left side of cube
	if (x >= sizeWidth and y > tileSize-sizeDepth) then
		outr,outg,outb = getValue(0,x,y,1)
		setPixel(0, s+((x-y)/2), s+math.ceil((x+y)/4)-Height, outr, outg, outb )
	end
-- Right side of cube
	if (x <= sizeDepth and y < sizeHeight*2-1) then
		outr,outg,outb = getValue(1,x,y,1)
		setPixel(0, s+(x/2), ((y/2)-math.ceil(x/4))-Height, outr, outg, outb )
	end
-- Top of cube
	if (x <= sizeWidth and y < sizeHeight*2-1) then
		outr,outg,outb = getValue(2,x,y,1)
		setPixel(0, s-(x/2), ((y/2)-math.ceil(x/4))-Height, outr, outg, outb )
	end		
    end
end
