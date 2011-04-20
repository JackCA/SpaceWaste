Level1 = {}
Level1.__index = Level1
Level1.font_small = love.graphics.newFont("fonts/freshbot.ttf", 20)
Level1.font = love.graphics.newFont("fonts/freshbot.ttf", 30)
Level1.font_huge = love.graphics.newFont("fonts/freshbot.ttf", 50)
Level1.color = love.graphics.newColor(220,220,220)
Level1.overlay = love.graphics.newColor(100,100,100,150)
Level1.music = love.audio.newSound("sounds/music/LazorZone.aif")
Level1.victory = love.audio.newSound("sounds/music/victory.wav")
Level1.alarm = love.audio.newSound("sounds/alarm.wav")
love.audio.play(Level1.music, 0)
Level1.music:setVolume(0)
love.audio.play(Level1.victory, 0)
Level1.victory:setVolume(0)

function Level1.create()
	local temp = {}
	setmetatable(temp, Level1)

	temp.button = {resume=Button.create_text("Resume", screen.width/2-100, screen.height/2+100),
		quit = Button.create_text("Quit", screen.width/2+125, screen.height/2+100),
		quit2 = Button.create_text("Quit", screen.width/2, screen.height/2+100)}

	return temp
end

function Level1:draw()
	objm:draw()

	love.graphics.setFont(self.font_small)
	love.graphics.setColor(self.color)
	love.graphics.draw("FPS: " .. love.timer.getFPS(), 50, 50)

	love.graphics.setFont(self.font_huge)
	love.graphics.setColor(self.color)
	love.graphics.draw(self.status(), 100, screen.height-50)

	if self.state=="pause" then
		love.graphics.setColor(self.overlay)
		love.graphics.rectangle(love.draw_fill, 0, 0, screen.width, screen.height)
		love.graphics.setColor(self.color)
		love.graphics.setFont(self.font_huge)
		love.graphics.drawf("PAUSED", 0, screen.height/2-150, screen.width, love.align_center)
		self.button.resume:draw()
		self.button.quit:draw()
	end

	if self.state=="victory" then
		love.graphics.setColor(self.overlay)
		love.graphics.rectangle(love.draw_fill, 0, 0, screen.width, screen.height)
		love.graphics.setColor(self.color)
		love.graphics.setFont(self.font_huge)
		love.graphics.drawf("VICTORY :)", 0, screen.height/2-150, screen.width, love.align_center)
		self.button.quit2:draw()
	end
end

function Level1:update(dt)
	if self.dialog~=nil and self.dialog.destroyed then
		self.dialog = nil
	end
	if self.state=="pause" then
		self.button.resume:update()
		self.button.quit:update()
	elseif self.state=="victory" then
		self.button.quit2:update()
	else
		if self.dialog==nil or self.dialog.continue then
			objm:update(dt)
		end
	end

	if player.hp<=0 then 
		local trash = Trash.create(player.body:getX(),player.body:getY(),5,player.dead,28)
		screen.mode="relaxed"
	  screen.tracking = trash
		player.hp = 1000
		player.freeze = true
		local x,y = world:edge()
		player.body:setX(x)
		player.body:setY(y)
		player:unload()
		self.deaths = self.deaths + 1
		Event.create(function()
		  player = Player.create(100,500)
		  screen.tracking = player
			screen.mode="focused"
			if self.deaths==1 then
				if self.dialog==nil then self.dialog=Dialog.create({{"Milo","By the way, we've got human cloning technology in our ship, so don't worry about dying!"}}) end
			end
		end,3)
  end
end

function Level1:mousepressed(x,y,button)
	--print((x+screen.x)/screen.scale,(y+screen.y)/screen.scale)
	if self.state=="pause" then
		if self.button["resume"]:mousepressed(x, y, button) then
			self.state = self.oldstate
		elseif self.button["quit"]:mousepressed(x, y, button) then
			changestate(Menu.create())
		end
	elseif self.state=="victory" then
		if self.button["quit2"]:mousepressed(x, y, button) then
			changestate(Menu.create())
		end
	else
		if self.dialog~=nil then self.dialog:mousepressed(x,y,button) 
		else objm:mousepressed(x,y,button) end
	end
end

function Level1:keypressed(key)
	if key==love.key_v then
		pirate:explode()
	end
	if key==love.key_escape then
		self.oldstate = self.state
		self.state = "pause"
	else
		if self.dialog~=nil then self.dialog:keypressed(key) 
		else objm:keypressed(key) end
	end
end

function Level1:unload()
	self.music:setVolume(0)
	self.victory:setVolume(0)
	objm:unload()
	-- remove singletons too
end

