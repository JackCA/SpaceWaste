Debri = {}
Debri.__index = Debri
Debri.tags = {"trash"}
Debri.maxtime = 30

function Debri.create(recycler,r,image,image_size)
	local self = {recycler=recycler,radius=r,image=image,image_size=image_size,fire=-1}
	setmetatable(self, Debri)
	local x,y = world:edge()
	self.body, self.shape = self:makebody(x,y,r)
	self.destroyed = true
	objm:register(self)
	return self
end

function Debri:makebody(x,y,radius)
	local body = love.physics.newBody(world.world, x, y, 0)
	local shape = love.physics.newCircleShape(body, radius)
	shape:setData(self)
	body:setMass(0, 0, radius/2, radius*10)
	body:setAngle(math.random(0,360))
	body:setAngularDamping(10)
	return body,shape
end

function Debri:spawn(x,y)
	self.destroyed = false
	self.time = self.maxtime
	if self.body:isFrozen() then
		self.body:destroy()
		self.shape:destroy()
		self.body, self.shape = self:makebody(x,y,self.radius)
	end
	self.body:setX(x)
	self.body:setY(y)
end

Debri.draw = {}

Debri.draw[4] = function(self)
	love.graphics.setColor(255,255,255,self.time/self.maxtime*255)
	love.graphics.setColorMode(love.color_modulate)
	screen:draw_scale(self.image, self.body:getX(), self.body:getY(), self.body:getAngle(), self.radius/self.image_size)
	love.graphics.setColorMode(love.color_normal)
end

function Debri:update(dt)
	if not self.destroyed then
		self.time = self.time-dt
		if self.time<0 then 
			self:unload()
		end
	end
	if self.fire>0 then
		self.fire=self.fire-dt
	end
end

function Debri:unload()
	self.destroyed = true
	local x,y = world:edge()
	self.body:setX(x)
	self.body:setY(y)
	self.recycler:destroy(self)
	--self.recycler.unused[self] = true -- this line causes flash
	--self.recycler.used[self] = nil
end
