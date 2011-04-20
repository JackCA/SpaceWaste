
function load()
	love.filesystem.require("button.lua")
	love.filesystem.require("objmanager.lua")
	love.filesystem.require("screen.lua")
	love.filesystem.require("menu.lua")
	love.filesystem.require("options.lua")
	love.filesystem.require("world.lua")
	love.filesystem.require("player.lua")
	love.filesystem.require("message.lua")
	love.filesystem.require("event.lua")
	love.filesystem.require("trash.lua")
	love.filesystem.require("ggun.lua")
	love.filesystem.require("ship.lua")
	love.filesystem.require("laser.lua")
	love.filesystem.require("logo.lua")
	love.filesystem.require("grid.lua")
	love.filesystem.require("star.lua")
	love.filesystem.require("planet.lua")
	love.filesystem.require("pirate.lua")
	love.filesystem.require("mothership.lua")
	love.filesystem.require("beacon.lua")
	love.filesystem.require("beacon2.lua")
	love.filesystem.require("dialog.lua")
	love.filesystem.require("levels/01prologue.lua")
	love.filesystem.require("levels/02level1.lua")
	love.filesystem.require("objrecycle.lua")
	love.filesystem.require("debri.lua")
	love.filesystem.require("explosion.lua")
	love.filesystem.require("sound.lua")
	love.filesystem.require("credits.lua")

	love.audio.setChannels(128)
	screen = Screen.create()
	sound = Sound.create()
	screen.fullscreen = false

	state = Menu.create()
	state:load()

	--drum1 =love.audio.newSound("sounds/music/level1/drum1.ogg")
	--drum2 =love.audio.newSound("sounds/music/level1/drum2.ogg")
	--love.audio.play(drum1,0)
	--love.audio.play(drum2,0)
end

function draw()
	state:draw()
end

function update(dt)
	state:update(dt)
end

function mousepressed(x, y, button)
	state:mousepressed(x,y,button)
end

function keypressed(key)
	state:keypressed(key)
end

function changestate(newstate)
	state:unload()

	state = newstate
	state:load()
end

function sin(deg)
	return math.sin(deg/180*math.pi)
end

function cos(deg)
	return math.cos(deg/180*math.pi)
end

function get_degree(x1,y1,x2,y2)
	local dx = x1-x2
	local dy = y1-y2
	return math.atan2(dy,dx)/math.pi*180+90
end

function get_distance(x1,y1,x2,y2)
	local dx = x1-x2
	local dy = y1-y2
	return math.sqrt(dx*dx+dy*dy)
end

function clr(r, g, b, a) return love.graphics.newColor(r, g, b, a) end

