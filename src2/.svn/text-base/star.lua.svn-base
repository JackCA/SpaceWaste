Star = {}
Star.__index = Star
Star.image = love.graphics.newImage("images/background/star-brush.png")

function Star.create(x, y)
	local star = {}
	setmetatable(star, Star)
	star.x = x
	star.y = y
	star.speed = math.random(2,255)
	star.color = love.graphics.newColor(math.random(200,255), math.random(200,255), math.random(200,255), star.speed)
	star.draw = {}
	star.draw[math.floor(star.speed/255*8)] = draw_star

	objm:register(star)

	return star
end

function draw_star(self)
	love.graphics.setColorMode(love.color_modulate)
	love.graphics.setBlendMode(love.blend_additive)
	love.graphics.setColor(self.color)
	screen:draw_far(self.image, self.x, self.y, 0, self.speed/255/10, self.speed/100)
	love.graphics.setColorMode(love.color_normal)
	love.graphics.setBlendMode(love.blend_normal)
end
