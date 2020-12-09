
local state = "choose"

local curOption = 1
local options = {}

options[1] = { -- bedroom door
	text = "Your bedroom door, do you want to leave?",
	left = {
				text = "Leave",
				outcomes = {{text = "You leave the room", func = function() change_rooms(2);sfx_play(5) end}}
			},
	
	right = {
				text = "Don't Leave",
				outcomes = {{text = "You don't leave the room", func = function()  end}}
			}
}

options[2] = { -- front door
	text = "Your front door, this is how you go to work",
	left = {
				text = "Go to Work",
				outcomes = {{text = "You go to work", func = function() change_rooms(3);sfx_play(5) end}}
			},
	
	right = {
				text = "Don't Go",
				outcomes = {{text = "You don't go to work", func = function()  end}}
			}
}

options[3] = { -- hallway return
	text = "The way back into your room",
	left = {
				text = "Go back",
				outcomes = {{text = "You go back into your room", func = function() change_rooms(1);sfx_play(5) end}}
			},
	
	right = {
				text = "Don't Go Back",
				outcomes = {{text = "You don't go back into your room", func = function()  end}}
			}
}

options[4] = { -- back to bed
	text = "Your heavy eyelids attempt to tempt you into going back to sleep",
	left = {
				text = "Do it",
				outcomes = {{text = "You fall into a deep, blissful and sweet sleep", func = function() fail(1) end}}
			},
	
	right = {
				text = "Don't do it",
				outcomes = {{text = "You don't go back to sleep, today is not the day", func = function()  end}}
			}
}

options[5] = { -- work counter
	text = "This is where you work",
	left = {
				text = "Start work",
				outcomes = {{text = "You decide to start work", func = function() change_state("work") end}}
			},
	
	right = {
				text = "Not yet",
				outcomes = {{text = "Might be feeling it later", func = function()  end}}
			}
}


options[6] = { -- work counter
	text = "The way out",
	left = {
				text = "Leave",
				outcomes = {{text = "You decide to just go home instead", func = function() fail(2) end}}
			},
	
	right = {
				text = "Stay",
				outcomes = {{text = "You stay at work, work is life after all", func = function()  end}}
			}
}

options[7] = { -- Hallway pm - go back out
	text = "Go back outside",
	left = {
				text = "Go Out",
				outcomes = {{text = "You go back outside", func = function() fail(5) end}}
			},
	
	right = {
				text = "stay in",
				outcomes = {{text = "You stay in", func = function()  end}}
			}
}

options[8] = { -- Hallway pm - go bedroom
	text = "The way to your bedroom",
	left = {
				text = "Go up",
				outcomes = {{text = "You go up and into your bedroom", func = function() change_rooms(7);sfx_play(5) end}}
			},
	
	right = {
				text = "Stay down",
				outcomes = {{text = "You don't go into your bedroom", func = function()  end}}
			}
}

options[9] = { -- bedroom pm - go hallway
	text = "Leave bedroom",
	left = {
				text = "Leave",
				outcomes = {{text = "You go back into the hallway", func = function() change_rooms(6);sfx_play(5) end}}
			},
	
	right = {
				text = "Don't",
				outcomes = {{text = "You stay in your room", func = function()  end}}
			}
}

options[10] = { -- bedroom pm - go hallway
	text = "Get in bed",
	left = {
				text = "Get in",
				outcomes = {{text = "You go to bed", func = function() change_rooms(8) end}}
			},
	
	right = {
				text = "Not yet",
				outcomes = {{text = "You stay up a little longer", func = function()  end}}
			}
}

options[11] = { -- bedroom pm - go hallway
	text = "Go Home",
	left = {
				text = "Go",
				outcomes = {{text = "You leave work", func = function() change_rooms(5);sfx_play(5) end}}
			},
	
	right = {
				text = "Stay",
				outcomes = {{text = "You decide to stay at work, I'm not sure why...", func = function()  end}}
			}
}

options[12] = { -- bedroom pm - go hallway
	text = "Steal from register",
	left = {
				text = "Do it",
				outcomes = {{text = "You slip a fiver out of the cash register", func = function() fail(3) end}}
			},
	
	right = {
				text = "Don't do it",
				outcomes = {{text = "Probably wise", func = function()  end}}
			}
}

options[13] = { -- bedroom pm - go hallway
	text = "Retry?",
	left = {
				text = "Again",
				outcomes = {{text = "Here we go again...", func = function() reset() end}}
			},
	
	right = {
				text = "No Thanks",
				outcomes = {{text = "I am done with this shit", func = function() love.event.quit() end}}
			}
}

options[14] = { -- bedroom pm - go hallway
	text = "Leaving so soon?",
	left = {
				text = "Quit",
				outcomes = {{text = "Fuck this shit, I am out", func = function()  love.event.quit() end}}
			},
	
	right = {
				text = "Not yet",
				outcomes = {{text = "Maybe I can go another day", func = function() end}}
			}
}

