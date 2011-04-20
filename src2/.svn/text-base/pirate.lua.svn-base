Pirate = {}
Pirate.__index = Pirate
Pirate.image = love.graphics.newImage("images/unit/ship-pirate-only.png")
Pirate.image2 = love.graphics.newImage("images/unit/ship-pirate-only2.png")
Pirate.engine1 = love.graphics.newImage("images/unit/ship-pirate-l.png")
Pirate.engine2 = love.graphics.newImage("images/unit/ship-pirate-r.png")
Pirate.engine12 = love.graphics.newImage("images/unit/ship-pirate-l2.png")
Pirate.engine22 = love.graphics.newImage("images/unit/ship-pirate-r2.png")
Pirate.explosion = love.graphics.newImage("images/unit/explosion.png")
Pirate.explosion_sound = love.audio.newSound("sounds/explosion_2.wav")
Pirate.pieces = {love.graphics.newImage("images/unit/ship-pirate-piece1.png"),love.graphics.newImage("images/unit/ship-pirate-piece2.png"),love.graphics.newImage("images/unit/ship-pirate-piece3.png"),love.graphics.newImage("images/unit/ship-pirate-piece4.png"),love.graphics.newImage("images/unit/ship-pirate-piece5.png"),love.graphics.newImage("images/unit/ship-pirate-piece6.png")}
function Pirate.create(x,y,radius)

	local pirate = {light=1, radius=radius,mode="init",time=0}
	setmetatable(pirate, Pirate)
	pirate.body = love.physics.newBody(world.world, x, y, 0)
	pirate.shape = love.physics.newPolygonShape(pirate.body, (315-750)*radius/150, (819-750)*radius/150, (609-750)*radius/150, (1272-750)*radius/150, (1173-750)*radius/150, (1227-750)*radius/150, (1239-750)*radius/150, (975-750)*radius/150)
	pirate.shape:setData(pirate)
	pirate.body:setMassFromShapes()

	local p = love.graphics.newParticleSystem(love.graphics.newImage("images/part1.png"), 1000)
	p:setEmissionRate(1000)
	p:setSpeed(200, 250)
	p:setGravity(100, 200)
	p:setSize(1, 1)
	p:setColor(clr(220, 105, 20, 255), clr(194, 30, 18, 0))
	p:setPosition(400, 300)
	p:setLifetime(.8)
	p:setParticleLife(.8)
	p:setDirection(180)
	p:setSpread(50)
	p:stop()

	pirate.particle = p

	pirate.beacon1 = Beacon.create((528-750)*pirate.radius/150, (1170-750)*pirate.radius/150, pirate)
	pirate.beacon2 = Beacon.create((786-750)*pirate.radius/150, (1209-750)*pirate.radius/150, pirate)

	objm:register(pirate)
	return pirate
end

Pirate.draw = {}

Pirate.draw[3] = function(self)
	--[[
	local x,y = self.body:getX(), self.body:getY()
	love.graphics.setColorMode(love.color_modulate)
	love.graphics.setColor(255*self.light, 255*self.light, 255*self.light, 255)
	screen:draw_scale(self.image, x, y, self.body:getAngle(), self.radius/150)
	love.graphics.setColorMode(love.color_normal)
--]]
	local x,y = self.body:getX(), self.body:getY()

	love.graphics.setColorMode(love.color_modulate)
	love.graphics.setBlendMode(love.blend_additive)
	local enginex, enginey = (1000-750)*self.radius/150, (1100-750)*self.radius/150
	local enginex2, enginey2 = enginex*cos(self.body:getAngle())-enginey*sin(self.body:getAngle()),
		enginex*sin(self.body:getAngle())+enginey*cos(self.body:getAngle())
	self.particle:setPosition(0,0)
	if self.mode=="escaping" then
	love.graphics.draw(self.particle, screen:tx(-enginex2+self.body:getX()), screen:ty(enginey2+self.body:getY()))
	else
	love.graphics.draw(self.particle, screen:tx(enginex2+self.body:getX()), screen:ty(enginey2+self.body:getY()))
	end
	love.graphics.setColorMode(love.color_normal)
	love.graphics.setBlendMode(love.blend_normal)

	if self.mode=="escaping" then
		screen:draw_scale(self.image2, x, y, self.body:getAngle(), self.radius/150)
	else
		screen:draw_scale(self.image, x, y, self.body:getAngle(), self.radius/150)
	end
	love.graphics.setColorMode(love.color_modulate)

	local color = {255,255,255}
	if self.beacon1.trash==1 then color={255,255,0} end
	if self.beacon1.trash==2 then color={255,0,0} end
	if self.beacon1.trash<3 then
		love.graphics.setColor(unpack(color))
		if self.mode=="escaping" then
		screen:draw_scale(self.engine12, self.beacon1:getX(), self.beacon1:getY(), self.body:getAngle(), self.radius/150)
		else
		screen:draw_scale(self.engine1, self.beacon1:getX(), self.beacon1:getY(), self.body:getAngle(), self.radius/150)
		end
	end
	color = {255,255,255}
	if self.beacon2.trash==1 then color={255,255,0} end
	if self.beacon2.trash==2 then color={255,0,0} end
	if self.beacon2.trash<3 then
		love.graphics.setColor(unpack(color))
		if self.mode=="escaping" then
		screen:draw_scale(self.engine22, self.beacon2:getX(), self.beacon2:getY(), self.body:getAngle(), self.radius/150)
		else
		screen:draw_scale(self.engine2, self.beacon2:getX(), self.beacon2:getY(), self.body:getAngle(), self.radius/150)
		end
	end

	love.graphics.setColorMode(love.color_normal)

	--love.graphics.setColor(255,0,0)
	--screen:polygon(love.draw_fill, self.shape:getPoints())

	for _,a in pairs(self.anim or {}) do
		screen:draw_scale(a.anim, a.x, a.y, 0, a.scale) 
	end
