Credits = {}
Credits.__index = Credits
Credits.image = love.graphics.newImage("images/credits.jpg")

function Credits.create()
	local temp = {button={back = Button.create_text("Back", screen.width/2-300, screen.height/2+250)}}
	setmetatable(temp, Credits)
	return temp
end

function Credits:load()

	objm = ObjManager.create()

	objm:register(screen)
	objm:register(sound)

	world = World.create(function(a,b,c) end)
	world:resize(100,100)

	player = Player.create(10,10)
	player.hp = 10
	screen.tracking = player

	Trash.create(50,50,5,player.dead,28)
	Trash.create(50,70,5,love.graphics.newImage("images/trash/bottle.png"),50)
	Trash.create(50,80,5,love.graphics.newImage("images/trash/bananapeel.png"),50)
	Trash.create(60,60,5,love.graphics.newImage("images/trash/toilet.png"),50)

	ggun = GGun.create()
end

function Credits:draw()
	love.graphics.setColor(0,0,0,0)
	love.graphics.rectangle(love.draw_fill, 0, 0, screen.width, screen.height)
	love.graphics.draw(self.image, screen.width/2, screen.height/2)
	objm:draw()
	for n,b in pairs(self.button) do
		b:draw()
	end
end

function Credits:update(dt)
	objm:update(dt)
	for n,b in pairs(self.button) do
		b:update(dt)
	end
end

function Credits:mousepressed(x,y,button)
	objm:mousepressed(x,y,button)
	for n,b in pairs(self.button) do
		if b:mousepressed(x,y,button) then
			if n=="back" then changestate(Menu.create()) end
		end
	end
end

function Credits:keypressed(key)
	if key==love.key_escape then
		changestate(Menu.create())
	else
		objm:keypressed(key)
	end
end

function Credits:unload()
	objm:unload()
end

