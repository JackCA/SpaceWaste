GGun = {}
GGun.__index = GGun
GGun.image = love.graphics.newImage("images/player/gravity-gun.png")
GGun.icon = love.graphics.newImage("images/player/gravity-gun-bw.png")
GGun.backpack1 = love.graphics.newImage("images/player/backpack1.png")
GGun.backpack2 = love.graphics.newImage("images/player/backpack2.png")
GGun.dist = 80
GGun.width = 3
GGun.name = "gravity gun"
GGun.pickup = love.audio.newSound("sounds/ggun_pickup.wav")
GGun.release = love.audio.newSound("sounds/ggun_release2.wav")
GGun.vacuum_start = love.audio.newSound("sounds/ggun_vacuum_start.wav")
GGun.vacuum_loop = love.audio.newSound("sounds/ggun_vacuum_loop.wav")
love.audio.play(GGun.vacuum_loop, 0)
GGun.vacuum_loop:setVolume(0)

function GGun.create()
	temp = {angle=0, length=5, bag={}, bag_size=0, mode="idle", dx=0, dy=0, light=1, targets={}}
	temp.body = love.physics.newBody(world.world, player.body:getX()+temp.length*cos(temp.angle), player.body:getY()+temp.length*sin(temp.angle)+2)
	temp.shape = love.physics.newCircleShape(temp.body, 2)

	setmetatable(temp, GGun)
	temp.vacuum_loop:setVolume(0)


	objm:register(temp)

	return temp
end

GGun.draw = {}
GGun.draw[5] = function(self)
	love.graphics.setColorMode(love.color_modulate)
	love.graphics.setColor(love.graphics.newColor(255*self.light,255*self.light,
		255*self.light, 255))

	local bpsize = math.log(self.bag_size+1)/25+.1
	if math.abs(self.angle)<90 then
		screen:draw_scale(self.backpack1, 
			player.body:getX()-self.length*cos(player.body:getAngle()), 
			player.body:getY()-self.length*sin(player.body:getAngle()), 
			player.body:getAngle()-90, bpsize)
	else
		screen:draw_scale(self.backpack2, 
			player.body:getX()+self.length*cos(player.body:getAngle()), 
			player.body:getY()+self.length*sin(player.body:getAngle()), 
			player.body:getAngle()-90, bpsize)
	end

	if self.mode=="pull" then

		love.graphics.setColorMode(love.color_modulate)
		love.graphics.setBlendMode(love.blend_additive)
		love.graphics.setColor(love.graphics.newColor(255, 100, 0, 50))

		local w,d = self.width, self.dist
		local s,c = -sin(self.angle-90), -cos(self.angle-90)
		local x,y = player.body:getX(), player.body:getY()+2
		screen:quad(love.draw_fill,
			x+w*c, y+w*s,
			x+w*c+d*s, y+w*s-d*c,
			x-w*c+d*s, y-w*s-d*c,
			x-w*c, y-w*s)
		love.graphics.setColorMode(love.color_normal)
		love.graphics.setBlendMode(love.blend_normal)
	end

	love.graphics.setColorMode(love.color_normal)
end

GGun.draw[6] = function(self)
	love.graphics.setColorMode(love.color_modulate)
	love.graphics.setColor(255*self.light,255*self.light,255*self.light, 255)

	local scale = 3.5/28
	screen:draw_scale(self.image, player.body:getX()+self.length*cos(self.angle)+self.dx, player.body:getY()+self.length*sin(self.angle)+2+self.dy, self.angle-90, scale)
	--screen:circle(love.draw_fill, temp.body:getX(), temp.body:getY(), 2)

	love.graphics.setColorMode(love.color_normal)
end

function GGun:pulling()
	if self.mode=="pull" then
		self.dx, self.dy = math.random(-1,1)/5, math.random(-1,1)/5
		Event.create(function() self:pulling() end, math.random(1,10)/10)
	end
end