function Level1:load()
	self.music:setVolume(1)

	self.state = "tutorial"

	objm = ObjManager.create()

	objm:register(screen)
	objm:register(sound)

	world = World.create(function(a,b,c) self:collision(a,b,c) end)
	world:resize(1000,1000)

	player = Player.create(100,600)

	screen.tracking = player

	Grid.create()


	Trash.create(50,450,5,love.graphics.newImage("images/trash/paper-1.png"),50)
	Trash.create(50,470,5,love.graphics.newImage("images/trash/bottle.png"),50)
	Trash.create(50,480,5,love.graphics.newImage("images/trash/bananapeel.png"),50)
	Trash.create(60,460,5,love.graphics.newImage("images/trash/toilet.png"),50)

	ggun = GGun.create()

	shiprecycler = ObjRecycle.create()
	for i=1,20 do
		shiprecycler:add(Ship.create({"human"},shiprecycler))
	end

	alienrecycler = ObjRecycle.create()
	for i=1,20 do
		local ship = Ship.create({"alien"},alienrecycler)
    ship.body:setAngle(180)
		ship.image = love.graphics.newImage("images/unit/alien.png")
		alienrecycler:add(ship)
	end

	laserrecycler = ObjRecycle.create()
	for i=1,200 do
		laserrecycler:add(Laser.create(laserrecycler))
	end

	for i=1,200 do
		Star.create(math.random()*1000, math.random()*200+800)
	end

	local image = love.graphics.newImage("images/trash/paper-2.png")
	debrirecycler = ObjRecycle.create()
	for i=1,1000 do
		debrirecycler:add(Debri.create(debrirecycler,5,image,50))
	end
    
    

	Planet.create(200,500)
    
	local planet = Planet.create(500,600, 80, true)
	planet.image = love.graphics.newImage("images/background/planet-blue.png")
	local images = {"paper-1.png","paper-2.png","bottle.png","bananapeel.png","asteroid-1.png","toilet.png","tv.png","couch.png"}
	for i,img in ipairs(images) do
		images[i] = love.graphics.newImage("images/trash/"..img)
	end
	for i=1,50 do
		Trash.create(400+math.random()*200, 600+math.random()*200, math.random()+4.5,
			images[math.random(1,8)], 50)
	end
    
