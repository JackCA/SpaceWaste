Ship = {}
Ship.__index = Ship
Ship.image = love.graphics.newImage("images/unit/ship-1.png")
Ship.maxhp = 5
Ship.ship_debri = {love.graphics.newImage("images/unit/ship-1-piece1.png"),love.graphics.newImage("images/unit/ship-1-piece2.png"),love.graphics.newImage("images/unit/ship-1-piece3.png")}
Ship.alien_debri = {love.graphics.newImage("images/unit/alien-piece1.png"),love.graphics.newImage("images/unit/alien-piece2.png"),love.graphics.newImage("images/unit/alien-piece3.png")}

function Ship.create(tags, recycler)
	local ship = {light=1,radius=10, time=1, fire_left=true,tags=tags,recycler=recycler,hp=Ship.maxhp,destroyed=true,flag=1,timer=0,speed = 12,rate = 1}
	setmetatable(ship, Ship)
	local x,y = world:edge()
	ship.body, ship.shape = ship:makebody(x,y,ship.radius)
	objm:register(ship, ship.tags)
	return ship
end

function Ship:makebody(x,y,radius)
	local body = love.physics.newBody(world.world, x, y, 200)
	local shape = love.physics.newCircleShape(body, radius)
	shape:setData(self)
	return body,shape
end

function Ship:spawn(x,y)
	self.destroyed = false
	self.hp = Ship.maxhp
	if self.body:isFrozen() then
		self.body:destroy()
		self.shape:destroy()
		self.body, self.shape = self:makebody(x,y,self.radius)
	end
	self.body:setX(x)
	self.body:setY(y)
  self.body:setVelocity(0,0)
end
Ship.draw = {}

Ship.draw[4] = function(self)
	if self.destroyed then return end
	local x,y = self.body:getX(), self.body:getY()
	love.graphics.setColorMode(love.color_modulate)
	love.graphics.setColor(255*self.light, 255*self.light, 255*self.light, 255)
	screen:draw_scale(self.image, x, y, self.body:getAngle(), self.radius/150)
	love.graphics.setColorMode(love.color_normal)
end

function Ship:update(dt)

    self.timer = dt+self.timer
    if(self.timer>=self.speed) then
        self.flag = 2
        self.timer = 0
    elseif(self.timer >= self.speed/2) then
            self.flag = 3
    else
        self.flag = 0
    end
        
	if self.time<0 then
		self.time = self.rate
		self:fire()
		--local angle = get_degree(self.body:getX(), self.body:getY(), 325, 498)+90
		--local dist = get_distance(self.body:getX(), self.body:getY(), 325, 498)
	end
	self.time = self.time-dt
    if (self.flag == 2 and self.tags[1]=="alien" and self.body:getY()>300) then
			self.body:setVelocity(0,10)
    elseif(self.body:getY()<=300) then
        self.body:setVelocity(0,50)
    elseif(self.flag == 3 and self.tags[1]=="alien") then
			self.body:setVelocity(0,-10)
    elseif(self.flag == 2) then 
        self.body:setVelocity(0,5)
    elseif(self.flag == 3) then 
        self.body:setVelocity(0,-5)
    
    end
    
end

function Ship:fire()
	if self.destroyed then return end

	local target = nil
	local enemy = nil
	if self.tags[1]=="alien" then
		enemy = objm.tags["human"]
	else
		enemy = objm.tags["alien"]
	end

	if enemy==nil then enemy = {} end
	for t,_ in pairs(enemy) do
		if not t.destroyed then 
			local dist = get_distance(self.body:getX(), self.body:getY(), t.body:getX(), t.body:getY())
			if dist<1000 then target = t end
		end
	end

	if target~=nil and not target.destroyed then
		--self.body:setAngle(get_degree(self.body:getX(),self.body:getY(),target.body:getX(),target.body:getY())+90+math.random()*30-15)
        if(target.body:getX()<self.body:getX()) then
            self.body:setAngle(180)
        end
        --local deg = get_degree(self.body:getX(),self.body:getY(),target.body:getX(),target.body:getY())
        --[[if(deg>45 and self.tags[1]~="alien") then
            self.body:setVelocity(0,-30)
        elseif(deg<-45 and self.tags[1]~="alien") then
            self.body:setVelocity(0,30)
        end]]--
		local dx, dy = 0, 0
		if self.fire_left then 
			dy = -self.radius*sin(self.body:getAngle()+90)
			dx = -self.radius*cos(self.body:getAngle()+90)
		else
			dy = self.radius*sin(self.body:getAngle()+90)
			dx = self.radius*cos(self.body:getAngle()+90)
		end

		local x = self.body:getX()+self.radius*cos(self.body:getAngle())+dx
		local y = self.body:getY()+self.radius*sin(self.body:getAngle())+dy

		--laser = Laser.create(x,y,self.body:getAngle())
		if not self.destroyed then
			local laser = laserrecycler:spawn(x,y,self.body:getAngle())
			if laser==nil then print("need more laser") end
			self.fire_left = not self.fire_left
		end
	end
end

function Ship:unload()
	self.destroyed = true
	local x,y = world:edge()
	self.body:setX(x)
	self.body:setY(y)
	self.recycler:destroy(self)
end

function Ship:collision(obj, contact)
	if self.destroyed then return end
	if obj~=nil and obj.__index==Laser then
		self.hp = self.hp-1
		if self.hp<=0 then
			local x,y = self.body:getX(), self.body:getY()
			self:unload()
			for i=1,3 do
				--[[
				local trash = Trash.create(self.body:getX()+(math.random()-.5)*self.radius,
					self.body:getY()+(math.random()-.5)*self.radius, math.random()+1.5,
					love.graphics.newImage("images/trash/paper-1.png"), 50)
				trash.body:setVelocity((math.random()-.5)*100,(math.random()-.5)*100)
				--]]
				local debri = debrirecycler:spawn(x+(math.random()-.5)*self.radius,y+(math.random()-.5)*self.radius)
				if debri~=nil then 
					debri.body:setVelocity((math.random()-.5)*200,(math.random()-.5)*200)
					if self.tags[1]=="human" then
						debri.image = Ship.ship_debri[i]
					else
						debri.image = Ship.alien_debri[i]
					end
					debri.image_size = 80
				else print("need more debri!") end
			end

		end
	end
end
