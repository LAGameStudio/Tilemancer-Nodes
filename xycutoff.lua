-- lostastronaut.com submits free node for Tilemancer
function init()
  setName("XY-Cutoff")
  setDesc("Trims")
  setSize(100,108+96)
  addOutput(24+32)
  addInput("Texture 1", 24+64+8)
  addInput("Texture 2", 24+64+24)
-- note, if you change the size of the tile globally, you must delete and replace this node since i'm not sure how to update parameter max values
  addParameter("X", "The amount of pixels to cutoff by in the X axis", 108+16, 0, 0, 100, true)
  addParameter("Y", "The amount of pixels to cutoff by in the Y axis", 108+32, 0, 0, 100, true)
  addParameter("X Mode", "X Cutoff Mode\n0 - Greater\n1 - Less\n2 - Equals\n3 - Greater Equal\n4 - Lesser Equal", 108+48, 3, 0, 4)
  addParameter("Y Mode", "Y Cutoff Mode\n0 - Greater\n1 - Less\n2 - Equals\n3 - Greater Equal\n4 - Lesser Equal", 108+64, 3, 0, 4)
  addParameter("XY Mode", "XY Cutoff Mode\n0 - x AND y\n1 - x OR y\n2 - x XOR y\n3 - NOT (x AND y)\n4 - NOT (x OR y)\n5 - NOT (x XOR y)", 108+64+16, 0, 0, 5 )
end

function apply()
  size = getTileSize()
  xCutoff = math.floor(getValue(2, 0, 0, 1) / 100 * size)
  yCutoff = math.floor(getValue(3, 0, 0, 1) / 100 * size)
  xmode = getValue(4,0,0,1)
  ymode = getValue(5,0,0,1)
  xymode = getValue(6,0,0,1)
  for i = 0, size * size - 1 do
    x = i%size
	y = math.floor(i/size)
    ar, ag, ab = getValue(0, x, y, 1)
    br, bg, bb = getValue(1, x, y, 1)
    xCut = (xmode==0 and x > xCutoff) or (xmode==1 and x < xCutoff) or (xmode==2 and x==xCutoff) or (xmode==3 and x>=xCutoff) or (xmode==4 and x<=xCutoff)
    yCut = (ymode==0 and y > yCutoff) or (ymode==1 and y < yCutoff) or (ymode==2 and y==yCutoff) or (ymode==3 and y>=yCutoff) or (ymode==4 and y<=yCutoff)
	a=true
	if xymode==0 then
	 a = ( xCut and yCut )
	elseif xymode==1 then
	 a = ( xCut or yCut )
	elseif xymode==2 then
 	 a = ( xCut ~ yCut )
	elseif xymode==3 then
	 a = not (xCut and yCut )
	elseif xymode==4 then
	 a = not ( xCut or yCut )
	elseif xymode==5 then
 	 a = not ( xCut ~ yCut )
	end
	if ( a ) then
	    setPixel(0,x,y,ar,ag,ab)
	else
	    setPixel(0,x,y,br,bg,bb)
	end
  end
end