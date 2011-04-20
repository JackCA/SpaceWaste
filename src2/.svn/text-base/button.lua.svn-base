Button = {}
Button.__index = Button
Button.font = love.graphics.newFont("fonts/freshbot.ttf", 45)
Button.color = love.graphics.newColor(180,180,180)
Button.hover = love.graphics.newColor(63,193,245)
Button.click = love.audio.newSound("sounds/click.ogg")

function Button.create_text(text,x,y)
	local temp = {}
	setmetatable(temp, Button)
	temp.hover = false -- whether the mouse is hovering over the button
	temp.text = text -- the text in the button
	temp.width = Button.font:getWidth(text)
	temp.height = Button.font:getHeight()
	temp.x = x - (temp.width / 2)
	temp.y = y
	return temp
end

function Button.create_image(image,hover_image,x,y)
	local temp = {}
	setmetatable(temp, Button)
	temp.hover = false -- whether the mouse is hovering over the button
	temp.image = image
	temp.hover_image = hover_image
	temp.width = image:getWidth()
	temp.height = image:getHeight()
	temp.x = x
	temp.y = y
	return temp
end


function Button:draw()
	if self.image~=nil then
		if self.hover then love.graphics.draw(self.hover_image, self.x, self.y)
		else love.graphics.draw(self.image, self.x, self.y) end
	else
		love.graphics.setFont(Button.font)
		if self.hover then love.graphics.setColor(Button.hover)
		else love.graphics.setColor(Button.color) end
		love.graphics.draw(self.text, self.x, self.y)
	end
end

function Button:update(dt)
	
	self.hover = false
	
	local x = love.mouse.getX()
	local y = love.mouse.getY()
	
	if self.image~=nil then
		if x > self.x - self.width/2
			and x < self.x + self.width/2
			and y > self.y - self.height/2
			and y < self.y + self.height/2 then
			self.hover = true
		end
	else
		if x > self.x
			and x < self.x + self.width
			and y > self.y - self.height
			and y < self.y then
			self.hover = true
		end
	end
end

function Button:mousepressed(x, y, button)
	
	if self.hover then
		love.audio.play(Button.click)
		return true
	end
	
	return false
	
end
