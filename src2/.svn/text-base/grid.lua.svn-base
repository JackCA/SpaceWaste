Grid = {}
Grid.__index = Grid

function Grid.create()
	temp = {}
	setmetatable(temp, Grid)
	temp.images = {}
	temp.tiles = {}
	for i=1,8 do
		table.insert(temp.images, love.graphics.newImage("images/background/starfield"..i..".png"))
	end
	for i=0,10 do
		for j=0,10 do
			temp.tiles[i*11+j] = math.random(1,8)
		end
	end

	objm:register(temp)
	return temp
end

function Grid:update(dt)
end

Grid.draw = {}

Grid.draw[1] = function(self)
	for i=0,10 do
		for j=0,10 do
			screen:draw_far(self.images[1], i*249.9, j*249.9, 0, .25, 1.5)
		end
	end
end