options[15] = { -- bedroom pm - go hallway
	text = "Work on your project",
	left = {
				text = "Go for it",
				outcomes = {{text = "Why not, work can wait", func = function()  fail(4) end}}
			},
	
	right = {
				text = "Nah",
				outcomes = {{text = "No time, must go work", func = function() end}}
			}
}

options[16] = { -- bedroom pm -
	text = "Work on your project",
	left = {
				text = "Go for it",
				outcomes = {{text = "You make a little progress but ultimatley feel like its never going to be done", func = function()  end}}
			},
	
	right = {
				text = "Nah",
				outcomes = {{text = "Not feeling it today, perhaps inspiration shall strike tomorrow", func = function() end}}
			}
}

-- bed room encounters

options[17] = { 
	text = "You wake up to your alarm",
	left = {
				text = "Snooze it",
				outcomes = {{text = "Just give me a couple more minutes", func = function() fail(1) end}}
			},
	
	right = {
				text = "Get up",
				outcomes = {{text = "Best to just get straight up", func = function() end}}
			}
}

options[22] = { 
	text = "It's a cold morning",
	left = {
				text = "Snuggle",
				outcomes = {{text = "You think I'm going outside today?", func = function() fail(14) end}}
			},
	
	right = {
				text = "Get up",
				outcomes = {{text = "You suck it up and get up", func = function() end}}
			}
}

options[23] = { 
	text = "Just generally can't be arsed today",
	left = {
				text = "Be arsed",
				outcomes = {{text = "Must work", func = function()  end}}
			},
	
	right = {
				text = "Give up",
				outcomes = {{text = "Fuck it, today is not the day", func = function() fail(7) end}}
			}
}

options[24] = { 
	text = "Morning wood",
	left = {
				text = "Do it",
				outcomes = {{text = "You know how it be", func = function() end}}
			},
	
	right = {
				text = "Resist",
				outcomes = {{text = "No time for pleasure", func = function() end}}
			}
}

-- bedroom pm encounters

options[18] = { 
	text = "You look longingly at your bionicle collection",
	left = {
				text = "Play",
				outcomes = {{text = "Just give me a couple minutes with the bonks", func = function() fail(8) end}}
			},
	
	right = {
				text = "Don't",
				outcomes = {{text = "Best to leave them", func = function() end}}
			}
}

options[19] = { 
	text = "You start to wonder about your life accomplishments, or lack thereof",
	left = {
				text = "Spiral",
				outcomes = {{text = "You ask yourself why you could never be enough", func = function() fail(9) end}}
			},
	
	right = {
				text = "Stop",
				outcomes = {{text = "No time to question my life choices", func = function() end}}
			}
}

options[20] = { 
	text = "Will you ever find a purpose for your existence",
	left = {
				text = "Worry",
				outcomes = {{text = "Why do we even exist...", func = function() fail(9) end}}
			},
	
	right = {
				text = "Don't worry",
				outcomes = {{text = "No place to think about such things", func = function() end}}
			}
}

options[21] = { 
	text = "Time for computer games?",
	left = {
				text = "Play",
				outcomes = {{text = "Sleep? No need for it", func = function()  end}}
			},
	
	right = {
				text = "Don't",
				outcomes = {{text = "You lack the energy to enjoy them anyway", func = function() end}}
			}
}

-- work encounters

options[25] = { 
	text = "A co-worker passes you on your way in",
	left = {
				text = "Say Hi",
				outcomes = {{text = "You say hi, after a little small talk the conversation dies", func = function()  end}}
			},
	
	right = {
				text = "Ignore",
				outcomes = {{text = "You go straight past, not in the mood for words", func = function() end}}
			}
}

options[26] = { 
	text = "On your way in Big Boss asks to see you in the office",
	left = {
				text = "Go",
				outcomes = {{text = "It was nothing important, the feeling of dread exits your body", func = function()  end}}
			},
	
	right = {
				text = "Ignore",
				outcomes = {{text = "Hope it wasn't important", func = function() fail(10) end}}
			}
}

options[27] = { 
	text = "A co-worker starts talking to you as you enter, you can't wait for it to be over",
	left = {
				text = "That's crazy...",
				outcomes = {{text = "Your blunt replies seem effective", func = function()  end}}
			},
	
	right = {
				text = "Oh cool...",
				outcomes = {{text = "They eventually stop talking, you take this as your chance to leave", func = function() end}}
			}
}

options[28] = { 
	text = "It looks busier than usual today",
	left = {
				text = "Quit",
				outcomes = {{text = "Good call", func = function() fail(11) end}}
			},
	
	right = {
				text = "Go in anyway",
				outcomes = {{text = "Face the music", func = function() end}}
			}
}

options[29] = { 
	text = "You get the urge to cycle into traffic",
	left = {
				text = "Go for it",
				outcomes = {{text = "You swerve in front of an oncoming car", func = function() fail(12)  end}}
			},
	
	right = {
				text = "Resist",
				outcomes = {{text = "Maybe next time...", func = function() end}}
			}
}