end

function Pirate:escape()
	self.mode="escaping"
	self.body:setMassFromShapes()
	self.shape:destroy()
	self.shape = love.physics.newPolygonShape(self.body, -(315-750)*self.radius/150, (819-750)*self.radius/150, -(609-750)*self.radius/150, (1272-750)*self.radius/150, -(1173-750)*self.radius/150, (1227-750)*self.radius/150, -(1239-750)*self.radius/150, (975-750)*self.radius/150)
	pirate.shape:setData(pirate)
end

function Pirate:update(dt)
	if self.mode=="moving" then
		--local tx,ty = 450,380
		local tx,ty = 500,380
		local angle = get_degree(self.body:getX(),self.body:getY(),tx,ty)-90
		local dist = get_distance(self.body:getX(),self.body:getY(),tx,ty)
		local angle2 = angle*math.max(1-math.exp(-dist),0)
		self.body:setAngle(angle2)
		self.particle:setDirection(angle2)
		self.body:setVelocity(-10*cos(angle),-10*sin(angle))
		self.particle:start()
		if dist<.2 then 
			self.body:setVelocity(0,0)
			self.mode = "fixed"
			self.particle:stop()
			self.body:setMass(0,0,0,0)

			if self.trigger_fix then self.trigger_fix() end
			--self:spawn()
		end
		self.x = self.body:getX()
		self.y = self.body:getY()
	end

	if self.mode=="escaping" then
		local tx,ty = 1000,380
		local angle = get_degree(self.body:getX(),self.body:getY(),tx,ty)-90
		local dist = get_distance(self.body:getX(),self.body:getY(),tx,ty)
		local angle2 = angle*math.max(1-math.exp(-dist),0)
		self.body:setAngle(angle2-180)
		self.particle:setDirection(angle2)
		self.body:setVelocity(-10*cos(angle),-10*sin(angle))
		self.particle:start()
		if dist<.2 then 
			self.body:setVelocity(0,0)
			self.mode = "fixed"
			self.particle:stop()
			self.body:setMass(0,0,0,0)
		end
		self.x = self.body:getX()
		self.y = self.body:getY()
	end

	if not player.destroyed and get_distance(self.body:getX(),self.body:getY(),player.body:getX(),player.body:getY())<150 then
		if self.trigger_dist then self.trigger_dist() end
	end

	self.particle:update(dt)

	for _,a in pairs(self.anim or {}) do
		a.anim:update(dt)
	end

end

function Pirate:unload()
	self.destroyed = true
	self.body:destroy()
	self.shape:destroy()
	self.body = nil
	self.shape = nil
	if self.beacon1~=nil then self.beacon1:unload() end
	if self.beacon2~=nil then self.beacon2:unload() end
end

function Pirate:explode()
	local x, y = self.body:getX(),self.body:getY()
	for i=1,20 do
	Event.create(function() 
		Explosion.create(x+math.random(-50, 100),y+math.random(0,60),0,math.random()*2)
	end, 20/(21-i))
	end

	Event.create(function()
		for i=1,6 do
			local trash = Trash.create(self.body:getX()+math.random(-50, 100),self.body:getY()+math.random(0,60),5,self.pieces[i],37.5)
			trash.body:applyImpulse(50+math.random()*100,50+math.random()*100)
		end
		self:unload() 
	end, 1)
end

function Pirate:collision(obj, contact)
	if self.beacon1~=nil then	self.beacon1:collision(obj,contact) end
	if self.beacon2~=nil then self.beacon2:collision(obj,contact) end
end
