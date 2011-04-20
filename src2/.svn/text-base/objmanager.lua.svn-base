ObjManager = {}
ObjManager.__index = ObjManager

function ObjManager:create()
	local self = {}
	setmetatable(self, ObjManager)
	self.objs = {}
	self.tags = {}
	return self
end

function ObjManager:draw()
	for order=1,9 do
		for obj,_ in pairs(self.objs) do
			if obj.draw~=nil and obj.draw[order]~=nil and not obj.destroyed then
				obj.draw[order](obj)
			end
		end
	end
end

function ObjManager:update(dt)
	for obj,_ in pairs(self.objs) do
		if obj.update~=nil and not obj.destroyed then
			obj:update(dt)
		end
		--[[
		if obj.destroyed then
			self.objs[obj] = nil
			for tag,list in pairs(self.tags) do
				list[obj] = nil
			end
		end
		--]]
	end
end

function ObjManager:keypressed(key)
	for obj,_ in pairs(self.objs) do
		if obj.keypressed~=nil and not obj.destroyed then
			obj:keypressed(key)
		end
	end
end

function ObjManager:mousepressed(x, y, button)
	for obj,_ in pairs(self.objs) do
		if obj.mousepressed~=nil and not obj.destroyed then
			obj:mousepressed(x,y,button)
		end
	end
end

function ObjManager:unload()
	for obj,_ in pairs(self.objs) do
		if obj.unload ~= nil and not obj.destroyed then
			obj:unload()
		end
		self.objs[obj] = nil
		for tag,list in pairs(self.tags) do
			list[obj] = nil
		end
	end
end

function ObjManager:register(obj, ...)
	self.objs[obj] = true

	for _,a in ipairs(arg) do
		if self.tags[a]==nil then self.tags[a] = {} end
		self.tags[a][obj] = true
	end

	if obj.tags~=nil then
		for _,a in ipairs(obj.tags) do
			if self.tags[a]==nil then self.tags[a] = {} end
			self.tags[a][obj] = true
		end
	end
end
