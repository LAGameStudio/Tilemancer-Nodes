--made by rerere284
function init()
    setName("Direction to Vector")
    setDesc("Converts Direction and Intensity to Vector X and Y.")
    setSize(100, 24+64+64+8+8+18+7+4)
    addOutput(24+32)
	addOutput(24+64+32)
	addInputParameter("Dir", "Direction.", 24+64+64+8+8,    1, -1, -1)
	addInputParameter("Int", "Intensity.", 24+64+64+8+8+18, 0, -1, -1)
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
		vx = math.sin(-a*(math.pi*2))*b
		vy = math.cos(-a*(math.pi*2))*-b
        setPixel(0, x, y, vx, vx, vx)
		setPixel(1, x, y, vy, vy, vy)
    end
end
