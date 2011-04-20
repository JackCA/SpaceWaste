Message = {}
Message.__index = Message

function Message.create(text,x,y,font,color)
	temp = {text=text,x=x,y=y,font=font,color={color:getRed(),color:getGreen(),color:getBlue()},time=0}
	setmetatable(temp, Message)
	objm:register(temp)
	return temp
end

function Message:update(dt)
	self.time = self.time + dt
	if self.time>16 then self.destroyed = true end
end

Message.draw = {}

Message.draw[5] = function(self)
	local h = self.font:getHeight()+20
	local w = self.font:getWidth(self.text)+20
	local t = self.time
	if t>2 then
		if t>8 then
			t = t-6
		else
			t = 2
		end
	end
	local alpha = t*math.exp(-.5*t)/.735*255
	love.graphics.setColor(60,60,60,alpha/2)
	love.graphics.rectangle(love.draw_fill, self.x-10, self.y-h/2-10,w,h)
	self.color[4] = alpha
	love.graphics.setColor(unpack(self.color))
	love.graphics.setFont(self.font)
	love.graphics.draw(self.text, self.x, self.y)
end

