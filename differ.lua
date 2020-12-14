-- Toodice's dither
function init()
  setName("Differ")
  setDesc("A poor man's edge detection")
  setSize(100, 24+64+16+16+16+4)
  addOutput(24+32)
  addInput("Texture", 24+64+8)
  addParameter("Delta", "Detection sensitivity", 24+64+16+8, 20, 1, 200)
  addParameter("N'hood", "0 - Moore (normal), 1 - Moore (skinny), 2 - Von Neumann, 3 - Horizontal Only, 4 - Vertical Only", 24+64+16+16+8, 0, 0, 4)
end

function apply()
  size = getTileSize()
  temp = {}
  delta = getValue(1, 0, 0, 400)
  neigh = getValue(2, 0, 0, 1)

  for i = 0, size*size - 1 do
    temp[i] = 0
    x = i%size
    y = math.floor(i/size)
    v = getValue(0, x, y, 1)
    if neigh == 0 then
      dif = math.max(math.abs(v - getValue(0, x + 1, y, 1)), math.abs(v - getValue(0, x + 1, y + 1, 1)), math.abs(v - getValue(0, x, y + 1, 1)), math.abs(v - getValue(0, x + 1, y - 1, 1)))
    elseif neigh == 1 then
      dif = math.max(math.abs(v - getValue(0, x + 1, y, 1)), math.abs(v - getValue(0, x + 1, y + 1, 1)), math.abs(v - getValue(0, x, y + 1, 1)))
    elseif neigh == 2 then
      dif = math.max(math.abs(v - getValue(0, x + 1, y, 1)), math.abs(v - getValue(0, x, y + 1, 1)))
    elseif neigh == 3 then
      dif = math.abs(v - getValue(0, x + 1, y, 1))
    elseif neigh == 4 then
      dif = math.abs(v - getValue(0, x, y + 1, 1))
    end
    if dif >= delta then temp[i] = 1 end
  end
  
  for i = 0, size*size - 1 do
    setPixel(0, i%size, math.floor(i/size), temp[i], temp[i], temp[i])
  end
end
