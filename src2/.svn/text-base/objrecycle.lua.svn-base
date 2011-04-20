ObjRecycle = {}
ObjRecycle.__index = ObjRecycle

function ObjRecycle.create()
	local self = {}
	setmetatable(self, ObjRecycle)
	self.unused = {}
	self.N = 0
	return self
end

function ObjRecycle:add(obj)
	table.insert(self.unused,obj)
	self.N = self.N + 1
end

function ObjRecycle:spawn(...)
	local o = nil
	if self.N>1 then
		self.N = self.N-1
		o = table.remove(self.unused,1)
		o:spawn(unpack(arg))
	end
	return o
end

function ObjRecycle:destroy(obj)
	table.insert(self.unused,obj)
	self.N = self.N + 1
end
