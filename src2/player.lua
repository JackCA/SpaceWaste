Player = {}
Player.__index = Player
Player.healthbar = {love.graphics.newImage("images/interface/meter-25.png"),love.graphics.newImage("images/interface/meter-50.png"),love.graphics.newImage("images/interface/meter-75.png"),love.graphics.newImage("images/interface/meter-full.png")}
Player.image = love.graphics.newImage("images/player/pose-front.png")
Player.dead = love.graphics.newImage("images/player/s-calder-dead.png")

function Player.create(x, y)
	temp = {light=1,hp=4}
	setmetatable(temp, Player)
	temp.body = love.physics.newBody(world.world, x, y)
	temp.size = 5
	temp.shape = love.physics.newCircleShape(temp.body, temp.size)
	temp.shape:setData(temp)

	temp.body:setMassFromShapes()
	temp.body:setDamping(1)
	temp.body:setAngularDamping(10)
	
	objm:register(temp)

	local p = love.graphics.newParticleSystem(love.graphics.newImage("images/part1.png"), 1000)
	p:setEmissionRate(60)
	p:setSpeed(100, 50)
	p:setSize(2, 3, 1)
	p:setColor(clr(240, 3, 176, 255), clr(204, 240, 3, 0))
	p:setPosition(400, 300)
	p:setLifetime(1)
	p:setParticleLife(10)
	p:setDirection(90)
	p:setSpread(0)
	p:setSpin(300, 800)
	p:stop()

	temp.particle = p

	return temp
end

function Player:respawn(x,y)
    self.body:setX(x)
	self.body:setY(y)
end


function Player:getAngle(x,y)
	local dx = x - screen:tx(self.body:getX())
	local dy = y - screen:ty(self.body:getY())

	local angle = math.atan2(dy,dx)/math.pi*180
	return angle
end

function Player:update(dt)
	if self.freeze then return end

	local force = 7000*dt

	if love.keyboard.isDown(love.key_s) then
		self.body:applyImpulse(0,force)
	end

	if love.keyboard.isDown(love.key_w) then
		self.body:applyImpulse(0,-force)
	end

	if love.keyboard.isDown(love.key_d) then
		self.body:applyImpulse(force, 0)
	end

	if love.keyboard.isDown(love.key_a) then
		self.body:applyImpulse(-force, 0)
	end

	local angle = self:getAngle(love.mouse.getX(), love.mouse.getY())

	if math.abs(angle)<90 then
		angle = angle/10
	else
		if angle<0 then
			angle = angle+360
		end
		angle = (angle-180)/10
	end
	self.body:setAngle(angle)
	self.light = 1

	--[[
	for _,planet in ipairs(planets) do
		self.light = self.light * planet:getLight(self.body:getX(), self.body:getY())
	end
	--]]
	local vx,vy = self.body:getVelocity()
	self.particle:setDirection(get_degree(0,0,vx,vy)-90)

	if self.trippy then
		self.particle:start()
	end
	self.particle:update(dt)
end


Player.draw = {}
Player.draw[5] = function(self)
		love.graphics.setColorMode(love.color_modulate)
		love.graphics.setBlendMode(love.blend_additive)
		self.particle:setPosition(screen:tx(self.body:getX()), screen:ty(self.body:getY()))
		love.graphics.draw(self.particle, 0, 0)
		love.graphics.setBlendMode(love.blend_normal)

		love.graphics.setColor(love.graphics.newColor(255*self.light,255*self.light,
			255*self.light, 255))
	screen:draw_scale(self.image, self.body:getX(), self.body:getY(),	self.body:getAngle(), self.size/28)
		love.graphics.setColorMode(love.color_normal)
end

Player.draw[9] = function(self)
	local img = self.healthbar[self.hp]
	if img~=nil then
		love.graphics.draw(img, screen.width-50-img:getWidth()/2, screen.height-50)
	end
end

function Player:incrementMass(m)
	self.body:setMass(0,0,self.body:getMass()+m,self.body:getInertia())
end

function Player:unload()
	self.destroyed = true
	self.body:destroy()
	self.body = nil
	self.shape:destroy()
	self.shape = nil
end

function Player:collision(obj, contact)
	if self.freeze then return end

	if obj~=nil and obj.__index==Laser then
		self.hp = self.hp-1
	end
end
