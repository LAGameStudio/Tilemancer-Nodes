-- Ningow's Conway's Game of Life
function init()
    setName("Life")
    setDesc("Conway's game of life Sim")
    setSize(75,8+24+64+8+8+7+4)
    addOutput(24+32)
	addInput("",24+32)
	--addInput("UV",18+24+64+8)
    addParameter("Cut","Lightness Cut",24+64+8,0,0,100)
	addParameter("Tick","Iterations",24+64+8+15,0,0,15)
end
-- A B C
-- D i E
-- F G H

function iterate() 
	for i=0, tileSize*tileSize-1 do
		x = i%tileSize
		y = math.floor(i/tileSize)
		neigh = 0
		
		a = ((x-1)%tileSize)+(((y-1)%tileSize)*tileSize)
		b = ((x)%tileSize)+(((y-1)%tileSize)*tileSize)
		c = ((x+1)%tileSize)+(((y-1)%tileSize)*tileSize)
		d = ((x-1)%tileSize)+(((y)%tileSize)*tileSize)
		e = ((x+1)%tileSize)+(((y)%tileSize)*tileSize)
		f = ((x-1)%tileSize)+(((y+1)%tileSize)*tileSize)
		g = ((x)%tileSize)+(((y+1)%tileSize)*tileSize)
		h = ((x+1)%tileSize)+(((y+1)%tileSize)*tileSize)
		
		fut[i] = uni[i]
		
		neigh = uni[a] + uni[b] + uni[c] + uni[d] + uni[e] + uni[f] + uni[g] + uni[h]
		
		if uni[i] == 1 and(neigh==2 or neigh==3)then
			fut[i] = 1
		elseif uni[i] == 0 and neigh==3 then
			fut[i] = 1
		else fut[i] = 0
		end
		
	end
end

function updateuni()
	for i=0, tileSize*tileSize-1 do
		uni[i] = fut[i]
	end
end

function apply()
	--math.randomseed (getValue(5,0,0,1))
	uni = {}
	fut = {}
	cut = getValue(1,0,0,100)
	ticks = getValue(2,0,0,1)
	x = 0
	y = 0
    tileSize = getTileSize()
	for i=0, tileSize*tileSize-1 do
		x = i%tileSize
		y = math.floor(i/tileSize)
		if getValue(0,x,y,1) <= cut then
		out = 0
		else out = 1
		end
		uni[i] = out
	end
	if ticks > 0 then
		for i=0, ticks-1 do
			iterate()
			updateuni()
		end
	end
	
	for i=0, tileSize*tileSize-1 do
		x = i%tileSize
		y = math.floor(i/tileSize)
		out = uni[i]
		setPixel(0,x,y,out,out,out)
	end
end