--    local dstar = Planet.create(300,200,100,false,true)
	local dstar = Trash.create(300,200,120,love.graphics.newImage("images/background/dstar.png"),320)
  dstar.body:setMass(0,0,0,0)
    
	local x,y = world:edge()
	pirate = Pirate.create(x,y,20)

	self.mothership = Mothership.create(100,550,20)

	screen:update(0)

	self.status = function() return "" end
	self.deaths = 0

	self.dialog = Dialog.create({{"Milo", "Freighter 3 to Calder, come in. (You can read through the dialog using space bar or skip using enter)"},
		{"Calder","I read you, Milo."},
		{"Milo","Good!  Today is your first day of Space Janitor training.  See that flashing red beacon on your screen?"},
		{"Milo","That's called a TacDot and it indicates one of your objectives.  In this case, your job is to maneuver yourself into the TacDots using the WASD keys."}})


	local pirate_event = function()
		beacon.active=false
		self.dialog = Dialog.create({{"Milo", "Wow nice, you picked up 20 pieces of trash on the first day of work. All right, moving on.  Your next mission is to- holy crap, pirates!"}})
		self.dialog.trigger = function()
			pirate.body:setX(550)
			pirate.body:setY(380)
			pirate.body:setAngle(0)
			pirate.mode = "moving"
			self.dialog = Dialog.create({{"Pirate", "Yarrr!"}}, pirate)
			pirate.trigger_fix = function()
				if self.dialog then self.dialog:unload() end
				self.dialog = Dialog.create({{"Pirate", "Give us your trash loot! Yarrr!"},{"Milo","Hmph, not so easy"},{"Milo","Crap, our lasers are still under maintenance! Calder, you've got to find a way to destroy that ship!  Look for a weak point and use the Grabity Gun!"}}, pirate)
				self.dialog.trigger = function() 
					self.dialog:unload() 
					love.audio.play(self.alarm,1)
					self.cont_spawn = true
					spawn = function()
						if self.cont_spawn then
							self:spawn()
							Event.create(spawn, self.spawn_rate or 10)
						end
					end
					spawn()
				end
			end
			pirate.trigger_dist = function()
				pirate.trigger_dist = nil
				self.dialog = Dialog.create({{"Calder","Hm, exhaust ports.  I wonder what would happen if I clog these with trash?"}},pirate)
				self.dialog.trigger = function()
					self.dialog:unload()
					pirate.beacon1.active = true
					pirate.beacon2.active = true
					self.status = function() return (pirate.beacon1.trash+pirate.beacon2.trash).."/6" end
					f = function()
						if pirate.beacon1.trash+pirate.beacon2.trash==1 then
							self.dialog = Dialog.create({{"Milo","Calder, that's it!  Clog the exhaust ports and the engines will overheat!"},{"Pirate","Arrg, we are losing one o' our engines, mateys!  They be hittin us with everything they got!  Dispatch all remainin' fighters, yarrr!"}})
							self.fire_rate = .5
							self.spawn_rate = 5
						end
					end
					exp_trig = function()
						if pirate.beacon1.active or pirate.beacon2.active then
							Event.create(function() 
								self.dialog = Dialog.create({{"Pirate","Ahhhrg!  We lost one of our main engines, scallywags!  We've got to make good our escape!  Divert all remaining power to emergency engines and set sail for safer waters, yarrr!"},{"Milo","Quick! go catch the pirates!"}})
								pirate:escape()
							end, 1)
						else
							pirate:explode()
							Event.create(function() 
								self.state="victory" 
								self.music:setVolume(0)
								self.victory:setVolume(1)
							end, 7)
							player.hp = 1000
						end
					end
					pirate.beacon1.trigger = function()
						if pirate.beacon1.trash>=3 then
							pirate.beacon1.active = false
							local exp = Explosion.create(pirate.beacon1:getX(),pirate.beacon1:getY(),-60)
							exp.trigger = function()
								exp_trig()
							end
							local trash = Trash.create(pirate.beacon1:getX(),pirate.beacon1:getY(),5,pirate.engine1,37.5)
							trash.body:setAngle(0)
							trash.body:applyImpulse(-100,-100)
						end
						f()
					end
					pirate.beacon2.trigger = function()
						if pirate.beacon2.trash>=3 then
							pirate.beacon2.active = false
							local exp = Explosion.create(pirate.beacon2:getX(),pirate.beacon2:getY(),60)
							exp.trigger = function()
								exp_trig()
							end
							local trash = Trash.create(pirate.beacon2:getX(),pirate.beacon2:getY(),5,pirate.engine2,37.5)
							trash.body:setAngle(0)
							trash.body:applyImpulse(100,-100)
						end
						f()
					end
				end
			end
		end
	end

	beacon = Beacon2.create(50, 500, player)
	beacon.active = true
	beacon.trigger = function()
		beacon.active=false	
		self.dialog = Dialog.create({{"Milo","Good work, Calder.  Now it's time to practice with your Grabity Gun."},
			{"Calder","Don't you mean Gravity Gun?"},
			{"Milo","No, GRABity gun.  Gravity Gun is copyright by Valve, idiot, everyone knows that.  Now, see the flashing beacon on our ship?  That's where you need to put the trash."},
			{"Milo","Vacuum by holding right click and any trash in your beam will get sucked up.  Left click to shoot the trash.  Shoot 3 trash into the TacDot to continue."}})
		self.status = function() return self.mothership.beacon.trash.."/3" end
		self.dialog.trigger = function()
			self.mothership.beacon.active = true
			self.mothership.beacon.trigger = function()
				if self.mothership.beacon.trash>=3 then
					self.dialog = Dialog.create({{"Milo", "Good job. Now do your work as a janitor. Go around and pick up some more trash. Toward east there is a blue star. It should have plenty of trash."}})
					self.status = function() return self.mothership.beacon.trash.."/20" end
					self.mothership.beacon.trigger = function()
						if self.mothership.beacon.trash>=20 then
							self.dialog = Dialog.create({{"Milo", "Wow nice, you picked up 20 pieces of trash on the first day of work. All right, moving on.  Your next mission is to- holy crap, pirates!"}})
							self.dialog.trigger = function()
								pirate.body:setX(550)
								pirate.body:setY(380)
								pirate.body:setAngle(0)
								self.mothership.beacon.active = false
								pirate_event()
							end
						end
					end
				end
			end
		end
	end

end

function Level1:collision(obj1,obj2,contact)
	if obj1~=nil and obj1.collision~=nil then
		obj1:collision(obj2,contact)
	end
	if obj2~=nil and obj2.collision~=nil then
		obj2:collision(obj1,contact)
	end
	if obj2~=nil and obj1~=nil and 
		(obj2.__index==Trash and obj1.__index==Ship or
		obj1.__index==Trash and obj2.__index==Ship) then
		self.trash_hit_ship = true
	end
end


function Level1:spawn()
	for _,coord in ipairs({{330, 300},{350,400},{370, 515}}) do
		local ship = alienrecycler:spawn(unpack(coord))
		if ship==nil then print("need more alien") 
		elseif self.fire_rate then ship.rate = self.fire_rate end
	end
	for _,coord in ipairs({{100, 300},{160, 400},{130, 500}}) do
		local ship = shiprecycler:spawn(unpack(coord))
		if ship==nil then print("need more ship")
		elseif self.fire_rate then ship.rate = self.fire_rate end
	end
end
