Planet = {}
Planet.__index = Planet

function Planet.create(x, y, size, ring,b)
	local planet = {size = size or 230*.6, ringrad = size or 150, ring=ring or false, bool=b or false}
	setmetatable(planet, Planet)
	planet.x = x
	planet.y = y
	planet.rot = math.random(0, 100)
	planet.depth = math.random(2, 100)
	planet.image = love.graphics.newImage("images/background/sun.png")
	planet.ring_image_front = love.graphics.newImage("images/background/rings_front.png")
	planet.ring_image_back = love.graphics.newImage("images/background/rings_back.png")
	objm:register(planet)
  if(planet.bool == true) then
    planet.body = love.physics.newBody(world.world, planet.x, planet.y, 0)
    planet.shape = love.physics.newCircleShape(planet.body,planet.size/.7)
    planet.shape:setData(self)
    planet.body:setMassFromShapes()
    planet.image = love.graphics.newImage("images/background/dstar.png")
		planet.rot = 0
  end          
	return planet
end

function Planet:update(dt)
        if( self.bool ~= true) then
	    for trash,_ in pairs(objm.tags["trash"]) do
		    if not trash.destroyed then
			    local dist = get_distance(self.x, self.y, trash.body:getX(), trash.body:getY())
			    if dist<self.ringrad*1.7 then
				    local deg = get_degree(self.x, self.y, trash.body:getX(), trash.body:getY())
				    local force = math.min((dist-self.ringrad)*(dist-self.ringrad),1.5)
				    if dist<self.ringrad then force = -force end
				    local force2 = math.random(-1,1)
				    trash.body:applyImpulse(force2*cos(deg),force2*sin(deg)) --tangential
				    trash.body:applyImpulse(force*sin(deg),-force*cos(deg)) 
			    end
		    end
	    end
        end
end

Planet.draw = {}

Planet.draw[2] = function(self)
	if self.ring then screen:draw_scale(self.ring_image_back, self.x, self.y, self.rot, self.size/230/.6) end
end

Planet.draw[3] = function(self)
	love.graphics.setColorMode(love.color_modulate)
	love.graphics.setColor(200,200,200,255)
	screen:draw_scale(self.image, self.x, self.y, self.rot, self.size/230)
	love.graphics.setColorMode(love.color_normal)
end


Planet.draw[7] = function(self)
	if self.ring then screen:draw_scale(self.ring_image_front, self.x, self.y, self.rot, self.size/230/.6) end
end

function Planet:getLight(x,y)
	local dist = get_distance(self.x, self.y, x,y)
	local dx, dy = x-self.x, y-self.y
	local v = dx*cos(self.rot+45)+dy*sin(self.rot+45)
	local u = dx*cos(self.rot-45)+dy*sin(self.rot-45)
	if u > -100 and dist<self.size then
		local ret = (self.size-u-100)/self.size
		if ret<.2 then ret=.2 end
		return ret
	end
	return 1
end

