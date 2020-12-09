

local sfxs = {
	love.audio.newSource("sfx/click.ogg"),
	love.audio.newSource("sfx/swoosh.ogg"),
	love.audio.newSource("sfx/ohNo.ogg"),
	love.audio.newSource("sfx/goodJob.ogg"),
	love.audio.newSource("sfx/door.ogg"),
	love.audio.newSource("sfx/fired.ogg"),
	
}

local music1 = love.audio.newSource("sfx/music.wav")
local music2 = love.audio.newSource("sfx/music2.wav")
music1:setLooping(true)
music1:setVolume(0.1)
music2:setLooping(true)
music2:setVolume(0.1)
music1:play()

function music_control()
	local state = get_state()
	if(state == "work") then
		music1:stop()
		music2:play()
	else
		music2:stop()
		music1:play()
	end
end


function sfx_play(i)
	sfxs[i]:stop()
	sfxs[i]:play()
end