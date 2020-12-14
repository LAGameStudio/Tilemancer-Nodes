function init()
    setName("Colorizer")
    setDesc("Colors texture")
    setSize(108, 24+128+18)
    addOutput(24+32)
    addInput("Texture", 24+64+8+8)
    addParameter("R","Red Component",24+64+18+18,100,0,100)
    addParameter("G","Red Component",24+64+36+18,100,0,100)
    addParameter("B","Red Component",24+64+36+36,100,0,100)
end

function apply()
  size=getTileSize()
  cr = getValue(1,0,0,1)/100.0
  cg = getValue(2,0,0,1)/100.0
  cb = getValue(3,0,0,1)/100.0
  for dx=0, size-1 do
        for dy=0, size-1 do
            r,g,b=getValue(0,dx,dy,1)
            lum = (r+g+b)/3.0
            setPixel(0,dx,dy,lum*cr,lum*cg,lum*cb)
        end
  end
end
