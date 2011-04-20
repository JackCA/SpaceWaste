Sound = {}
Sound.__index = Sound
--Sound.explosion = love.audio.newSound("sounds/explosion_2.wav")

function Sound.create()
	local sound = {time={}}
	setmetatable(sound, Sound)
	return sound
end

function Sound:play(sound)
	if not self.time[sound] or self.time[sound]<0 then
		love.audio.play(sound,1)
		self.time[sound] = math.random()+.5
	end
end

function Sound:update(dt)
	for s,t in pairs(self.time) do
		self.time[s] = t-dt
	end
end
