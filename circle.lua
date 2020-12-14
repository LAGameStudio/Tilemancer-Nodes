-- freely gifted by lostastronaut.com
function init()
    setName("Circle")
    setDesc("Generates a Circle")
    setSize(108, 24+64+16+16+8)
    addOutput(24+32)
    addInputParameter("Radius", "How big", 24+64+16, 50, 1, 100)
end
 
function apply()
 size = getTileSize()
 radius = math.floor(getValue(0,0,0,100.0)*size)
 cx = size/2
 cy = size/2
 for x = 0, size -1 do
  for y = 0, size -1 do
   dx = cx - x
   dy = cy - y
   dist = math.sqrt( dx*dx + dy*dy )
   if ( dist <= radius ) then
    setPixel(0,x,y,1,1,1)
   else
    setPixel(0,x,y,0,0,0)
   end
  end
 end
end
