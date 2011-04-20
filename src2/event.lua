Event = {}
Event.__index = Event

function Event.create(f,t)
	temp = {f=f, t=t}
	setmetatable(temp, Event)
	objm:register(temp)
	return temp
end

function Event:update(dt)
	self.t = self.t-dt
	if self.t<0 and not self.destroyed then
		self.f()
		self.destroyed = true
	end
end
