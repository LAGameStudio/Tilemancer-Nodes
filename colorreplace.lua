-- freely gifted by lostastronaut.com
function init()
    setName("Color Replace")
    setDesc("Replaces a color with another")
    setSize(108, 204+16+4)
    addOutput(24+32)
    addInput("Texture", 24+64+16)
    addParameter("Fuzziness", "How far off a color can be to match", 108+16, 0, 0, 100,true)
    addParameter("R", "search", 108+16, 100, 1, 100,true)
    addParameter("G", "search", 108+32, 0, 1, 100,true)
    addParameter("B", "search", 108+48, 100, 1, 100,true)
    addParameter("to R", "replace", 108+64, 100, 0, 100,true)
    addParameter("   G", "replace", 108+80, 0, 0, 100,true)
    addParameter("   B", "replace", 108+96, 100, 0, 100,true)
end
 
function apply()
 size = getTileSize()
 fuzziness = getValue(1,0,0,1)
 r1 = getValue(2,0,0,100.0)
 g1 = getValue(3,0,0,100.0)
 b1 = getValue(4,0,0,100.0)
 r2 = getValue(5,0,0,100.0)
 g2 = getValue(6,0,0,100.0)
 b2 = getValue(7,0,0,100.0)
 for x = 0, size -1 do
  for y = 0, size -1 do
   r,g,b=getValue(0,x,y,1)
   if ( fuzziness == 0 ) then
    if (r == r1 and g == g1 and b == b1) then
     setValue(0,x,y,r2,g2,b2)
    else
     setValue(0,x,y,r,g,b)
    end
   else
    if ( r > r1-fuzziness and r < r1+fuzziness and g > g1-fuzziness and g < g1+fuzziness and b < b1-fuzziness and b > b1+fuzziness ) then
     setValue(0,x,y,r2,g2,b2)
    else
     setValue(0,x,y,r,g,b)
    end
   end
  end
 end
end
