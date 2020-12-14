function init()
  setName("Simple Color")
  setDesc("Colors the image using one set color.")
  setSize(100, 24+64+16+16+16+16+16+4)
  addOutput(24+32)
  addInput("Texture", 24+64+8)
  addParameter("Red", "The red value.", 24+64+16+8, 0, 0, 255)
  addParameter("Green", "The green value.", 24+64+16+16+8, 0, 0, 255)
  addParameter("Blue", "The blue value.", 24+64+16+16+16+8, 0, 0, 255)
  addParameter("Quantize", "Reduces the number of shades used.", 24+64+16+16+16+16+8, 1, 1, 100)
end

function apply()
  size = getTileSize()
  red = getValue(1, 0, 0, 255)
  green = getValue(2, 0, 0, 255)
  blue = getValue(3, 0, 0, 255)
  q = getValue(4, 0, 0, 1)
  
  for x = 0, size do
    for y = 0, size do
      p = getValue(0, x, y, 1) * 100
      p = (math.floor(p / q) * q) / 100
      setPixel(0, x, y, red * p, green * p, blue * p)
    end
  end
end
