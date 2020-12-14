function init()
    setName("Zoom&Stretch")
    setDesc("X and Y stretching")
    setSize(120,18+18+24+64+8+8+7+4+18+18+18)
    addOutput(24+32)
	addInput("Texture",24+64+8+8)
    addInputParameter("X pos","X position",18+24+64+8+8,0,0,64)
	addInputParameter("Y pos","Y position",18+18+24+64+8+8,0,0,64)
	addInputParameter("H fac","Horizontal stretching factor",18+18+18+24+64+8+8,1,1,64)
	addInputParameter("V fac","Vertical stretching factor",18+18+18+18+24+64+8+8,1,1,64)
	addInputParameter("Smooth","Smoothness",18+18+18+18+18+24+64+8+8,0,0,10)
end
-- Ugly way to use channels
function apply()
	x = 0
	y = 0
    tileSize = getTileSize()
    for i=0, tileSize*tileSize-1 do
		x = i%tileSize
		y = math.floor(i/tileSize)
        xnew = math.floor(x/getValue(3, 0, 0, 1)) + getValue(1, 0, 0, 1)
		ynew = math.floor(y/getValue(4, 0, 0, 1)) + getValue(2, 0, 0, 1)
		out = getValue(0, xnew, ynew, 1)
		if (getValue(5, 0, 0, 1) > 0)then
			for i=0, getValue(5, 0, 0, 1) do
				out = out+getValue(0, xnew+i, ynew+i, 1)
				out = out+getValue(0, xnew-i, ynew-i, 1)
			end
			out = out/(1+ 2*getValue(5, 0, 0, 1))
		end
		
		setPixel(0,x,y,out,out,out)
    end
end