options[30] = { 
	text = "Ride of into the sunset?",
	left = {
				text = "Yes",
				outcomes = {{text = "You peddle into the distance", func = function() fail(13) end}}
			},
	
	right = {
				text = "No",
				outcomes = {{text = "What am I even thinking", func = function() end}}
			}
}

-- cycle into traffic
local revealTimer = 0
local prevState = ""

function change_option(option)

	if(options[option]) then
		curOption = option
	end
	prevState = get_state()
	change_state("options")
	revealTimer = 0
end

local outcome = ""
local selected = ""
function options_mousepressed(x,y)
	local screen = {}
	screen.w, screen.h = screen_getDimensions()

	local option = options[curOption]
	if(state == "choose") then
		if(revealTimer > 1) then
			if(x > screen.w/2) then
				selected = "right"
				outcome = option.right.outcomes[1].text
				--option.right.outcomes[1].func()
			else
				outcome = option.left.outcomes[1].text
				--option.left.outcomes[1].func()
				selected = "left"
			end
			state = "done"
		else
			revealTimer = 1
		end
	else
		state = "choose"
		change_state("room")

		if(selected == "left") then
			option.left.outcomes[1].func()
		else	
			option.right.outcomes[1].func()
		end
	end
end



function options_update(dt)
	if(state == "choose") then
		if(revealTimer < 1) then
			revealTimer = revealTimer + dt
			if(revealTimer >= 1) then sfx_play(2) end
		else
			revealTimer = math.min(2, revealTimer + math.max(1,(2 - revealTimer) * 10) * dt)
		end
	else
		revealTimer = math.max(0,revealTimer - math.min(0.1, (revealTimer) * 10 * dt))
	end
end

local optW = 100
local optH = 40



function options_draw()
	local screen = {}
	screen.w, screen.h = screen_getDimensions()

	if(options[curOption]) then

		if(prevState == "room") then
			rooms_draw()
			love.graphics.setColor(0,0,0,155*math.min(1,revealTimer))
			love.graphics.rectangle("fill",0,0,screen.w,screen.h)
			love.graphics.setColor(255,255,255)
		end

		local option = options[curOption]
		if(state == "choose") then
			if(revealTimer > 1) then
				if(option.text) then
					cprint(option.text, screen.w/2, screen.h/2 - (revealTimer-1) * 80)
					local w = (screen.w-20) * (revealTimer-1)/1
					love.graphics.setColor(44,52,65)
					love.graphics.line(screen.w/2-w/2,screen.h/2 - (revealTimer-1) * 80+20,screen.w/2+w/2,screen.h/2 - (revealTimer-1) * 80+20)
					w = w - 2
					--love.graphics.line(screen.w/2-w/2,screen.h/2 - (revealTimer-1) * 80+20 + 1,screen.w/2+w/2,screen.h/2 - (revealTimer-1) * 80+20 + 1)
					--love.graphics.line(screen.w/2-w/2,screen.h/2 - (revealTimer-1) * 80+20 - 1,screen.w/2+w/2,screen.h/2 - (revealTimer-1) * 80+20 - 1)

					love.graphics.setColor(255,255,255)
				end
			else
				if(option.text) then
					love.graphics.setColor(255,255,255,255*revealTimer)
					cprint(option.text, screen.w/2, screen.h/2)
					love.graphics.setColor(255,255,255)
				end
			end	


			if(revealTimer >= 2) then
				love.graphics.setColor(44,52,65)
				
				--love.graphics.line(screen.w/2, 100, screen.w/2, screen.h - 20)

				love.graphics.setColor(255,255,255,100)

				local border = 10
				local mx, my = get_mouse()
				local dx = math.abs(screen.w*1/4 - mx)
				border = math.min(70,dx - 50)
				border = math.max(10, border)
				love.graphics.setColor(44,52,65)
				love.graphics.rectangle("line",border,screen.h/3 + border,screen.w/2 - border*2, screen.h*2/3 - border*2)
				love.graphics.setColor(44,52,65, math.min(150,100* 100/dx))
				love.graphics.rectangle("fill",border,screen.h/3 + border,screen.w/2 - border*2, screen.h*2/3 - border*2)
				local dx = math.abs(screen.w*3/4 - mx)
				border = math.min(70,dx - 50)
				border = math.max(10, border)
				love.graphics.setColor(44,52,65)
				love.graphics.rectangle("line",screen.w/2+border,screen.h/3 + border,screen.w/2 - border*2, screen.h*2/3 - border*2)
				love.graphics.setColor(44,52,65, math.min(150,100* 100/dx))
				love.graphics.rectangle("fill",screen.w/2+border,screen.h/3 + border,screen.w/2 - border*2, screen.h*2/3 - border*2)

				love.graphics.setColor(255,255,255)

				cprint(option.left.text,screen.w*1/4,screen.h*2/3)
				cprint(option.right.text,screen.w*(3/4),screen.h*2/3)

			end
		else
			love.graphics.setColor(255,255,255,255*(2-revealTimer)/2)
			cprint(outcome, screen.w/2, screen.h/2 + screen.h/2 * revealTimer/2)
			love.graphics.setColor(255,255,255)
		end
	end
end