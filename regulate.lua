--made by rerere284
function init()
    setName("Regulate")
    setDesc("Modulo + Rounding")
    setSize(100, 24+64+8+8+18+18+7+4)
    addOutput(24+32)
    addInput("Texture", 24+64+8+8)
	addParameter("Modulo", "Loops over this value", 24+64+8+8+18, 10, 1, -1)
	addParameter("Rounding", "Snaps to this value", 24+64+8+8+18+18, 1, 1, -1)
end

function rnd(h)
	if (h*100) % 1 > 0.5 then
		return math.ceil(h*100)/100
	else
		return math.floor(h*100)/100
	end
end

function apply()
    tileSize = getTileSize()
    for i=0, tileSize*tileSize-1 do
        x = i%tileSize
        y = math.floor(i/tileSize)
		mod = getValue(1, 0, 0, 1)/100
		round = getValue(2, 0, 0, 1)/100
        ar, ag, ab = getValue(0, x, y, 1) --get pixel at that location
		fr = (rnd((ar % mod) * round)) / round
		fg = (rnd((ag % mod) * round)) / round
		fb = (rnd((ab % mod) * round)) / round
        setPixel(0, x, y, fr, fg, fb)
    end
end
