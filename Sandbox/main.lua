time_elapsed = 0
time_prev = 0


function load()
	love.graphics.setFont(love.graphics.newFont(love.default_font, 12))
	text = ""
	vacuum_start = love.audio.newSound("sounds/ggun_vacuum_start.wav")
	vacuum_loop = love.audio.newSound("sounds/ggun_vacuum_loop.wav")
end

function update( dt )
	mouse_x = love.mouse.getX()
	mouse_y = love.mouse.getY()
	if love.keyboard.isDown( love.key_space ) then
		if time_elapsed == 0 then
			love.audio.play(vacuum_start)
		end
		text = "SPACE is being pressed!"
		sound_play(dt)
	else
		time_elapsed =0
	end
	if love.mouse.isDown(love.mouse_right) then
		text = "Mouse button right is pressed"

	end
end

function keypressed( key)
	if key == love.key_return then
		text = "RETURN is being pressed!"
	end
end

function sound_play(dt)
	time_elapsed=dt+time_elapsed
	time_prev = time_prev +dt
	--text = time_elapsed
	if time_elapsed>.29 then
		text = time_prev
		if time_prev>.35 then
			time_prev = 0
			love.audio.play(vacuum_loop)
		end

	end
end



function keyreleased( key )
	if key == love.key_return then
		text = "RETURN has been released!"
	end
	if key == love.key_h then
		if love.mouse.isVisible() then
			love.mouse.setVisible(false)
		else
			love.mouse.setVisible(true)
		end
	end
end

function mousepressed(x, y, button)
	if button == love.mouse_left then
		text = "Mouse button left is pressed"
	end
end

function mousereleased(x, y, button)
	if button == love.mouse_left then
		text = "Mouse button left is pressed"
	end
end

function draw()
	love.graphics.draw( text, 330, 300 )
	love.graphics.draw( "Mouse X: ".. mouse_x .. " Mouse Y: " .. mouse_y, 10, 20 )
end
