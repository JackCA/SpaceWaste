Dialog = {}
Dialog.__index = Dialog
Dialog.font = love.graphics.newFont(love.default_font, 20)
Dialog.face = {}
Dialog.face["Calder"] = love.graphics.newImage("images/face/calder.png")
Dialog.face["Pirate"] = love.graphics.newImage("images/face/pirate.png")
Dialog.face["Milo"] = love.graphics.newImage("images/face/milo.png")

function Dialog.create(dialog, focus)
	temp = {dialog=dialog, focus=focus, stage=1, continue=false}
	setmetatable(temp, Dialog)

	if focus~=nil then 
		temp.continue = true 
		screen:track(focus)
		screen.zoomold = screen.scale
		screen.zoomtarget = 2
		player.freeze = true
	end

	objm:register(temp)

	return temp
end

Dialog.draw = {}

Dialog.draw[9] = function(self)
	love.graphics.setColor(0,0,0)
	love.graphics.rectangle(love.draw_fill, 0, 0, screen.width, 170)
	love.graphics.setColor(255,255,255)
	love.graphics.setFont(self.font)
	love.graphics.drawf(self.dialog[self.stage][1]..": "..self.dialog[self.stage][2], 170, 10+self.font:getHeight(), screen.width-180)
	love.graphics.draw(self.face[self.dialog[self.stage][1]], 85, 85)
end

function Dialog:unload()
	screen.tracking = player
	screen.mode = "focused"
	self.destroyed = true
	player.freeze = false
end

function Dialog:mousepressed(x,y,button)
end

function Dialog:keypressed(key)
	if key==love.key_space then
		self.stage = self.stage+1
		if self.dialog[self.stage]==nil then 
			if self.focus~=nil then
				self.stage = self.stage-1
			else
				self:unload()
			end
			if self.trigger then self.trigger() end
		end
	end
	if key==love.key_return then
		self:unload()
		if self.trigger then self.trigger() end
	end
end
