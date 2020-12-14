-- freely gifted by lostastronaut.com
function init()
    setName("Circle")
    setDesc("Generates a Circle")
    setSize(108, 24+64+64+8)
    addOutput(24+32)
    addInputParameter("X Interval", "How often X", 24+64+16, 16, 1, 100)
    addInputParameter("Y Interval", "How often Y", 24+64+32, 16, 1, 100)
    addInputParameter("Radius", "How big", 24+64+48, 1, 1, 100)
end
 
function apply()
 size = getTileSize()
 x_i = getValue(1,0,0,1)
 y_i = getValue(2,0,0,1)
 cx = size/2
 cy = size/2
 radius = getValue(3,0,0,1)
 for x = 0, size -1 do
  for y = 0, size -1 do
   dist = math.sqrt( (cx - x)*(cx - x) + (cy - y)*(cy - y) )
   if ( dist <= radius ) then
    setPixel(0,x,y,1,1,1)
   else
    setPixel(0,x,y,0,0,0)
   end
  end
 end
end
