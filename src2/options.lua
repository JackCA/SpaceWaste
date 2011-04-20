Options = {}
Options.__index = Options
Options.background = love.graphics.newImage("images/menu/background.png")
Options.font = love.graphics.newFont("fonts/freshbot.ttf", 50)
Options.color = love.graphics.newColor(180,180,180)

function Options.create()
	local temp = {button={
		on = Button.create_text("On", screen.width/2-50, screen.height/2+205),
		off = Button.create_text("Off", screen.width/2+50, screen.height/2+205),
		back = Button.create_text("Back", screen.width/2+300, screen.height/2+250)}}
	setmetatable(temp, Options)
	local modes = {{width=800,height=600}, {width=1024,height=768}, {width=1280,height=800}, {width=1440,height=900}}
	for i, mode in ipairs(modes) do
		temp.button[mode] = Button.create_text(string.format("%dx%d", mode.width, mode.height), screen.width/2, screen.height/2-50+i*35)
	end
	return temp
end

function Options:draw_center(text, x, y)
	local width = self.font:getWidth(text)
	love.graphics.draw(text, x-width/2, y)
end

function Options:draw()
	love.graphics.draw(self.background, screen.width/2, screen.height/2, 0, 
		screen.width/self.background:getWidth(), 
		screen.height/self.background:getHeight())

	love.graphics.setColor(self.color)
	love.graphics.setFont(self.font)
	self:draw_center("Resolution:", screen.width/2, screen.height/2-50)
	self:draw_center("Full Screen:", screen.width/2, screen.height/2+170)	
	for n,b in pairs(self.button) do
		b:draw()
	end

end

function Options:update(dt)
	
	for n,b in pairs(self.button) do
		b:update(dt)
	end
	
end

function Options:mousepressed(x,y,button)
	
	for n,b in pairs(self.button) do
		if b:mousepressed(x,y,button) then
			if n=="on" then
				if love.graphics.checkMode(screen.width, screen.height, true) then
					love.graphics.setMode(screen.width, screen.height, true, true, 0)
					screen = Screen.create()
					screen.fullscreen = true
					changestate(Options.create())
				end
			elseif n=="off" then
				if love.graphics.checkMode(screen.width, screen.height, false) then
					love.graphics.setMode(screen.width, screen.height, false, true, 0)
					screen = Screen.create()
					screen.fullscreen = false
					changestate(Options.create())
				end
			elseif n=="back" then
				changestate(Menu.create())
			else
				local fullscreen = screen.fullscreen
				if love.graphics.checkMode(n.width, n.height, fullscreen) then
					love.graphics.setMode(n.width, n.height, fullscreen, true, 0)
					screen = Screen.create()
					screen.fullscreen = fullscreen
					changestate(Options.create())
				end
			end
		end
	end	
end

function Options:keypressed(key)
	if key == love.key_escape then
		changestate(Menu.create())
	end
end

function Options:unload()
	Menu.music:setVolume(0)
end

function Options:load()
	Menu.music:setVolume(.5) -- options use menu music object to give seamless transition from menu to option and back
end
