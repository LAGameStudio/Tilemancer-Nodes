--made by rerere284
function init()
    setName("Gray Noise")
    setDesc("Generates gray noise")
    setSize(100, 24+64+8+8+18+18+7+4)
    addOutput(24+32)
    addInputParameter("Number1", "First number", 24+64+8+8, 0, -1, -1)
    addInputParameter("Number2", "Second number", 24+64+8+8+18, 0, -1, -1)
	addParameter("Seed", "RNG seed", 24+64+8+8+18+18, 0, -1, -1)
end

function lerp(a,b,t)
	return ((1-t)*a) + (t*b)
end

function apply()
    tileSize = getTileSize()
	math.randomseed(getValue(2, 0, 0, 1))
    for i=0, tileSize*tileSize-1 do
        x = i%tileSize
        y = math.floor(i/tileSize)
        ar, ag, ab = getValue(0, x, y, 100) --get pixels at that location for both
        br, bg, bb = getValue(1, x, y, 100)
		--return a random value between those two
		tt = math.random(0,100)/100
		fr = lerp(ar,br,tt)
		fg = lerp(ag,bg,tt)
		fb = lerp(ab,bb,tt)
        setPixel(0, x, y, fr, fg, fb)
		--setPixel(0, x, y, ar, bg, bb)
    end
end
