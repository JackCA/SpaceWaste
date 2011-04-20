Trash = {}
Trash.__index = Trash
Trash.tags = {"trash"}

function Trash.create(x,y,r,image,image_size)
	local self = {radius=r,image=image,image_size=image_size,destroyed=false,fire=-1}
	setmetatable(self, Trash)
	self.body, self.shape = self:makebody(x,y,r)
	objm:register(self)
	return self
end

function Trash:makebody(x,y,radius)
	local body = love.physics.newBody(world.world, x, y, 0)
	local shape = love.physics.newCircleShape(body, radius)
	shape:setData(self)
	body:setMass(0, 0, radius/2, radius*10)
	body:setAngle(math.random(0,360))
	body:setAngularDamping(10)
	return body,shape
end

function Trash:spawn(x,y)
	self.destroyed = false
	if self.body:isFrozen() then
		self.body:destroy()
		self.shape:destroy()
		self.body, self.shape = self:makebody(x,y,self.radius)
	end
	self.body:setX(x)
	self.body:setY(y)
end

Trash.draw = {}

Trash.draw[4] = function(self)
	love.graphics.setColor(255,255,255,255)
	love.graphics.setColorMode(love.color_modulate)
	screen:draw_scale(self.image, self.body:getX(), self.body:getY(), self.body:getAngle(), self.radius/self.image_size)
	love.graphics.setColorMode(love.color_normal)
end

function Trash:update(dt)
	if self.fire>0 then
		self.fire = self.fire - dt
	end
end

function Trash:unload()
	self.destroyed = true
	local x,y = world:edge()
	self.body:setX(x)
	self.body:setY(y)
end
