

local clickables = {}

function add_clickable(x,y,w,h,name,func)
	local cl = {x=x,y=y,w=w,h=h,name=name,func=func}
	table.insert(clickables, cl)
end


local curRoom = 1
local rooms = {}

rooms[1] = {
	name = "Bedroom AM",
	back = love.graphics.newImage("gfx/render/bedroom.png"),
	loadClicks = function()
		local func = function() change_option(1) end
		add_clickable(290,65,107,153,"Bedroom Door",func)
		local func = function() change_option(4) end
		add_clickable(156,208,177,62,"Bed",func)
		local func = function() change_option(15) end
		add_clickable(80,119,110,74,"Project",func)

	end,
	encounters = {17,22,23,24}
}

rooms[2] = {
	name = "Hallway",
	back = love.graphics.newImage("gfx/render/hallway.png"),
	loadClicks = function()
		local func = function() change_option(2) end
		add_clickable(207,100,62,94,"Front Door",func)
		local func = function() change_option(3) end
		add_clickable(0,250,480,20,"Bedroom",func)
	end	
}


rooms[3] = {
	name = "The Way to Work",
	back = love.graphics.newImage("gfx/render/outsideTP.png"),
	loadClicks = function()

	end,

	roomEndTime = 15,

	roomEnd = function()
		change_rooms(4)
	end,

	encounters = {29,30}
}

rooms[4] = {
	name = "Work",
	back = love.graphics.newImage("gfx/render/work.png"),
	loadClicks = function()
		local func = function() change_option(5) end
		add_clickable(271,74,204,147,"Counter",func)

		local func = function() change_option(6) end
		add_clickable(35,114,53,78,"Exit",func)
	end,

	encounters = {25,26,27,28}
}


rooms[5] = {
	name = "The Way Home",
	back = love.graphics.newImage("gfx/render/outsideTP.png"),
	loadClicks = function()

	end,

	roomEndTime = 15,

	roomEnd = function()
		change_rooms(6)
	end
}

rooms[6] = {
	name = "Hallway PM",
	back = love.graphics.newImage("gfx/render/hallwayPM.png"),
	loadClicks = function()
		local func = function() change_option(7) end
		add_clickable(0,250,480,20,"Front Door",func)
		local func = function() change_option(8) end
		add_clickable(143,46,99,155,"Stairs",func)
	end	
}

rooms[7] = {
	name = "Bedroom PM",
	back = love.graphics.newImage("gfx/render/bedroomPM.png"),
	loadClicks = function()
		local func = function() change_option(9) end
		add_clickable(290,65,107,153,"Bedroom Door",func)
		local func = function() change_option(10) end
		add_clickable(156,208,177,62,"Bed",func)
		local func = function() change_option(16) end
		add_clickable(80,119,110,74,"Project",func)
	end,

	encounters = {18,19,20,21}
}

rooms[8] = {
	name = "In Bed",
	--back = love.graphics.newImage("gfx/bed.png"),
	loadClicks = function()
		--local func = function() change_option(1) end
		--add_clickable(374,25,57,61,"Bedroom Door",func)
		--local func = function() change_option(4) end
		--add_clickable(115,182,249,89,"Bed",func)

	end,

	roomEndTime = 5,

	roomEnd = function()
		change_rooms(1)
		change_state("newDay")
	end
}

rooms[9] = {
	name = "Work PM",
	back = love.graphics.newImage("gfx/render/work.png"),
	loadClicks = function()
		local func = function() change_option(12) end
		add_clickable(271,74,204,147,"Counter",func)

		local func = function() change_option(11) end
		add_clickable(35,114,53,78,"Exit",func)
	end
}

local roomEndTime = 0
local roomEndTimer = 0

local doneEncounter = false

