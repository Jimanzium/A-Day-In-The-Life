
local timer = 0

function title_update(dt)

	timer = timer + (math.floor(timer + 1) - timer) * dt + 0.1 * dt
	timer = math.min(4, timer)
end

function title_mousepressed(x,y)
	if(timer > 0.25 and timer < 3) then
		timer = 3
	elseif(timer > 0.25) then
		change_state("newDay")
		set_fade()
	end
end

function title_draw()
	local screen = {}
	screen.w, screen.h = screen_getDimensions()

	if(timer < 1) then

	end

	local y = screen.h/2 - (timer-1) * 20

	love.graphics.setColor(255,255,255,math.min(255,255*timer))
	cprint("A day in the life...", screen.w/2, y)
	if(timer > 1) then
		love.graphics.setColor(255,255,255,math.min(255,255*(timer-1)))
		cprint("Created within 48 hours for Ludum Dare 47", screen.w/2, y + 20)
	end
	if(timer > 2) then
		love.graphics.setColor(255,255,255,math.min(255,255*(timer-2)))
		cprint("Inspired by true stories...", screen.w/2, y + 40)
	end
	if(timer > 3) then
		love.graphics.setColor(255,255,255,math.min(255,255*(timer-3)))
		cprint("Left click to begin", screen.w/2, y + 80)
	end
	love.graphics.setColor(255,255,255)
end