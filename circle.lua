-- freely gifted by lostastronaut.com
function init()
    setName("Circles")
    setDesc("Generates Circles")
    setSize(108, 24+64+8)
    addOutput(24+32)
    addInputParameter("X Interval", "How often X", 24+16, 16, 1, 100)
    addInputParameter("Y Interval", "How often Y", 24+32, 16, 1, 100)
    addInputParameter("Radius", "How big", 24+48, 1, 1, 100)
end
 
function apply()
 size = getTileSize()
 x_i = getValue(1,0,0,1)
 y_i = getValue(2,0,0,1)
 rad = getValue(3,0,0,1)
 for x = 0, size -1 do
  for y = 0, size -1 do
   cx = x % x_i
   cy = y % y_i
   dist = math.sqrt( (cx - x)*(cx - x) + (cy - y)*(cy - y) )
   if ( dist <= rad ) then
    setPixel(0,x,y,1,1,1)
   else
    setPixel(0,x,y,0,0,0)
   end
  end
 end
end
