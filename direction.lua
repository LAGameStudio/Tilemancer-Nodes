--made by rerere284
function init()
    setName("Direction")
    setDesc("Direction from center")
    setSize(100, 24+64+8+8+7+4)
    addOutput(24+32)
	addParameter("Offset", "Rotational offset", 24+64+8+8, 0, -1, -1)
end

function apply()
    tileSize = getTileSize()
	math.randomseed(getValue(2, 0, 0, 1))
    for i=0, tileSize*tileSize-1 do
        x = (i%tileSize)
        y = (math.floor(i/tileSize))
		px = x - (tileSize/2)
		py = y - (tileSize/2)
		rot = math.atan2(py,px)/(math.pi*2) + (90/360) + (getValue(0, 0, 0, 1)/360)
        setPixel(0, x, y, rot, rot, rot)
    end
end
