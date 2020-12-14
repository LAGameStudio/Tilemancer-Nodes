-- lostastronaut.com submits free node for Tilemancer
function init()
  setName("NormalMap")
  setDesc("Converts a grayscale pattern to a normal map")
  setSize(100,108)
  addOutput(24+32)
  addInput("Texture", 24+64+8)
end

function apply()
  size = getTileSize()
  for gx = 0, size - 1 do
   for gy = 0, size - 1 do
	r,g,b=getValue(0,gx,gy-1,1)
	La = (r+g+b)/3.0;
	r,g,b=getValue(0,gx-1,gy,1)
	Lb = (r+g+b)/3.0;
	r,g,b=getValue(0,gx+1,gy,1)
	Lc = (r+g+b)/3.0;
	r,g,b=getValue(0,gx,gy+1,1)
	Ld = (r+g+b)/3.0;
	vx = La - Ld
	vy = Lb - Lc
	m = math.sqrt(vx*vx + vy*vy + 1.0)
	if ( m ~= 0 and m ~= 1 ) then
	 vx = vx / m
	 vy = vy / m
	end
	r=math.min(1.0,math.max(0.0,(vx + 1.0)/2.0))
	g=math.min(1.0,math.max(0.0,(vy + 1.0)/2.0))
	setPixel(0,gx,gy, r,g,1.0)
   end
  end
end