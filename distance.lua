--made by rerere284
function init()
    setName("Distance")
    setDesc("Gets the distance between two numbers")
    setSize(100, 24+64+8+8+18+7+4)
    addOutput(24+32)
	addInputParameter("First", "First Number", 24+64+8+8, 1, -1, -1)
	addInputParameter("Second", "Second Number", 24+64+8+8+18, 1, -1, -1)
end

function apply()
    tileSize = getTileSize()
    for i=0, tileSize*tileSize-1 do
        x = i%tileSize
        y = math.floor(i/tileSize)
		ar, ag, ab = getValue(0, x, y, 100.0) --get pixels at that location
		br, bg, bb = getValue(1, x, y, 100.0)
		fr = math.abs(ar - br)
		fg = math.abs(ag - bg)
		fb = math.abs(ab - bb)
        setPixel(0, x, y, fr, fg, fb)
    end
end
