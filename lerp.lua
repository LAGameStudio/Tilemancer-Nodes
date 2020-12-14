--made by rerere284
function init()
    setName("Lerp")
    setDesc("Linear interpolation. Combine two textures.")
    setSize(100, 24+64+8+8+18+18+7+4)
    addOutput(24+32)
    addInputParameter("Texture", "The first value", 24+64+8+8, 0, 0, 100, true) --should probably be input parameters
    addInputParameter("Texture", "The second value", 24+64+8+8+18, 100, 0, 100, true)
	addInputParameter("t", "How much it is one texture or the other", 24+64+8+8+18+18, 50, 0, 100, true)
end

function lerp(a,b,t)
	return ((1-t)*a) + (t*b)
end

function apply()
    tileSize = getTileSize()
    for i=0, tileSize*tileSize-1 do
        x = i%tileSize
        y = math.floor(i/tileSize)
        ar, ag, ab = getValue(0, x, y, 100) --get pixels at that location for both
        br, bg, bb = getValue(1, x, y, 100)
		ttr, ttb, ttg = getValue(2, x, y, 100)
		tt = (ttr+ttb+ttg)/3
		fr = lerp(ar,br,tt)
		fg = lerp(ag,bg,tt)
		fb = lerp(ab,bb,tt)
        setPixel(0, x, y, fr, fg, fb)
    end
end
