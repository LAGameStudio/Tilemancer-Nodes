function init()
    setName("Custom Scatter")
    setDesc("Scatters texture")
    setSize(100, 24+64+8+8+18*7+7+4)
    addOutput(24+32)
    addInput("Texture", 24+64+8+8)
    addParameter("Seed", "RNG seed", 24+64+8+8+18, 0, -1, -1)
    addParameter("Amount", "Amount", 24+64+8+8+18+18, 10, 0, 1000)
    addParameter("Scale", "scale", 24+64+8+8+18+18+18, 50, 2, 100, true)
    addParameter("Rand scale", "Random scale", 24+64+8+8+18+18+18+18, 50, 0, 99, true)
    addParameter("Rotation", "Random rotation", 24+64+8+8+18+18+18+18+18, 100, 0, 100, true)
    addParameter("Intensity", "Random intensity", 88+8*2+18*6, 100, 0, 100, true)
    addParameter("Mode","Blend mode\n(0=max 1=add 2=overlay)",88+8*2+18*7,0,0,2)
end

function apply()
    tileSize = getTileSize()
    posX= {}
    posY= {}
    intensity={}
    scalex={}
    scaley={}
    rotation={}
    amount = getValue(2,0,0,1)
    scale = getValue(3,0,0,100)
    randScale = getValue(4,0,0,100)
    randRot = getValue(5,0,0,100)
    randIntensity = getValue(6,0,0,100)
    mode = getValue(7,0,0,1)
    math.randomseed(getValue(1, 0, 0, 1))
    for i=0, tileSize*tileSize-1 do--set all black
    	x = i%tileSize
        y = math.floor(i/tileSize)
        setPixel(0, x, y, 0, 0, 0)
    end
    
    cols = {}
    for i=0 , tileSize do
    	cols[i]={}
    	for j=0,tileSize do
    		cols[i][j]=0
    	end
	end

    for i=0,amount-1 do--create values
    	posX[i]= math.floor(math.random()*tileSize)
    	posY[i]= math.floor(math.random()*tileSize)

    	scalex[i] = scale*(1-randScale/2+math.random()*randScale)
    	scaley[i] = scale*(1-randScale/2+math.random()*randScale)

    	intensity[i] = (1-math.random()*randIntensity)

    	rotation[i] = math.pi *2* math.random()*randRot
    end 

    setPixel(0,0,0,1,1,0)
    for i=0,amount-1 do--get pixel colors
		multi = 2

    	for x=0,math.floor(tileSize*scalex[i])*multi-1 do
    		for y=0,math.floor(tileSize*scaley[i])*multi-1 do
    			ox=x/multi
    			oy=y/multi

    			s = math.sin(rotation[i])
        		c = math.cos(rotation[i])

				x2=(x/multi*c-y/multi*s)
				y2=(x/multi*s+y/multi*c)


				x2=math.floor(x2+posX[i]+.5)%tileSize
				y2=math.floor(y2+posY[i]+.5)%tileSize
				value = 0
				value = getValue(0,ox/scalex[i],oy/scaley[i],0) *intensity[i]
				if mode==2 then
					for k=-1,1 do
						for l=-1,1 do
		    				value = value + getValue(0,ox/scalex[i]+k,oy/scaley[i]+l,0) *intensity[i] * (-math.pow(k,2)+2)* (-math.pow(l,2)+2)
					end
				end
					value = value / (4+4*2+4)
				end
				

    			if mode==0 then
    				value=math.max(value,cols[x2][y2])
    			elseif mode==1 then
    				value = value+cols[x2][y2]
    			elseif mode==2 then
    				value=math.max(value,cols[x2][y2])
    			end
    			cols[x2][y2] = value
    		end
    	end
  	    
		for x=0,tileSize-1 do--put on screen
    		for y=0,tileSize-1 do
    			value=cols[x][y]
    	    	setPixel(0,x,y,value,value,value)
    	   	end
    	end
    end
end