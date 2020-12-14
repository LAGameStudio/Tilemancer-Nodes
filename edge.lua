--made by rerere284
function init()
    setName("Edge Distance")
    setDesc("Gets how close things are to dark pixels")
    setSize(100, 24+64+8+8+7+4)
    addOutput(24+32)
	addInput("Texture", 24+64+8+8)
end

function apply()
    tileSize = getTileSize()
    for i=0, tileSize*tileSize-1 do
        ax = i%tileSize
        ay = math.floor(i/tileSize)
		closest = 9999999
		for j=0, tileSize*tileSize-1 do
			bx = j%tileSize
			by = math.floor(j/tileSize)
			ar, ag, ab = getValue(0, bx, by, 100.0) --get pixel at that location
			--if i ~= j then
				--dst = math.sqrt(((ax - bx)^2) + (ay - by)^2)/tileSize
				dst = (math.abs(ax - bx) + math.abs(ay - by))/(tileSize*2)
				brt = (ar + ag + ab)
				--brt = math.sqrt((ar^2) + (ag^2) + (ab^2))
				closeness = dst + (brt)
				if closeness < closest then
					closest = closeness
				end
			--end
		end
		fr = closest
		fg = closest
		fb = closest
        setPixel(0, ax, ay, fr, fg, fb)
    end
end
