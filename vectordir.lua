--made by rerere284
function init()
    setName("Vector to Direction")
    setDesc("Converts vector x and y to direction and intensity.")
    setSize(100, 24+64+64+8+8+18+7+4)
    addOutput(24+32)
	addOutput(24+64+32)
	addInputParameter("X", "X value of vector.", 24+64+64+8+8,    1, -1, -1)
	addInputParameter("Y", "Y value of vector.", 24+64+64+8+8+18, 0, -1, -1)
end

function apply()
    tileSize = getTileSize()
	
    for i=0, tileSize*tileSize-1 do
        x = i%tileSize
        y = math.floor(i/tileSize)
        ar, ag, ab = getValue(0, x, y, 1) --get pixels at that location for both
        br, bg, bb = getValue(1, x, y, 1)
		a = (ar+ag+ab)/3
		b = (br+bg+bb)/3
		dir = math.atan2(-a,-b)/(math.pi*2)
		str = math.sqrt((a*a)+(b*b))
        setPixel(0, x, y, dir, dir, dir)
		setPixel(1, x, y, str, str, str)
    end
end
