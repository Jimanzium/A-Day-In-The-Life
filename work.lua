
local itemW = 10
local itemSpeed = 50
local items = {}

local borderW = 58
local borderH = 77
local counter = {
	collectW = 36,
	collectBorder = 10,
	x = borderW,
	y = borderH,
	w = 480 - borderW * 2,
	h = 270 - borderH * 2
}

local function add_item(x,y,type,dx)
	local it = {x=x,y=y,type=type,dx=dx}
	table.insert(items,it)
end

local function spawn_item()
	local r = math.random(1,2)
	local x = counter.x - itemW
	local y = math.random(counter.y + itemW, counter.y + counter.h - itemW)
	local dx = math.random(5,10)/10 * itemSpeed
	
	local type = math.random(1,2)
	if(r == 2) then x = counter.x + counter.w + itemW; dx = -dx end
	
	add_item(x,y,type,dx)
end

local spawnTime = 1
local spawnTimer = 0


local grabbed = 0

local scoreGood = 0
local scoreBad = 0

local busy = 1

local state = "first"

local workTime = 30
local workTimer = workTime

local rTimer = 0

local parts = {}
function add_part(x,y,type)
	local pa = {x=x,y=y,type=type,timer = 0}
	table.insert(parts,pa)
end


function work_update(dt)
	if(state == "first") then
		rTimer = math.min(1,rTimer + math.max(0.1 * dt, (1 - rTimer) * 3 * dt ))
	elseif(state == "report") then
		rTimer = math.min(1,rTimer + math.max(0.1 * dt, (1 - rTimer) * 3 * dt ))
	elseif(state == "play") then
		rTimer = math.max(0,rTimer - math.max(0.1 * dt, (1 - rTimer) * 3 * dt ))
		for i,v in ipairs(parts) do
			v.timer = v.timer + dt
			if(v.timer > 1) then
				table.remove(parts,i)
			end
		end

		workTimer = math.max(0,workTimer - dt)
		if(workTimer <= 0 and #items == 0 and #parts == 0) then
			state = "report"
		end


		if(workTimer > 0) then
			busy = math.min(5,get_day())
			local t = math.min(1,1/busy * 4)
			spawnTime = t - (1 - workTimer/workTime) * t/2
			spawnTimer = spawnTimer - dt
			if(spawnTimer < 0) then
				spawnTimer = spawnTimer + spawnTime
				spawn_item()
			end

		end

		for i=#items,1,-1 do
			local v = items[i]
			if(i ~= grabbed) then
				v.x = v.x + v.dx * dt
				if(v.x + v.dx * dt + itemW < counter.x or v.x + v.dx * dt - itemW> counter.x + counter.w) then
					add_part(v.x,v.y,v.type)
					scoreBad = scoreBad + 1
					sfx_play(3)
					table.remove(items,i)
					if(grabbed > i) then
						grabbed = grabbed - 1
					end
				end
			end
		end

		if not(love.mouse.isDown(1)) then
			if(grabbed > 0 and grabbed <= #items) then
				local item = items[grabbed]
				local mx, my = get_mouse()

				
				--if(mouse_over(counter.x, counter.y - counter.collectBorder - counter.collectW, counter.w, counter.collectW)) then

				if(my < counter.y) then
					add_part(item.x,item.y,item.type)
					table.remove(items,grabbed)
					grabbed = 0
					if(item.type == 2) then
						scoreGood = scoreGood + 1
						sfx_play(4)
					else
						scoreBad = scoreBad + 1
						sfx_play(3)
					end

				end
				
				--if(mouse_over(counter.x, counter.y + counter.h + counter.collectBorder, counter.w, counter.collectW)) then
				if(my > counter.y + counter.h) then
					add_part(item.x,item.y,item.type)
					table.remove(items,grabbed)
					grabbed = 0
					if(item.type == 1) then
						scoreGood = scoreGood + 1
						sfx_play(4)
					else
						scoreBad = scoreBad + 1
						sfx_play(3)
					end
				end
			end

			grabbed = 0
		end

		if(grabbed > 0 and grabbed <= #items) then
			local item = items[grabbed]
			local mx, my = get_mouse()
			item.x = mx
			item.y = my
		end
	end
end

function work_mousepressed(x,y,button)
	if(state == "first") then
		state = "play"
	elseif(state == "play") then
		for i,v in ipairs(items) do
			if(get_dist(x, y, v.x, v.y) < itemW * 1.25 and (grabbed == 0 or v.type == 1)) then
				grabbed = i
			end
		end
	elseif(state == "report" and rTimer >= 1) then
		parts = {}
		rTimer = 0
		items = {}
		local d = get_day()
		if(d >= 5) then
			workTime = workTime + 5
		end

		workTimer = workTime
		state = "play"

		if(scoreBad < 10) then
			change_state("room")
			change_rooms(9)
		else
			fail(6)
		end

		scoreGood = 0
		scoreBad = 0
	end
end

local cImg = love.graphics.newImage("gfx/render/counter.png")

local coin = love.graphics.newImage("gfx/coin.png")
local clipboard = love.graphics.newImage("gfx/clipboard.png")

function work_draw()
	local screen = {}
	screen.w, screen.h = screen_getDimensions()



		love.graphics.draw(cImg)
		--love.graphics.rectangle("line", counter.x, counter.y ,counter.w, counter.h)
		--love.graphics.rectangle("line", counter.x, counter.y - counter.collectBorder - counter.collectW, counter.w, counter.collectW) -- red collect
		--love.graphics.rectangle("line", counter.x, counter.y + counter.h + counter.collectBorder, counter.w, counter.collectW) -- green collect

		local stencil = function()
			love.graphics.rectangle("fill", counter.x, counter.y - counter.collectBorder - counter.collectW, counter.w, counter.h + counter.collectBorder*2 + counter.collectW*2)
		end
		love.graphics.stencil(stencil,"replace",1)
		love.graphics.setStencilTest("equal",1)

		for i,v in ipairs(parts) do
			if(v.type == 2) then
				love.graphics.setColor(255,0,0,255*(1-v.timer))
			else
				love.graphics.setColor(0,255,0,255*(1-v.timer))
				
			end
			love.graphics.draw(coin,v.x,v.y,0,(1+v.timer)^2,(1+v.timer)^2,10,10)
		end

		for i,v in ipairs(items) do 
			if(v.type == 2) then
				love.graphics.setColor(255,0,0)
			else
				love.graphics.setColor(0,255,0)
				
			end
			if(i == grabbed) then
				--love.graphics.circle("fill",v.x,v.y,itemW*1.25)
				love.graphics.draw(coin,v.x,v.y,0,1.25,1.25,10,10)
			else 
				--love.graphics.circle("fill",v.x,v.y,itemW)
				love.graphics.draw(coin,v.x,v.y,0,1,1,10,10)
			end
		end
		love.graphics.setColor(255,255,255)

		love.graphics.setStencilTest()


		-- first time instructions
		local y = screen.h - (rTimer)/1 * screen.h
		love.graphics.draw(clipboard,0,y)

		love.graphics.setColor(0,0,0)
		cprint("How to work:", screen.w/2, y + 80)
		cprint("Drag red items to red zone", screen.w/2, y + screen.h/2)
		cprint("Drag green items to green zone", screen.w/2, y + screen.h/2 + 40)
		love.graphics.setColor(255,255,255)

		--love.graphics.print(scoreGood.." : "..scoreBad,100,0)
	
	if(state == "report") then

		local y = screen.h - (rTimer)/1 * screen.h
		love.graphics.draw(clipboard,0,y)
		love.graphics.setColor(0,0,20)
		cprint("End of day Report", screen.w/2, y + 80)
		cprint("You did "..scoreGood.." things right", screen.w/2, y + screen.h/2)
		cprint("&", screen.w/2, y + screen.h/2 + 20)
		cprint("You did "..scoreBad.." things wrong", screen.w/2, y + screen.h/2 + 40)
		love.graphics.setColor(255,255,255)
	elseif(state == "first") then
	
	else
		--love.graphics.print(math.floor(workTimer), screen.w/2,6)
	end
	
end