function GGun:update(dt)
	if player.freeze then return end

	self.angle = player:getAngle(love.mouse.getX(), love.mouse.getY())
	self.body:setX(player.body:getX()+self.length*cos(self.angle)*2)
	self.body:setY(player.body:getY()+self.length*sin(self.angle)*2+2)

	if love.mouse.isDown(love.mouse_right) then
		if self.mode=="idle" then
			self.vacuum_start:setVolume(1)
			love.audio.play(self.vacuum_start)
			Event.create(function() if self.mode=="pull" then self.vacuum_loop:setVolume(1)	end end, 1)
		end
		self.mode="pull"
		self.dx, self.dy = math.random(-1,1)/5, math.random(-1,1)/5
		for obj,_ in pairs(objm.tags["trash"]) do
			if not obj.destroyed then	self:force(obj) end
		end
	else
		if self.mode=="pull" then
			self.vacuum_start:setVolume(0)
			self.vacuum_loop:setVolume(0)
		end
		self.mode="idle"
		self.dx, self.dy = 0, 0
		for trash, joint in pairs(self.targets) do
			joint:destroy()
			self.targets[trash] = nil
		end
	end

	--[[
	self.light = 1
	for _,planet in ipairs(planets) do
		self.light = self.light * planet:getLight(self.body:getX(), self.body:getY())
	end
	--]]

	
	if love.keyboard.isDown(love.key_lshift) then
		local last_trash, last_joint
		for trash, joint in pairs(self.bag) do
			last_trash, last_joint = trash, joint
        end
        if last_trash~=nil then
            print("there are "..self.bag_size)
            self.bag[last_trash] = nil
            local x = player.body:getX()+self.length*cos(self.angle)*2.5
            local y = player.body:getY()+self.length*sin(self.angle)*2.5+2
            last_trash:spawn(x,y)
            last_joint = love.physics.newDistanceJoint(player.body, last_trash.body, player.body:getX(),  player.body:getY(), x, y)
            last_joint:setLength(30)
            --self.dx, self.dy = math.random(-1,1), math.random(-1,1)
            --Event.create(function() self.dx,self.dy=0,0 end, .05)
            --love.audio.play(self.release)
        end
    else
        for trash, joint in pairs(self.bag) do
			last_trash, last_joint = trash, joint
        end
 
        if (last_trash~=nil) then
            print("here")
            --self.bag[last_trash] = nil
            --local x = player.body:getX()+self.length*cos(self.angle)*2.5
            --local y = player.body:getY()+self.length*sin(self.angle)*2.5+2
            last_trash:unload()
            --self.dx, self.dy = math.random(-1,1), math.random(-1,1)
            --Event.create(function() self.dx,self.dy=0,0 end, .05)
            --love.audio.play(self.release)
        end
	end
	
	--[[
	local s,c = -sin(self.angle), -cos(self.angle)
	if self.sunction ~= nil then
		self.sunction.prismj:destroy()
		self.sunction.prismj = love.physics.newPrismaticJoint(self.body, self.sunction.target.body, 
					self.body:getX(), self.body:getY(), 1, 0)
	end
	--]]
end

function GGun:force(trash)
	local w,d = self.width, self.dist
	local s,c = -sin(self.angle-90), -cos(self.angle-90)
	local xg,yg = self.body:getX(), self.body:getY()
	local xt,yt = trash.body:getX(), trash.body:getY()
	if trash.shape:testSegment(xg,yg,xg+d*s,yg-d*c) then
		if self.bag[trash] == nil then
			local dist = get_distance(xg,yg,xt,yt)
			if dist<10 then
				self.bag[trash] = true
				self.bag_size = self.bag_size + 1
				player:incrementMass(trash.body:getMass())
				trash:unload()
				self.dx, self.dy = math.random(-1,1), math.random(-1,1)
				Event.create(function() self.dx,self.dy=0,0 end, .05)
				love.audio.play(self.pickup)
			else
				if self.targets[trash]==nil then
					self.targets[trash] = love.physics.newDistanceJoint(self.body, trash.body, xg, yg, xt, yt)
					self.targets[trash]:setFrequency(.3)
				end
			end
		end
	elseif self.targets[trash]~=nil then
		local joint = self.targets[trash]
		joint:destroy()
		self.targets[trash] = nil
	end
end

function GGun:mousepressed(x,y,key)
	if player.freeze then return end

	if key==love.mouse_left then
		local last_trash, last_joint
		for trash, joint in pairs(self.bag) do
			last_trash, last_joint = trash, joint
		end
		if last_trash~=nil then
			self.bag[last_trash] = nil
			local x = player.body:getX()+self.length*cos(self.angle)*2.5
			local y = player.body:getY()+self.length*sin(self.angle)*2.5+2
			last_trash:spawn(x,y)
			last_trash.fire = 10

			local force = 20000
			local deg = player.body:getAngle()
			last_trash.body:applyImpulse(-sin(self.angle-90)*force,cos(self.angle-90)*force)
			self.bag_size = self.bag_size-1 -- just use len(self.collected) if we figure out how
			if self.bag_size < 0 then self.bag_size = 0 end
			self.dx, self.dy = math.random(-1,1), math.random(-1,1)
			Event.create(function() self.dx,self.dy=0,0 end, .05)
			love.audio.play(self.release)
		end
	end
end

function GGun:unload()
	self.vacuum_loop:setVolume(0)
end
