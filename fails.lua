
local fails = {}
fails[1] = "You decided to risk your entire career for 5 more minutes sleep"
fails[2] = "You decided today was not the to work for someone else, now you work for no-one"
fails[3] = "You decided to steal from your employer, this is an irredeemable act"
fails[4] = "You decided to work for yourself today, unfortunatly you don't pay yourself"
fails[5] = "You decided to risk the night on the streets of Salford, it didn't pan out"
fails[6] = "Your work rate was unsatisfactory, how could you jepordise our profit margins feeble human"
fails[7] = "You simply could not be arsed, fair enough I suppose"
fails[8] = "After staying up all night playing with bionicles you slept in, well done"
fails[9] = "You succumbe to existential dread"
fails[10] = "The big cheese was not pleased with you ignoring them"
fails[11] = "You feel relieved but I must say your future is not looking bright"
fails[12] = "I feel you, but you still lost"
fails[13] = "Over the horizon and yonder you travel, to what end nobody knows"
fails[14] = "You couldn't face the outdoors today, the bed was cozy though"
local curFail = 0

local timer = 0

function fail(f)
	timer = 0
	if(fails[f]) then
		--if(f==1 or f==2 or f==3 or f==4 or f==5 or f==6 or f==7 or f==8 or f==10 or f ==11 or f==14) then
			sfx_play(6)
		--end

		set_fade()
		curFail = f
		change_state("fail")
	end
end

function fails_mousepressed(x,y)
	change_option(13)
	--reset()
end

function fails_update(dt)
	if(timer < 1) then
		timer = timer + math.max(0.1*dt, (1-timer) * dt)
	else
		timer = timer + dt
	end
	if(timer > 10) then
		change_option(13)
	end
	--timer = math.min(timer,1)
end

function fails_draw()
	local screen = {}
	screen.w, screen.h = screen_getDimensions()

	if(fails[curFail]) then
		local fail = fails[curFail]
		love.graphics.setColor(255,255,255,255*math.min(1,timer))
		cprint(fail, screen.w/2, screen.h/2 + screen.h/2 * (1-math.min(1,timer)))
	end
end