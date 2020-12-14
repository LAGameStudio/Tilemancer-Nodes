-- lostastronaut.com submits free node for Tilemancer
function init()
  setName("Mirror")
  setDesc("Provides mirroring across an X and Y line")
  setSize(100,108+32)
  addOutput(24+32)
  addInput("Texture", 24+64+8)
  addParameter("Vert","Vertical Position of Mirror Edge", 24+64+8+16, 0, 0, 100, true );
  addParameter("Horiz","Horiz Position of Mirror Edge", 24+64+8+32, 0, 0, 100, true );
end

function apply()
  size = getTileSize()
  v = math.floor(getValue(1,0,0,100.0) * size)
  h = math.floor(getValue(2,0,0,100.0) * size)
  for x = 0, size - 1 do
   for y = 0, size - 1 do
     if ( x >= h ) then
       sx = x - h
     else
       sx = -x + h
     end
     if ( y >= v ) then
       sy = y - v
     else
       sy = -y + v
     end
     r,g,b=getValue(0,sx,sy,1)
     setPixel(0,x,y,r,g,b)
   end
  end
end
