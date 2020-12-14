function init()
    setName("MirrMix")
    setDesc("Mix with the mirror image")
    setSize(95,18+24+32+24+64+8+8+7+4+18+18)
    addOutput(24+32)
	addInput("Texture",24+64+8+8,0,0,1)
    addInputParameter("Loop H","Loop Horizontally",18+18+24+64+8+8,0,0,1)
	addInputParameter("Loop V","Loop Vertically",18+18+24+64+8+8+18,0,0,1)
	addParameter("Mix","Mix looped image",18+18+18+18+24+64+8+8,100,0,100, true)
	addParameter("MixType","0:Clip 1:Opacity 2:Textured clip 3:Textured Opacity",18+18+18+18+24+64+8+8+18,0,0,3)
	addParameter("MirrorType","0:Average 1:Darken 2:Lighten",18+18+18+18+24+64+8+8+18+18,0,0,2)
	addInput("Mix",18+24+64+8+8,0,0,1)
end
-- Ugly way to use channels
function loopr(x, y, ori)
	xy = getValue(0,x,y,1)--image not mirrowed
	mx = getValue(0,size-x,y,1)--image mirrowed in x
	my = getValue(0,x,size-y,1)--image mirrowed in y
	mxy = getValue(0,size-x,size-y,1)--image mirrowed in x and y
	
	if(getValue(5,0,0,1) == 0) then
	
		if (ori==0) then --H
			return (xy + mx)/2
		end
		if (ori==1) then --v
			return (xy + my)/2
		end
		if (ori==2) then --HV
			return (xy + mx + my + mxy)/4
		end
	end
	if(getValue(5,0,0,1) == 1) then
	
		if (ori==0) then --H
			return math.min(xy , mx)
		end
		if (ori==1) then --v
			return math.min(xy , my)
		end
		if (ori==2) then --HV
			return math.min(xy , mx, my, mxy)
