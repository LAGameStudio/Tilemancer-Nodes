--made by rerere284
function init()
    setName("Square pattern")
    setDesc("Used for checkerboards and other square patterns.")
    setSize(100, 24+64+8+8+18+7+4)
    addOutput(24+32)
    addInputParameter("Size", "How many squares to split it into", 24+64+8+8, 3, 1, -1)
    addInputParameter("Colors", "Number of colors", 24+64+8+8+18, 2, 1, -1)
end

function floorto(a,b)
	return math.floor(a/b)*b
end

function apply()
    tileSize = getTileSize()
	
    for i=0, tileSize*tileSize-1 do
        x = i%tileSize
        y = math.floor(i/tileSize)
        ar, ag, ab = getValue(0, x, y, 1) --get pixels at that location for both
        br, bg, bb = getValue(1, x, y, 1)
		--siz = floorto((ar+ag+ab)/3 , 1/tileSize)
		siz = 2^((ar+ag+ab)/3) --glitches out with any other numbers, for some reason.
									--not based on tileSize either
		col = (br+bg+bb)/3
		f = (floorto(x/tileSize,1/siz) + floorto(y/tileSize,1/siz))
		f = f * siz/col
		f = f % 1
		f = f * (col/(col-1))
        setPixel(0, x, y, f, f, f)
    end
end
