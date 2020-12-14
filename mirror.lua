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
  v = getValue(1,0,0,1)/100.0
  h = getValue(1,0,0,1)/100.0
  for gx = 0, size - 1 do
   for gy = 0, size - 1 do
     if ( gx >= h ) then
       sx = gx - h
     else
       sx = -gx
     end
     if ( yx >= v ) then
       sy = gy - v
     else
       sy = -gy
     end
     r,g,b=getValue(0,sx,sy,1)
     setPixel(0,gx,gy, r,g,1.0)
   end
  end
end
