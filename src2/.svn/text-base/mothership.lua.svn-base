Mothership = {}
Mothership.__index = Mothership
Mothership.image = love.graphics.newImage("images/unit/ship-trash.png")

function Mothership.create(x,y,radius)

	local mothership = {light=1, radius=radius, time=0}
	setmetatable(mothership, Mothership)
	mothership.body = love.physics.newBody(world.world, x, y, 0)
	mothership.shape = love.physics.newPolygonShape(mothership.body, (621-750)*radius/150, (534-750)*radius/150, (138-750)*radius/150, (819-750)*radius/150, (375-750)*radius/150, (1014-750)*radius/150, (1371-750)*radius/150, (696-750)*radius/150)
	mothership.shape:setData(mothership)
	mothership.body:setMassFromShapes()

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

	mothership.particle = p

	mothership.beacon = Beacon.create((693-750)*mothership.radius/150, (880-750)*mothership.radius/150, mothership)

	objm:register(mothership)
	return mothership
end

Mothership.draw = {}

Mothership.draw[4] = function(self)
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
	love.graphics.draw(self.particle, screen:tx(enginex2+self.body:getX()), screen:ty(enginey2+self.body:getY()))
	love.graphics.setColorMode(love.color_normal)
	love.graphics.setBlendMode(love.blend_normal)

	screen:draw_scale(self.image, x, y, self.body:getAngle(), self.radius/150)


	--love.graphics.setColor(255,0,0)
	--screen:polygon(love.draw_fill, self.shape:getPoints())

end

function Mothership:update(dt)
end

function Mothership:unload()
	self.destroyed = false
	self.body:destroy()
	self.shape:destroy()
	self.body = nil
	self.shape = nil
	self.beacon:unload()
end

function Mothership:collision(obj, contact)
	--1356, 660
  --507, 1212; 462, 1260 = 65
 	--765, 1257; 840, 1335 = 108
	--[[
	local x,y = contact:getPosition()
	if obj~=nil and obj.__index==Trash then
		--TODO must account for the angles
		print(get_distance(x-self.body:getX(),self.body:getY()-y,(507-750)*self.radius/150,(462-750)*self.radius/150))
	end
	--]]

	self.beacon:collision(obj,contact)
end
