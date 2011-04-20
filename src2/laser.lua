Laser = {}
Laser.__index = Laser
Laser.sound = love.audio.newSound("sounds/laser-3.wav")
Laser.explosion = love.graphics.newImage("images/unit/explosion2.png")
Laser.explosion_sound = love.audio.newSound("sounds/explosion_2.wav")
Laser.image = love.graphics.newImage("images/unit/laser-1.png")

function Laser.create(recycler)
	local laser = {anim=love.graphics.newAnimation(Laser.explosion, 96, 96, 0.1),recycler=recycler,destroyed=true}
	setmetatable(laser, Laser)
	local x,y = world:edge()
	laser.body, laser.shape = laser:makebody(x,y)
	objm:register(laser)
	return laser
end

function Laser:makebody(x,y)
	local body = love.physics.newBody(world.world, x, y, 1)
	local shape = love.physics.newCircleShape(body, .1)
	shape:setData(self)
	shape:setMask(2)
	return body,shape
end

function Laser:spawn(x,y,angle)
	if self.body:isFrozen() then
		self.body:destroy()
		self.shape:destroy()
		self.body, self.shape = self:makebody(x,y)
	end
	self.shape:setMask(2)

	self.body:setSpin(0)
	self.body:setAngle(angle)
	self.angle = angle
	self.body:setX(x)
	self.body:setY(y)
	self.body:setVelocity(100*cos(angle),100*sin(angle))


	self.destroyed=false
	self.exploding=false
	self.time = 0
	sound:play(self.sound)
--	print("laser spawn",self.body:isFrozen(),self.body:isStatic(),self.body:isDynamic(),x,y,self.body:getX(),self.body:getY())
end

Laser.draw = {}

Laser.draw[4] = function(self)
	love.graphics.setColorMode(love.color_normal)
	love.graphics.setBlendMode(love.blend_normal)

	if self.exploding then
		screen:draw_scale(self.anim, self.x, self.y, 0, 1)
	elseif not self.destroyed then
		screen:draw_scale(self.image, self.body:getX(), self.body:getY(), self.angle, 1/2)		
	end
end

function Laser:unload()
	self.destroyed=true
	local x,y = world:edge()
	self.body:setX(x)
	self.body:setY(y)
	self.recycler:destroy(self)
end

function Laser:explode(x,y)
	self.exploding = true
	self.anim:reset()
	self.x = x
	self.y = y
	if player.destroyed then 
		screen.shake = 5
	else
		screen.shake = 100 - get_distance(player.body:getX(), player.body:getY(), x, y)
	end
	if screen.shake>5 then screen.shake = 5 end
	if screen.shake<0 then screen.shake = 0 end
	sound:play(self.explosion_sound)
	Event.create(function() 
		self.exploding = false 
		screen.shake = 0
		self:unload()
	end, .32)
end

function Laser:update(dt)
	if self.exploding == true then 
		self.anim:update(dt)
	end
	self.time = self.time + dt
	if self.time>10 then self:unload() end
end

function Laser:collision(obj1, contact)
	if not self.exploding and not self.destroyed then	
		self:explode(self.body:getX(),self.body:getY()) 
	end
end
