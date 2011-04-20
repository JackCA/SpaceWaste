Beacon2 = {}
Beacon2.__index = Beacon2

function Beacon2.create(x,y,unit)
	temp = {x=x,y=y,time=0,unit=unit,trash=0,active=false}
	setmetatable(temp, Beacon2)
	objm:register(temp)
	return temp
end

function Beacon2:update(dt)
	if not self.active then return end
	self.time = self.time+dt
	if self.time>1 then self.time = 0 end
	if get_distance(self.unit.body:getX(),self.unit.body:getY(),self.x,self.y) < 12 then
		if self.trigger then self.trigger() end
	end
end

Beacon2.draw = {}

Beacon2.draw[8] = function(self)
	if not self.active then return end
	love.graphics.setColor(200,50,50,150*(1-self.time)+100)
	love.graphics.setLineWidth(5)
	screen:circle(love.draw_line, self.x, self.y, 10*self.time)
end

function Beacon2:unload()
	self.destroyed=true
end
