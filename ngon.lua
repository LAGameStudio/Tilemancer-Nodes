-- N-gone by helyx
function init()
  setName("Ngon")
  setDesc("Generates a regular polygon")
  setSize(100, 24+64+8+8+18+7+4)
  addOutput(24+32)
  addParameter("Sides", "Side Count", 24+64+8+8, 3, 3, 10)
  addParameter("Angle", "Rotation of Polygon", 24+64+8+8+18, 0, 0, 360)
end

function apply()
  tileSize = getTileSize()
  radius = tileSize/2
  sides = getValue(0,0,0,1)
  rotation = getValue(1,0,0,1)

  for tx=0, tileSize-1 do
    for ty=0, tileSize-1 do
      inPoly = false
      x = tx+0.5-radius
      y = ty+0.5-radius
      j = sides-1
      for i=0, sides-1 do
        ir = i/sides * math.pi*2 + math.rad(rotation)
        jr = j/sides * math.pi*2 + math.rad(rotation)

        vi = {
          x=math.sin(ir)*radius,
          y=math.cos(ir)*radius,
        }
        vj = {
          x=math.sin(jr)*radius,
          y=math.cos(jr)*radius,
        }
        if ((vi.y >= y) ~= (vj.y > y)) and (x <= (vj.x - vi.x) * (y - vi.y) / (vj.y - vi.y) + vi.x) then
          inPoly = not inPoly
        end
        j = i
      end
      if inPoly then
        setPixel(0,tx,ty,1,1,1)
      else
        setPixel(0,tx,ty,0,0,0)
      end
    end
  end
end
