function init()
    setName("StripesInc")
    setDesc("Generate striped texture")
    setSize(100,24+32+24+64+8+8+7+4+18+18+18)
    addOutput(24+32)
	addOutput(64+24+32+8)
    addInputParameter("Intensity","Intensity",64+7+24+64+8+8,100,0,100,true)
	addParameter("Increments","Vertical value variation",64+7+18+24+64+8+8,50,0,100)
	addParameter("Seed","Random seed",64+7+18+18+24+64+8+8,0,0,255)
end
-- Ugly way to use channels
function apply()
	math.randomseed (getValue(2,0,0,1))
	colorval = math.random()
    tileSize = getTileSize()
    for i=0, tileSize*tileSize-1 do
		x = i%tileSize
		y = math.floor(i/tileSize)
		if (x == 0) then
			if (math.random() > 0.5) then
				colorval = colorval + getValue(1,0,0,100)
			else
				colorval = colorval - getValue(1,0,0,100)
			end
		end
		if (colorval < 0) then 
				colorval = 0
			end
			if (colorval > 1) then 
				colorval = 1
			end
        setPixel(0,x,y,colorval*getValue(0,0,0,100),colorval*getValue(0,0,0,100),colorval*getValue(0,0,0,100))
		setPixel(1,y,x,colorval*getValue(0,0,0,100),colorval*getValue(0,0,0,100),colorval*getValue(0,0,0,100))
    end
end
