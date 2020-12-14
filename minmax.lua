function init()
 setName("Min/Max")
 setDesc("Sets black and white values")
 setSize(100, 24+64+8+8+7+4+18+18+18)
 addOutput(24+32)
 addInput("Texture", 24+64+8+8)
 addParameter("Auto","Auto-get white and black values", 24+64+8+8+18, 0, 0, 1 )
 addInputParameter("Max", "White Value", 24+64+8+8+18+18, 100, 0, 100, true)
 addInputParameter("Min", "Black Value", 24+64+8+8+18+18+18, 0, 0, 100, true)
end

function apply()
 tileSize = getTileSize()
 whitemax=0
 blackmin=1
 if getValue(1,0,0,1)==1 then
  autominmax=true
  for i=0,tileSize*tileSize-1 do
   x = i%tileSize
   y = math.floor(i/tileSize)
   cr, cg, cb = getValue(0, x, y, 1.0)
   whitemax = math.max(whitemax,cr)
   whitemax = math.max(whitemax,cg)
   whitemax = math.max(whitemax,cb)
   blackmin = math.min(blackmin,cr)
   blackmin = math.min(blackmin,cg)
   blackmin = math.min(blackmin,cb)
  end
 else
  autominmax=false
 end
 
