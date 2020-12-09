love.graphics.setDefaultFilter("nearest", "nearest")

require "rooms"
require "options"
require "work"
--require "encounters"
require "fails"
require "title"
require "sfx"
function love.load()
	math.randomseed(os.time())
	local f = love.graphics.newFont("font/steelfish rg.ttf",20)
	f:setFilter("linear","linear")
	love.graphics.setFont(f)

	change_rooms(1)
end



local state = "title"

function change_state(newState)
	state = newState
end

function get_state()
	return state
end

local day = 1

function get_day()
	return day
end

local fade = 0
local fadeSpeed = 1

function set_fade()
	fade = 1
end

function love.update(dt)
	music_control()
	if(fade > 0) then
		fade = fade - dt
	end
	if(state == "title") then
		title_update(dt)
	elseif(state == "newDay") then

	elseif(state == "room") then
		rooms_update(dt)
	elseif(state == "options") then
		options_update(dt)
	elseif(state == "work") then
		work_update(dt)
	elseif(state == "encounter") then
		--encounters_update(dt)
	elseif(state == "fail") then
		fails_update(dt)
	end
end



local screen = {w=480,h=270}
function screen_getDimensions()
	return screen.w, screen.h
end
local scale = 0
local ox, oy = 0,0
function love.draw()
	love.graphics.push()
		local w, h = love.graphics.getDimensions()
		scale = math.min(w/screen.w,h/screen.h)
		ox, oy = 0, 0
		if(w/screen.w > h/screen.h) then
			ox = w/2 - scale * screen.w/2
		else
			oy = h/2 - scale * screen.h/2
		end
		
		love.graphics.translate(ox, oy)
		love.graphics.scale(scale,scale)


		if(state == "title") then
			title_draw()
		elseif(state == "newDay") then
			cprint("DAY "..day, screen.w/2, screen.h/2)
		elseif(state == "room") then
			rooms_draw()
		elseif(state == "options") then
			--rooms_draw()
			options_draw()
		elseif(state == "work") then
			work_draw()
		elseif(state == "encounter") then
			work_draw()
			--encounters_draw()
		elseif(state == "fail") then
			fails_draw()
		end

		love.graphics.setColor(0,0,0,255*fade)
		love.graphics.rectangle("fill",0,0,screen.w,screen.h)
		love.graphics.setColor(255,255,255)

	love.graphics.pop()
end

function get_mouse()
	local mouseX, mouseY = love.mouse.getPosition()
	mouseX = (mouseX-ox)/scale
	mouseY = (mouseY-oy)/scale
	return mouseX, mouseY	
end

function mouse_over(x,y,w,h)
	local mouseX, mouseY = love.mouse.getPosition()
	mouseX = (mouseX-ox)/scale
	mouseY = (mouseY-oy)/scale
	if(mouseX > x and mouseX < x + w and mouseY > y and mouseY < y + h) then
		return true
	end
	return false
end

function love.keypressed(key)
	if(key == "escape") then
		change_option(14)
	elseif(key == "f1") then
		love.window.setFullscreen(not(love.window.getFullscreen()))
	end
end

function love.mousepressed(x,y,button)
	x = (x-ox)/scale
	y = (y-oy)/scale

	if(button == 1) then
		sfx_play(1)
		if(state == "newDay") then
			fade = 1
			state = "room"
			day = day + 1
		elseif(state == "room") then
			room_mousepressed(x,y)
		elseif(state == "options") then
			options_mousepressed(x,y)
		elseif(state == "work") then
			work_mousepressed(x,y)
		elseif(state == "encounter") then
			encounters_mousepressed(x,y)
		elseif(state == "fail") then
			fails_mousepressed(x,y)
		elseif(state == "title") then
			title_mousepressed(x,y)
		end
	end
end

function reset()
	change_rooms(1)
	day = 1
	change_state("newDay")
end

function cprint(text,x,y)
	local f = love.graphics.getFont()
	local w = f:getWidth(text)
	local h = f:getHeight(text)

	--love.graphics.setColor(0,0,0)
	--love.graphics.rectangle("fill",x-w/2 - 1,y-h/2 - 1,w + 2,h + 2)
	--love.graphics.setColor(255,255,255)

	love.graphics.print(text,x-w/2,y-h/2)
end

function get_dist(x1,y1,x2,y2)
	return math.sqrt((y2 - y1)^2 + (x2 - x1)^2)
end