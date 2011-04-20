Menu = {}
Menu.__index = Menu
Menu.music = love.audio.newSound("sounds/music/menu.aif")
Menu.background = love.graphics.newImage("images/menu/background.png")

function Menu.create()
	local menu = {}
	setmetatable(menu, Menu)
	menu.button = {
					new = Button.create_text("New Game", screen.width/2, screen.height/2),
					options = Button.create_text("Options", screen.width/2, screen.height/2+80),
					credits = Button.create_text("Credits", screen.width/2, screen.height/2+160),
					quit = Button.create_text("Quit", screen.width/2, screen.height/2+240) }

	return menu
end


function Menu:load()
	love.audio.play(Menu.music, 0)
	Menu.music:setVolume(.5)
end

function Menu:draw()
	love.graphics.draw(Menu.background, screen.width/2, screen.height/2, 0, 
		screen.width/Menu.background:getWidth(), 
		screen.height/Menu.background:getHeight())
	for n,b in pairs(self.button) do
		b:draw()
	end

end

function Menu:update(dt)
	for n,b in pairs(self.button) do
		b:update(dt)
	end
end

function Menu:mousepressed(x,y,button)
	
	for n,b in pairs(self.button) do
		if b:mousepressed(x,y,button) then
			if n == "new" then
				changestate(Prologue.create())
			elseif n == "options" then
				changestate(Options.create())
			elseif n == "credits" then
				changestate(Credits.create())
			elseif n == "quit" then
				love.system.exit()
			end
		end
	end
	
end

function Menu:keypressed(key)
end

function Menu:unload()
	Menu.music:setVolume(0)
end
