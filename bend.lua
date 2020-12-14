function init()
    setName("Bend")
    setDesc("Bend texture into a shape")
    setSize(100, 18+18+18+24+64+8+8+18+18+7+4)
    addOutput(24+32)
    addInput("Texture", 24+64+8+8)
    addInputParameter("Deform", "The Z Generic Distance", 24+64+8+8+18, 1, 0, 10)
    addInputParameter("Depth", "Image Depth", 24+64+8+8+18+18, 100, 1, 200, true)
	addParameter("Translate","Translates the image in Z",18+18+18+24+64+8+8,100,1,200)
	addParameter("DepthClamp","Clamps the image after a certain Z",18+18+18+18+24+64+8+8,50,0,100)
	addParameter("ClampDisl","Dislocates the clamping",18+18+18+18+18+24+64+8+8,0,0,100)
end

function normalize(x, y, z)
    l = math.sqrt(x*x+y*y+z*z)
    return x/l, y/l, z/l
end

function apply()
    tileSize = getTileSize()
    for i=0, tileSize*tileSize-1 do
        x = i%tileSize
        y = math.floor(i/tileSize)
		
		Dist = getValue(3,x,y,100)-((getValue(2,x,y,100)-1)*getValue(1, x, y, 1))
		if (Dist == 0) then 
			Dist = 1;
		end
		
		Tx = (tileSize/2)-(tileSize/(2*Dist))
		Ty = (tileSize/2)-(tileSize/(2*Dist))
		
		xnew = (x/Dist) + Tx
		ynew = (y/Dist) + Ty
		
		outr,outg,outb = getValue(0,xnew,ynew,1) 
			
		if (Dist > getValue(4, x, y, 100)+getValue(5,x,y,100)) then
			setPixel(0, x, y, outr, outg, outb)
		end
    end
end
