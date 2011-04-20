Screen = {}
Screen.__index = Screen

function Screen.create()
	temp = {}
	setmetatable(temp, Screen)
	temp.width = love.graphics.getWidth()
	temp.height = love.graphics.getHeight()
	temp.x = 0
	temp.y = 0
	temp.scale = 3
	temp.tracking = false
	temp.mode = "focused"
	temp.dx = 0
	temp.dy = 0
	temp.shake = 0

	return temp
end

function Screen:update(dt)
	if love.keyboard.isDown(love.key_left) then
		self.x = self.x - 200*dt
	end
	if love.keyboard.isDown(love.key_right) then
		self.x = self.x + 200*dt
	end
	if love.keyboard.isDown(love.key_up) then
		self.y = self.y - 200*dt
	end
	if love.keyboard.isDown(love.key_down) then
		self.y = self.y + 200*dt
	end

	if love.keyboard.isDown(love.key_pageup) then
		self.scale = self.scale*1.01
	end
	if love.keyboard.isDown(love.key_pagedown) then
		self.scale = self.scale/1.01
	end

	if player~=nil and self.tracking==player or self.mode=="relaxed" then
		if screen:tx(self.tracking.body:getX())<self.width/4 then
			self.x = self.tracking.body:getX()*self.scale-self.width/4
		end
		if screen:tx(self.tracking.body:getX())>self.width*3/4 then
			self.x = self.tracking.body:getX()*self.scale-self.width*3/4
		end
		if screen:ty(self.tracking.body:getY())<self.height/4 then
			self.y = self.tracking.body:getY()*self.scale-self.height/4
		end
		if screen:ty(self.tracking.body:getY())>self.height*3/4 then
			self.y = self.tracking.body:getY()*self.scale-self.height*3/4
		end
	elseif self.tracking~=nil then
		self.x = self.tracking.body:getX()*self.scale-self.width/2
		self.y = self.tracking.body:getY()*self.scale-self.height/2
	end

	self.dx = math.random(-self.shake, self.shake)
	self.dy = math.random(-self.shake, self.shake)

	if self.mode=="transition" then
		if self.time>2 then
			self.mode = "focused"
			self.tracking = self.next_obj
			self.x = self.tracking.body:getX()*self.scale-self.width/2
			self.y = self.tracking.body:getY()*self.scale-self.height/2
		else
			self.x = self.time/2*(self.next_obj.body:getX()*self.scale-self.width/2)+(1-self.time/2)*self.oldx
			self.y = self.time/2*(self.next_obj.body:getY()*self.scale-self.height/2)+(1-self.time/2)*self.oldy
			self.scale = self.zoomold+(self.zoomtarget-self.zoomold)*self.time/2
			self.time = self.time+dt
		end
	end
end

function Screen:tx(x)
	return x*self.scale-self.x-self.dx
end

function Screen:ty(y)
	return y*self.scale-self.y-self.dy
end

function Screen:line(x1, y1, x2, y2)
	love.graphics.line(self:tx(x1), self:ty(y1), self:tx(x2), self:ty(y2))
end

function Screen:draw_scale(sprite, x, y, angle, s)
	love.graphics.draw(sprite, self:tx(x), self:ty(y), angle, s*self.scale)
end

function Screen:tx_far(x, f)
	return x*self.scale-f*(self.x-self.dx)
end

function Screen:ty_far(y, f)
	return y*self.scale-f*(self.y-self.dy)
end

function Screen:draw_far(sprite, x, y, angle, s, f)
	love.graphics.draw(sprite, self:tx_far(x,f), self:ty_far(y,f), angle, s*self.scale)
end

function Screen:rectangle(type, x1, y1, w, h )
	love.graphics.rectangle(type, self:tx(x1), self:ty(y1), w*self.scale, h*self.scale)
end

function Screen:circle(type, x1, y1, r)
	love.graphics.circle(type, self:tx(x1), self:ty(y1), r*self.scale, 20)
end

function Screen:triangle(type, x1, y1, x2, y2, x3, y3)
	love.graphics.triangle(type, self:tx(x1), self:ty(y1), self:tx(x2), self:ty(y2), self:tx(x3), self:ty(y3))
end

function Screen:quad( type, x1, y1, x2, y2, x3, y3, x4, y4 )
	love.graphics.quad(type, self:tx(x1), self:ty(y1), self:tx(x2), self:ty(y2), self:tx(x3), self:ty(y3), self:tx(x4), self:ty(y4))
end


function Screen:polygon(type, ...)
	for i,v in ipairs(arg) do
		if math.mod(i,2)==1 then
			arg[i] = self:tx(v)
		else
			arg[i] = self:ty(v)
		end
	end
	love.graphics.polygon(type, unpack(arg))
end

function Screen:track(obj)
	self.oldx = self.x
	self.oldy = self.y
	self.time = 0
	self.mode = "transition"
	self.next_obj = obj
end
