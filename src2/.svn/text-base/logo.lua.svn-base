Logo = {}
Logo.__index = Logo
Logo.background = love.graphics.newImage("images/logo.png")
Logo.music = love.audio.newSound("sounds/music/opening.wav")

function Logo.create()
	local menu = {time=0,light=0}
	setmetatable(menu, Logo)
	return menu
end


function Logo:load()
	self.music:setVolume(1)
	love.audio.play(self.music,1)
end

function Logo:draw()
	love.graphics.setColorMode(love.color_modulate)
	love.graphics.setColor(255,255,255,self.light*255)
	love.graphics.draw(Logo.background, screen.width/2, screen.height/2, 0, 
		screen.width/Logo.background:getWidth(), 
		screen.height/Logo.background:getHeight())
	love.graphics.setColorMode(love.color_normal)

end

function Logo:update(dt)
	self.time = self.time+dt
	if self.time>8 then
		changestate(Menu.create())
	end
	self.light = self.time/2
	if self.time>2 then self.light = 1 end
	if self.time>6 then self.light = (6-self.time)/2 end

end

function Logo:mousepressed(x,y,button)
	
end

function Logo:keypressed(key)
end

function Logo:unload()
	self.music:setVolume(0)
end
