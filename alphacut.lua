-- by Ningow
function init()
    setName("Cutoff Alpha")
    setDesc("Put Transparency into stuff")
    setSize(100,18+18+24+64+8+8+7+4)
    addOutput(24+32)
	addInput("Texture",24+64+8+8)
	addInput("Alpha",18+24+64+8+8)
    addParameter("Cut","Lightness Cut",18+18+24+64+8+8,50,0,100)
end
-- Ugly way to use channels
function apply()
	math.randomseed (getValue(5,0,0,1))
	x = 0
	y = 0
    tileSize = getTileSize()
	for i=0, tileSize*tileSize-1 do
		x = i%tileSize
		y = math.floor(i/tileSize)
		outr, outg, outb = getValue(0,x,y,1)
		if (getValue(2,0,0,100) < getValue(1,x,y,1)) then
			setPixel(0,x,y,outr,outg,outb)
		end
	end
	
	
end