function change_rooms(room)

	doneEncounter = false
	if(room <= #rooms and room > 0) then
		set_fade()

		curRoom = room
		clickables = {}
		rooms[room].loadClicks()

		local room = rooms[curRoom]
		if(room.roomEndTime) then
			roomEndTime = room.roomEndTime
			roomEndTimer = roomEndTime
		end
		
		if(room.encounters) then
			--change_state("room")
			--change_option(room.encounters[1])
		end
		
	end
end

local lTimer = 0
local bob = 0



function rooms_reset()

end

local bikeSound = love.audio.newSource("sfx/bike.ogg")
bikeSound:setLooping(true)

function rooms_update(dt)
	if(curRoom == 3 or curRoom == 5) then
		bikeSound:play()
	else
		bikeSound:stop()
	end

	local room = rooms[curRoom]
	if(room.encounters and doneEncounter == false and #room.encounters >= 1) then
		local r = math.random(1,3)
		if(r == 1) then
			change_option(room.encounters[1])
			local temp = room.encounters[1]
			for i=2,#room.encounters do
				room.encounters[i-1] = room.encounters[i]
			end
			room.encounters[#room.encounters] = temp
		end
		doneEncounter = true
	end

	bob = bob + 8 * dt
	bob = bob % (2*math.pi)
	local hover = false
	for i,v in ipairs(clickables) do
		if(mouse_over(v.x,v.y,v.w,v.h)) then
			hover = true
			
		end
	end
	if(hover) then
		lTimer = math.min(lTimer + dt,1)
	else
		lTimer = 0
		--lTimer = math.max(lTimer - dt,0)
	end
	


	if(roomEndTimer > 0 and room.roomEnd) then
		roomEndTimer = math.max(0, roomEndTimer - dt)
		if(roomEndTimer == 0) then
			roomEndTime = 0
			local room = rooms[curRoom]
			room.roomEnd()
		end
	end
end

function room_mousepressed(x,y)
	for i,v in ipairs(clickables) do
		if(v.func and mouse_over(v.x,v.y,v.w,v.h)) then
			v.func()
		end
	end
end

local bike = love.graphics.newImage("gfx/bike.png")

function rooms_draw()
	local screen = {}
	screen.w, screen.h = screen_getDimensions()

	local room = rooms[curRoom]
	if(room.back) then
		if(curRoom == 3 or curRoom == 5) then
			local c2 = {255,65,0}
			local c1 = {0,255,255}
			if(curRoom == 5) then
				c2 = {81,97,113}
				c1 = {0,0,35}
			end
			local p = roomEndTimer/roomEndTime
			love.graphics.setColor(c1[1] + (c2[1] - c1[1]) * p,c1[2] + (c2[2] - c1[2]) * p,c1[3] + (c2[3] - c1[3]) * p)
			love.graphics.rectangle("fill",0,0,screen.w, screen.h)
			love.graphics.setColor(255,255,255)
		end

		love.graphics.draw(room.back)
	end
	love.graphics.print(room.name,4,4)
	for i,v in ipairs(clickables) do
		if(mouse_over(v.x,v.y,v.w,v.h) and get_state() == "room") then
			local mx, my = get_mouse()
			love.graphics.setColor(255,255,255,255*lTimer)
			cprint(v.name, mx, my-10)
			love.graphics.setColor(255,255,255)
			--love.graphics.rectangle("line", v.x - 4, v.y - 4, v.w + 8, v.h + 8)
			--love.graphics.print(v.name, v.x, v.y - 17)
		end
		--love.graphics.rectangle("line", v.x, v.y, v.w, v.h)
	end

	if(room.roomEndTime) then
		cprint(roomEndTimer..", "..roomEndTime,screen.w/2,440)
	end

	if(curRoom == 3) then
		local p = roomEndTimer/roomEndTime
		local a = -p * math.pi
		local b = math.cos(bob) * 5
		local dx = math.cos(a) * (180 + b)
		local dy = math.sin(a) * (180 + b)
		love.graphics.draw(bike, screen.w/2 + dx, screen.h + dy, a + math.pi/2,0.5,0.5, 50, 25)
		--love.graphics.circle("fill", screen.w/2 + dx, screen.h + dy,20)
		--love.graphics.rectangle("fill",0,0,screen.w*p,4)
	end
	if(curRoom == 5) then
		local p = roomEndTimer/roomEndTime
		local a = -p * math.pi
		local b = math.cos(bob) * 5
		local dx = math.cos(a) * (180 + b)
		local dy = math.sin(a) * (180 + b)
		love.graphics.draw(bike, screen.w/2 - dx, screen.h + dy, -a - math.pi/2,-0.5,0.5, 50, 25)
		--love.graphics.circle("fill", screen.w/2 - dx, screen.h + dy,10)
		--love.graphics.rectangle("fill",0,0,screen.w*p,4)
	end
end