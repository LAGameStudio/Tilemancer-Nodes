function init()
    setName("Cover")
    setDesc("Overlays texture")
    setSize(80, 148)
    addOutput(56)
    addInput("Texture A", 100)
    addInput("Texture B", 118)
    addInputParameter("Alpha", "Opaque threshhold", 136, 1, 0, 100, true)
end

function apply()
	tileSize = getTileSize()
    for x=0, tileSize-1 do
		for y=0, tileSize-1 do
			sourceR, sourceG, sourceB = getValue(0,x,y,1)
			destR, destG, destB = getValue(1,x,y,1)
			z = math.max(destR, destG, destB)
			if z >= getValue(2, x, y, 100)
			then
				newR = destR
				newG = destG
				newB = destB
			else
				newR = sourceR
				newG = sourceG
				newB = sourceB
			end
			setPixel(0, x, y, newR, newG, newB)
			--setPixel(0, x, y, 1, 0, 0)
		end
    end
end