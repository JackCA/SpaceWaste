World = {}
World.__index = World

function World.create(callback)
	temp = {}
	setmetatable(temp, World)

	temp.world = love.physics.newWorld(0, 0, 10000,10000, 0, 0, false)
	temp.world:setGravity(0, 0)
	temp.world:setCallback(callback)

	objm:register(temp)

	return temp
end

function World:resize(width, height)
	if self.walls~=nil then
		self.walls.left_body:destroy()
		self.walls.top_body:destroy()
		self.walls.right_body:destroy()
		self.walls.bottom_body:destroy()

		self.walls.left_shape:destroy()
		self.walls.top_shape:destroy()
		self.walls.right_shape:destroy()
		self.walls.bottom_shape:destroy()
	end

	self.width = width
	self.height = height

	self.walls = {}

	self.walls.left_body = love.physics.newBody(self.world, 0, self.height/2, 0)
	self.walls.left_shape = love.physics.newRectangleShape(self.walls.left_body, 1, self.height)

	self.walls.right_body = love.physics.newBody(self.world, self.width, self.height/2, 0)
	self.walls.right_shape = love.physics.newRectangleShape(self.walls.right_body, 1, self.height)

	self.walls.top_body = love.physics.newBody(self.world, self.width/2, 0, 0)
	self.walls.top_shape = love.physics.newRectangleShape(self.walls.top_body, self.width, 1)

	self.walls.bottom_body = love.physics.newBody(self.world, self.width/2, self.height, 0)
	self.walls.bottom_shape = love.physics.newRectangleShape(self.walls.bottom_body, self.width, 1)

end

function World:update(dt)
	self.world:update(dt)
end

function World:edge()
	return 8000+math.random()*500,8000+math.random()*500
end

