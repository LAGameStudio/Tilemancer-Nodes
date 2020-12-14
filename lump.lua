--made by rerere284
function init()
    setName("Lump")
    setDesc("Hill shaped equation near zero")
	--Lump is a better name, but it seems more hill shaped.
    setSize(100, 24+64+8+8+18+18+18+18+7+4)
    addOutput(24+32)
	addInputParameter("Number", "Equation Input", 24+64+8+8, 1, -1, -1)
	addParameter("Multiplier", "Multiplies input", 24+64+8+8+18, 100, -1, -1)
	addParameter("Shift Input", "Higher means softer", 24+64+8+8+18+18, 1, 1, -1)
	addParameter("Height", "Height of lump, though height is affected by other values too", 24+64+8+8+18+18+18, 1, -1, -1)
	addParameter("Offset", "Moves lump sideways", 24+64+8+8+18+18+18+18, 0, -1, -1)
end

function apply()
    tileSize = getTileSize()
	mlt  = getValue(1, x, y, 100.0)
	shft = getValue(2, x, y, 100.0) / 10
	hght = getValue(3, x, y, 100.0) / 10
	ofst = getValue(4, x, y, 100.0)
    for i=0, tileSize*tileSize-1 do
        x = i%tileSize
        y = math.floor(i/tileSize)
		ar, ag, ab = getValue(0, x, y, 100.0) --get pixel at that location
		fr = hght/((((ar-ofst)*mlt)^2)+shft)
		fg = hght/((((ag-ofst)*mlt)^2)+shft)
		fb = hght/((((ab-ofst)*mlt)^2)+shft)
        setPixel(0, x, y, fr, fg, fb)
    end
end
