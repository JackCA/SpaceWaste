Prologue = {}
Prologue.__index = Prologue
Prologue.images = {love.graphics.newImage("images/intro/intro1.jpg"),love.graphics.newImage("images/intro/intro2.jpg"),love.graphics.newImage("images/intro/intro3.jpg"),love.graphics.newImage("images/intro/intro4.jpg"),love.graphics.newImage("images/intro/intro5.jpg"),love.graphics.newImage("images/intro/intro6.jpg")}

function Prologue.create()
	local temp = {index=1}
	setmetatable(temp, Prologue)
	return temp
end

function Prologue:draw()
	love.graphics.draw(self.images[self.index], screen.width/2, screen.height/2)
end

function Prologue:update(dt)
end

function Prologue:mousepressed(x,y,button)
	self.index = self.index + 1
	if self.images[self.index]==nil then
		self.index = self.index - 1
		changestate(Level1.create())
	end
end

function Prologue:keypressed(key)
	if key==love.key_escape then
		changestate(Level1.create())
	end
end

function Prologue:unload()
end

function Prologue:load()
end
