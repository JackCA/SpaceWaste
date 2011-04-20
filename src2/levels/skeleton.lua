Prologue = {}
Prologue.__index = Prologue
Prologue.font = love.graphics.newFont(love.default_font, 50)
Prologue.color = love.graphics.newColor(180,180,180)

function Prologue.create()
	local temp = {}
	setmetatable(temp, Prologue)
	return temp
end

function Prologue:draw()
end

function Prologue:update(dt)
end

function Prologue:mousepressed(x,y,button)
end

function Prologue:keypressed(key)
end

function Prologue:unload()
end

function Prologue:load()
end
