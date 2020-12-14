-- Ningow's Dither
function init()
    setName("Screentone Dither")
    setDesc("Dithering machine")
    setSize(85,16+8+24+64+8+8+7+4)
    addOutput(24+32)
	addInput("",24+32)
    addParameter("Intensity","Intensity",24+64+9,100,0,200,true)
	addParameter("Style","Dithering style",16+24+64+9,1,0,7)
	addParameter("Steps","Dithering steps",16+16+24+64+9,3,1,3)
end
-- Ugly way to use channels
function checker(x,y,sel)
	if sel == 0 then
		if (x+y)%2 == 0 then
			return 0
		end
		return 1
	elseif sel == 1 then
		if (x+y)%4 == 0 or (x-y)%4 == 0 then
			return 0
		end
		return 1
	elseif sel == 2 then
		if (x+y)%4 == 0 and x%2 == 0 and y%2 == 0 then
			return 0
		end
		return 1
	elseif sel == 3 then
		if (x+y+1)%4 == 0 or (x-y+1)%4 == 0 then
			return 1
		end
		return 0
	elseif sel == 4 then
		if (x+y)%4 == 0 and x%2 == 0 and y%2 ==0 then
			return 1
		end
		return 0
	end
end

function lined(x,y,sel)
	if sel == 0 then
		if y%2 == 0 then
			return 0
		end
		return 1
	elseif sel == 1 then
		if y%2 == 0 and (x+y)%4 ~= 1 then
			return 0
		end
		return 1
	elseif sel == 2 then
		if (y+1)%2 == 0 and (x+y+1)%4 ~= 1 then
			return 1
		end
		return 0
	end
end

function crossd(x,y,sel)
	if sel == 0 then
		if (x+y)%4 == 0 then
			return 0
		end
		return 1
	elseif sel == 1 then
		if (x-y+1)%4 == 0 then
			return 1
		end
		return 0
	end
end

function block(x,y,sel,inv)
	if sel == 0 then
		if (x*y)%2 == 0 then
			return 0+inv
		end
		return 1-inv
	elseif sel == 1 then
		if (x*y)%4 == 0 then
			return 1-inv
		end
		return 0+inv
	elseif sel == 2 then
		if (x*y)%4 == 0 then
			return 1-inv
		end
		return 0+inv
	end
end

function fourline(x,y,sel,inv)
	if sel == 0 then
		if x%2 == 0 then
			if x%4 == 0 and y%16 < 8 then
				return 1-inv
			else
				return 0+inv
			end
		end
		return 1-inv
	elseif sel == 1 then
		if x%4 == 0 and y%16 < 8 then
			return 0+inv
		end
		return 1-inv
	elseif sel == 2 then
		if y%8 < 4 then
			return 0+inv
		end
		return 1-inv
	end
end

