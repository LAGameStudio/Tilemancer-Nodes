-- by Ningow
function init()
    setName("XCompose")
    setDesc("Simple 90 Rotations")
    setSize(100,32+64+64+18+24+64+8+8+7+4)
    addOutput(24+32)
	addOutput(64+24+32)
	addOutput(64+64+24+32)
	addOutput(64+64+64+24+32)
	addInput("R",24+32)
	addInput("G",64+24+32)
	addInput("B",64+64+24+32)
	addInput("C",64+64+64+24+32)
end
-- Ugly way to use channels
function apply()
	isR, isG, isB = 0
	x = 0
	y = 0
    tileSize = getTileSize()
	for i=0, tileSize*tileSize-1 do
		x = i%tileSize
		y = math.floor(i/tileSize)
		if (getValue(0,x,y,1)>0) then
			isR = 1;
			break
		end
	end
	for i=0, tileSize*tileSize-1 do
		x = i%tileSize
		y = math.floor(i/tileSize)
		if (getValue(1,x,y,1)>0) then
			isG = 1;
			break
		end
	end
	for i=0, tileSize*tileSize-1 do
		x = i%tileSize
		y = math.floor(i/tileSize)
		if (getValue(2,x,y,1)>0) then
			isB = 1;
			break
		end
	end
    for i=0, tileSize*tileSize-1 do
		x = i%tileSize
		y = math.floor(i/tileSize)
		outr,outg,outb = getValue(3,x,y,1)
		if (isR == 1) then
			outr = getValue(0,x,y,1)
		end
		if (isG == 1) then
			outg = getValue(1,x,y,1)
		end
		if (isB == 1) then
			outb = getValue(2,x,y,1)
		end
		setPixel(0,x,y,outr,outr,outr)
		setPixel(1,x,y,outg,outg,outg)
		setPixel(2,x,y,outb,outb,outb)
		setPixel(3,x,y,outr,outg,outb)
    end
end
