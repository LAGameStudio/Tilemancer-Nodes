--made by rerere284
function init()
    setName("Inflate Heightmap")
    setDesc("Makes a Heightmap be inflated, and textured with Surface.")
    setSize(100, 24+64+8+8+18+18+7+4)
    addOutput(24+32)
    addInput("Surface", 24+64+8+8)
	addInput("Heightmap", 24+64+8+8+18)
	addParameter("Loop", "Set whether it loops off the top of the screen or not", 24+64+8+8+18+18, 1, 0, 1)
end



function apply()
    tileSize = getTileSize()
	
	layers = {} --onion
	numlayers = 0
	loop = getValue(2, 0, 0, 1)
	
	--go through each pixel
    for i=0, tileSize*tileSize-1 do
        x = i%tileSize
        y = math.floor(i/tileSize)
        rr, rg, rb = getValue(0, x, y, 1) --get pixels at that location for both
        hr, hg, hb = getValue(1, x, y, 1)
		h = ((hr+hg+hb)/3) * (tileSize/2)
		--for each layer in a column at that pixel of height h
		for j=0,math.max(h,0) do
			layer = math.ceil(((tileSize-y)+j) / tileSize)-1
			--for all layers up to your layer
			for k=numlayers,layer do
				--make that layer if it isn't there
				if layers[k] == nil then
					layers[k] = {}
					numlayers = k
				end
			end
			--set the pixel at that layer to the first input at the current position
			--if loop == 1 then
				layers[layer][(((tileSize-y)+j-(tileSize*layer)-1) * tileSize)+x] = {rr,rg,rb}
			--else
				--layers[layer][(((tileSize-y)+j-1) * tileSize)+x] = {rr,rg,rb}
			--end
		end
    end
	
	if loop == 0 then numlayers = 0 end
	
	for j=0,numlayers do
		if layers[j] ~= nil then
			
			for i=0, tileSize*tileSize-1 do
				if layers[j][i] ~= nil then
					