function apply()
	math.randomseed (getValue(5,0,0,1))
	x = 0
	y = 0
    tileSize = getTileSize()
	intensity = getValue(1,0,0,100)
	style = getValue(2,0,0,1)
	steps = getValue(3,0,0,1)
	for i=0, tileSize*tileSize-1 do
		x = i%tileSize
		y = math.floor(i/tileSize)
		input = getValue(0,x,y,1)*intensity
		
		if style == 0 then --No Dithering
			if input > 0.5 then
				out = 1
			else
				out = 0
			end
		elseif style == 1 then --Default Dither
			if steps == 3 then
				if input > 6/7 then out = 1
				elseif input > 5/7 then
					out = checker(x,y,2)
				elseif input > 4/7 then
					out = checker(x,y,1)
				elseif input > 3/7 then
					out = checker(x,y,0)
				elseif input > 2/7 then
					out = checker(x,y,3)
				elseif input > 1/7 then
					out = checker(x,y,4)
				else out = 0
				end
			elseif steps == 2 then
				if input > 4/5 then out = 1
				elseif input > 3/5 then
					out = checker(x,y,2)
				elseif input > 2/5 then
					out = checker(x,y,0)
				elseif input > 1/5 then
					out = checker(x,y+1,4)
				else out = 0
				end
			else
				if input > 2/3 then out = 1
				elseif input > 1/3 then
					out = checker(x,y,0)
				else out = 0
				end
			end
		elseif style == 2 then --H Lined
			if steps == 3 then
				if input > 6/7 then out = 1
				elseif input > 5/7 then
					out = checker(x+1,y,2)
				elseif input > 4/7 then
					out = lined(x,y,1)
				elseif input > 3/7 then
					out = lined(x,y,0)
				elseif input > 2/7 then
					out = lined(x,y,2)
				elseif input > 1/7 then
					out = checker(x+1,y+1,4)
				else out = 0
				end
			elseif steps == 2 then
				if input > 4/5 then out = 1
				elseif input > 3/5 then
					out = lined(x,y,1)
				elseif input > 2/5 then
					out = lined(x,y,0)
				elseif input > 1/5 then
					out = lined(x,y,2)
				else out = 0
				end
			else
				if input > 2/3 then out = 1
				elseif input > 1/3 then
					out = lined(x,y,0)
				else out = 0
				end
			end
		elseif style == 3 then --V Lined
			if steps == 3 then
				if input > 6/7 then out = 1
				elseif input > 5/7 then
					out = checker(y+1,x,2)
				elseif input > 4/7 then
					out = lined(y,x,1)
				elseif input > 3/7 then
					out = lined(y,x,0)
				elseif input > 2/7 then
					out = lined(y,x,2)
				elseif input > 1/7 then
					out = checker(y+1,x+1,4)
				else out = 0
				end
			elseif steps == 2 then
				if input > 4/5 then out = 1
				elseif input > 3/5 then
					out = checker(y+1,x,2)
				elseif input > 2/5 then
					out = lined(y,x,1)
				elseif input > 1/5 then
					out = checker(y+1,x+1,4)
				else out = 0
				end
			else
				if input > 2/3 then out = 1
				elseif input > 1/3 then
					out = lined(y,x,1)
				else out = 0
				end
			end
		elseif style == 4 then --Crossed
			if steps == 3 then
				if input > 6/7 then out = 1
				elseif input > 5/7 then
					out = checker(y,x,2)
				elseif input > 4/7 then
					out = crossd(y,x,0)
				elseif input > 3/7 then
					out = checker(y,x,1)
				elseif input > 2/7 then
					out = crossd(y,x,1)
				elseif input > 1/7 then
					out = checker(y+2,x+1,4)
				else out = 0
				end
			elseif steps == 2 then
				if input > 4/5 then out = 1
				elseif input > 3/5 then
					out = crossd(y,x,0)
				elseif input > 2/5 then
					out = checker(y,x,1)
				elseif input > 1/5 then
					out = crossd(y,x,1)
				else out = 0
				end
			else
				if input > 2/3 then out = 1
				elseif input > 1/3 then
					out = checker(y,x,1)
				else out = 0
				end
			end
		elseif style == 5 then --Blocks
			if steps == 3 then
				if input > 6/7 then out = 1
				elseif input > 5/7 then
					out = block(x,y,0,1)
				elseif input > 4/7 then
					out = block(x,y,1,0)
				elseif input > 3/7 then
					out = lined(y,x,0)
				elseif input > 2/7 then
					out = block(x,y,1,1)
				elseif input > 1/7 then
					out = block(x,y,0,0)
				else out = 0
				end
			elseif steps == 2 then
				if input > 4/5 then out = 1
				elseif input > 3/5 then
					out = block(x,y,0,1)
				elseif input > 2/5 then
					out = lined(y,x,0)
				elseif input > 1/5 then
					out = block(x,y,0,0)
				else out = 0
				end
			else
				if input > 2/3 then out = 1
				elseif input > 1/3 then
					out = block(x,y,0,0)
				else out = 0
				end
			end
		elseif style == 6 then --4x4 Vline
			if steps == 3 then
				if input > 6/7 then out = 1
				elseif input > 5/7 then
					out = fourline(x,y,1,0)
				elseif input > 4/7 then
					out = fourline(x,y,0,0)
				elseif input > 3/7 then
					out = lined(y,x,0)
				elseif input > 2/7 then
					out = fourline(x+1,y+8,0,1)
				elseif input > 1/7 then
					out = fourline(x+1,y+8,1,1)
				else out = 0
				end
			elseif steps == 2 then
				if input > 4/5 then out = 1
				elseif input > 3/5 then
					out = fourline(x,y,0,0)
				elseif input > 2/5 then
					out = lined(y,x,0)
				elseif input > 1/5 then
					out = fourline(x+1,y+8,0,1)
				else out = 0
				end
			else
				if input > 2/3 then out = 1
				elseif input > 1/3 then
					out = lined(y,x,0)
				else out = 0
				end
			end
		else --Random
			if steps == 3 then
				if input > (math.random(100,600)/700) then out = 1
				else out = 0
				end
			elseif steps == 2 then
				if input > (math.random(100,400)/500) then out = 1
				else out = 0
				end
			else
				if input > (math.random(100,200)/300) then out = 1
				else out = 0
				end
			end
		end
		
		setPixel(0,x,y,out,out,out)
	end
	
	
end
