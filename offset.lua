function init()
  setName("Offset")
  setDesc("Translates the image by a specified number of pixels")
  setSize(100, 24+64+16+16+16+4)
  addOutput(24+32)
  addInput("Texture", 24+64+8)
  addParameter("X", "The amount of pixels to offset by in the X axis", 24+64+16+8, 0, 0, getTileSize())
  addParameter("Y", "The amount of pixels to offset by in the Y axis", 24+64+16+16+8, 0, 0, getTileSize())
end

function apply()
  size = getTileSize()
  xOffset = getValue(1, 0, 0, 1)
  yOffset = getValue(2, 0, 0, 1)
  for i = 0, size * size - 1 do
    p = getValue(0, i%size, math.floor(i/size), 1)
    setPixel(0, (i%size) + xOffset, math.floor(i/size) + yOffset, p, p, p)
  end
end