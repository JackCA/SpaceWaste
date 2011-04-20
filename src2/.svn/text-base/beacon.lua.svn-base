Beacon = {}
Beacon.__index = Beacon

function Beacon.create(x,y,unit)
	temp = {x=x,y=y,time=0,unit=unit,trash=0,active=false}
	setmetatable(temp, Beacon)
	objm:register(temp)
	return temp
end

function Beacon:update(dt)
	self.time = self.time+dt
	if self.time>1 then self.time = 0 end
end

Beacon.draw = {}

Beacon.draw[8] = function(self)
	if not self.active then return end
	love.graphics.setColor(200,50,50,150*(1-self.time)+100)
	love.graphics.setLineWidth(5)

	screen:circle(love.draw_line, self:getX(), self:getY(), 10*self.time)
end

function Beacon:getX()
	local angle = self.unit.body:getAngle()
	return self.x*cos(angle)-self.y*sin(angle)+self.unit.body:getX()
end

function Beacon:getY()
	local angle = self.unit.body:getAngle()
	return self.y*cos(angle)+self.x*sin(angle)+self.unit.body:getY()
end

function Beacon:collision(obj,contact)
	if not self.active then return end
	if obj==nil or obj.tags==nil or obj.tags[1]~="trash" or self.destroyed then return end
	if obj.fire<=0 then return end

	local x,y = contact:getPosition()
	local dist = get_distance(x,y,self:getX(),self:getY())

	if dist<12 then 
		self.trash=self.trash+1
		obj:unload()
		if self.trigger then self.trigger() end
	end
end

function Beacon:unload()
	self.destroyed=true
end
