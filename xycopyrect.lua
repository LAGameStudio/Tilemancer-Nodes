-- lostastronaut.com submits free node for Tilemancer
function init()
  setName("XY-CopyRect")
  setDesc("Creates a repeating pattern")
  setSize(100,108+124+16)
  addOutput(24+32)
  addInput("Texture", 24+64+8)
-- note, if you change the size of the tile globally, you must delete and replace this node since i'm not sure how to update parameter max values
  addParameter("Copy X", "Copy area X (left)", 108+16, 0, 0, 100, true)
  addParameter("Copy Y", "Copy area Y (top)", 108+32, 0, 0, 100, true)
  addParameter("Width", "Copy area (width)", 108+48, 50, 0, 100, true)
  addParameter("Height", "Copy area (height)", 108+64, 50, 0, 100, true)
  addParameter("Offset X", "Shift start of copied area", 108+80, 0, 0, 100, true)
  addParameter("Offset Y", "Shift start of copied area", 108+96, 0, 0, 100, true)
  addParameter("Stag X", "Stagger alternating rows of copied areas by X", 108+112, 0, 0, 100, true)
  addParameter("Stag Y", "Stagger alternating columns of copied areas by Y", 108+132, 0, 0, 100, true)
end

function apply()
  size = getTileSize()
  x = math.floor(getValue(1,0,0,1) / 100.0 * size)
  y = math.floor(getValue(2,0,0,1) / 100.0 * size)
  w = math.max(1,math.floor(getValue(3,0,0,1) / 100.0 * size))
  h = math.max(1,math.floor(getValue(4,0,0,1) / 100.0 * size))
  ofsx = math.floor(getValue(5,0,0,1) / 100.0 * size)
  ofsy = math.floor(getValue(6,0,0,1) / 100.0 * size)
  stagx = math.floor(getValue(7,0,0,1) / 100.0 * size)
  stagy = math.floor(getValue(8,0,0,1) / 100.0 * size)
  for dy = 0, size - 1 do
   for dx = 0, size - 1 do
    gx = (dx + ofsx) % w + x
    gy = (dy + ofsy) % h + y
	if stagx > 0 then
		row = math.floor(dy / h)
		if ( row % 2 == 1 ) then
		   gx = gx + stagx
        end
	end
	if stagy > 0 then
		col = math.floor(dx / w)
		if ( col % 2 == 1 ) then
		  gy = gy + stagy
        end
	end
	r,g,b=getValue(0,gx,gy,1)
	setPixel(0,dx,dy, r,g,b)
   end
  end
end