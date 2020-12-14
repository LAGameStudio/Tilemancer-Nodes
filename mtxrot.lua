-- by Ningow
function init()
    setName("Rotate Matrix")
    setDesc("A Rotation Matrix")
    setSize(120,18+18+18+24+64+8+8+7+4)
    addOutput(24+32)
	addInput("Texture",24+64+8+8)
    addInputParameter("Rotation","Image Rotation",18+24+64+8+8,0,0,255)
	addParameter("Center X","X of the center of rotation",18+18+24+64+8+8,getTileSize()/2,0,getTileSize())
	addParameter("Center Y","Y of the center of rotation",18+18+18+24+64+8+8,getTileSize()/2,0,getTileSize())
end
-- Ugly way to use channels
function apply()
	x = 0
	y = 0
    tileSize = getTileSize()
    for i=0, tileSize*tileSize-1 do
		x = i%tileSize
		y = math.floor(i/tileSize)
		Tx = x-getValue(2,0,0,1)
		Ty = y-getValue(3,0,0,1)
		teta = math.rad(getValue(1,x,y,255)*360)
		outr, outg, outb = getValue(0,math.floor((Tx*math.cos(teta))-(Ty*math.sin(teta)))+getValue(2,0,0,1),math.floor((Ty*math.cos(teta))+(Tx*math.sin(teta)))+getValue(3,0,0,1),1)
		setPixel(0,x,y,outr,outg,outb)
    end
end
