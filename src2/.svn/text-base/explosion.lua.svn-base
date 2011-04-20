Explosion = {}
Explosion.__index = Explosion
Explosion.image = love.graphics.newImage("images/unit/explosion2.png")
Explosion.sound = love.audio.newSound("sounds/explosion_2.wav")

function Explosion.create(x,y,angle,scale)
	local explosion = {anim=love.graphics.newAnimation(Explosion.image, 96, 96, 0.1),destroyed=false,x=x,y=y,angle=angle,scale=scale or 1}
	setmetatable(explosion, Explosion)
	explosion.anim:reset()
	sound:play(Explosion.sound)
	screen.shake = 100 - get_distance(player.body:getX(), player.body:getY(), x, y)
	if screen.shake>5 then screen.shake = 5 end
	if screen.shake<0 then screen.shake = 0 end

	Event.create(function() 
		screen.shake = 0
		explosion:unload()
	end, .32)

	objm:register(explosion)
	return explosion
end

Explosion.draw = {}

Explosion.draw[5] = function(self)
	love.graphics.setColorMode(love.color_normal)
	love.graphics.setBlendMode(love.blend_normal)

	screen:draw_scale(self.anim, self.x, self.y, self.angle, self.scale)
end

function Explosion:unload()
	if self.trigger then self.trigger() end
	self.destroyed=true
end

function Explosion:update(dt)
	self.anim:update(dt)
end
