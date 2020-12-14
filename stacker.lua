-- Ningow's Stacker
function init()
    setName("Stacker")
    setDesc("Stacks 2 images using black as transparency")
    setSize(80,8+24+64)
    addOutput(24+32)
	addInput("",24+32-24)
	addInput("",24+32+24)
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
		outr, outg, outb = getValue(1,x,y,1)
		a = outr + outg + outb
		--if a > 0 then
			setPixel(0,x,y,outr,outg,outb)
		--end
		
		outr, outg, outb = getValue(0,x,y,1)
		b = outr + outg + outb
		if b > 0 then
			setPixel(0,x,y,outr,outg,outb)
		end
	end
end
