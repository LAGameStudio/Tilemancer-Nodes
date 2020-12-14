function init()
    setName("HSV")
    setDesc("Adjust HSV values")
    setSize(120,18+18+18+24+64+8+8+7+4)
    addOutput(24+32)
	addInput("Texture",24+64+8+8)
    addInputParameter("H","Hue",18+24+64+8+8,0,0,255)
	addInputParameter("S","Saturation",18+18+24+64+8+8,127,0,255)
	addInputParameter("V","Value",18+18+18+24+64+8+8,127,0,255)
end
-- Ugly way to use channels
function getChroma(R, G, B)
	m = math.min(math.min(R, G), B)
	M = math.max(math.max(R, G), B)
	return (M-m)
end
function rgbM(n, H, S, V)
	k = math.fmod((n + (H*6)), 6)
	out = V - (V*S*math.max(math.min(k,4-k,1),0))
	return out
end
function getHue(R, G, B)
	m = math.min(math.min(R, G), B)
	M = math.max(math.max(R, G), B)
	
	if (m == M) then
		return 0
	end
	if (M == R) then
		hue = (G-B)/(M-m)
	end
	if (M == G) then
		hue = 2+(B-R)/(M-m)
	end
	if (M == B) then
		hue = 4+(R-G)/(M-m)
	end
	
	hue = hue / 6
	
    if (hue < 0) then
		hue = hue + 1
	end
	if (hue > 1) then
		hue = hue - 1
	end
	
	return hue
end
function apply()
	x = 0
	y = 0
    tileSize = getTileSize()
	for i=0, tileSize*tileSize-1 do
		x = i%tileSize
		y = math.floor(i/tileSize)
		R, G, B = getValue(0,x,y,1) -- Scan Texture
		
		hmod = getValue(1,x,y,255)
		hnew = getHue(R, G, B) + hmod
		if (hnew > 1) then
			hnew = hnew - 1
		end
		if (hnew < 0) then
			hnew = hnew + 1
		end
		
		vmod = (getValue(3,x,y,255)*2) - 1
		vnew = math.min((math.max((math.max( (math.max(R, G)) , B) + vmod), 0)), 1)
		
		smod = (getValue(2,x,y,255)*2) - 1
		if(vnew == 0) then
			snew = (getChroma(R, G, B)) + smod
		else
			snew = (getChroma(R, G, B) / vnew) + smod
		end
		
		--convert to rgb
		outr = rgbM(5, hnew, snew, vnew)
		outg = rgbM(3, hnew, snew, vnew)
		outb = rgbM(1, hnew, snew, vnew)
		
		setPixel(0,x,y,outr,outg,outb)
		
    end
end
