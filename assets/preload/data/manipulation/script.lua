local a = 0
local modchart = false
local x = {}
local dadY = 0
local bfY = 0
local y = {}
local allowCountdown = false

local followchars = true;
local xx = 520.95;
local yy = 2100;
local xx2 = 1300.9;
local yy2 = 2100;
local ofs = 50;
local del = 0;
local del2 = 0;

function onCreate()
	setPropertyFromClass('GameOverSubstate', 'characterName', 'j_bf'); --Character json file for the death animation
	setPropertyFromClass('GameOverSubstate', 'deathSoundName', 'fnf_loss_sfx'); --put in mods/sounds/
	setPropertyFromClass('GameOverSubstate', 'loopSoundName', 'gameOver'); --put in mods/music/
	setPropertyFromClass('GameOverSubstate', 'endSoundName', 'gameOverEnd'); --put in mods/music/
end

function onUpdate(elapsed)
	a = a + 1/200
	yy = getProperty('dad.y') + 200
	yy2 = getProperty('boyfriend.y') + 100
	if followchars == true then
		if mustHitSection == false then
		  setProperty('defaultCamZoom',0.7)
		  if getProperty('dad.animation.curAnim.name') == 'singLEFT' then
			triggerEvent('Camera Follow Pos',xx-(ofs*2.5),yy)
		  end
		  if getProperty('dad.animation.curAnim.name') == 'singRIGHT' then
			triggerEvent('Camera Follow Pos',xx+(ofs*2.5),yy)
		  end
		  if getProperty('dad.animation.curAnim.name') == 'singUP' then
			triggerEvent('Camera Follow Pos',xx,yy-ofs)
		  end
		  if getProperty('dad.animation.curAnim.name') == 'singDOWN' then
			triggerEvent('Camera Follow Pos',xx,yy+ofs)
		  end
		  if getProperty('dad.animation.curAnim.name') == 'singLEFT-alt' then
			triggerEvent('Camera Follow Pos',xx-ofs,yy)
		  end
		  if getProperty('dad.animation.curAnim.name') == 'singRIGHT-alt' then
			triggerEvent('Camera Follow Pos',xx+ofs,yy)
		  end
		  if getProperty('dad.animation.curAnim.name') == 'singUP-alt' then
			triggerEvent('Camera Follow Pos',xx,yy-ofs)
		  end
		  if getProperty('dad.animation.curAnim.name') == 'singDOWN-alt' then
			triggerEvent('Camera Follow Pos',xx,yy+ofs)
		  end
		  if getProperty('dad.animation.curAnim.name') == 'idle-alt' then
			triggerEvent('Camera Follow Pos',xx,yy)
		  end
		  if getProperty('dad.animation.curAnim.name') == 'idle' then
			triggerEvent('Camera Follow Pos',xx,yy)
		  end
		else
		  setProperty('defaultCamZoom',0.6)
		  if getProperty('boyfriend.animation.curAnim.name') == 'singLEFT' then
			triggerEvent('Camera Follow Pos',xx2-(ofs*2.5),yy2)
		  end
		  if getProperty('boyfriend.animation.curAnim.name') == 'singRIGHT' then
			triggerEvent('Camera Follow Pos',xx2+(ofs*2.5),yy2)
		  end
		  if getProperty('boyfriend.animation.curAnim.name') == 'singUP' then
			triggerEvent('Camera Follow Pos',xx2,yy2-ofs)
		  end
		  if getProperty('boyfriend.animation.curAnim.name') == 'singDOWN' then
			triggerEvent('Camera Follow Pos',xx2,yy2+ofs)
		  end
		  if getProperty('boyfriend.animation.curAnim.name') == 'idle-alt' then
			triggerEvent('Camera Follow Pos',xx2,yy2)
		  end
		  if getProperty('boyfriend.animation.curAnim.name') == 'idle' then
			triggerEvent('Camera Follow Pos',xx2,yy2)
		  end
		end
	else
		triggerEvent('Camera Follow Pos','','')
	end
--[[
	for i = 0, getProperty('unspawnNotes.length')-1 do
		setPropertyFromGroup('notes', i, 'multAlpha', 1 * math.sin(a));
	end
	]]
end

function onGameOver()
	modchart = false
    return Function_Continue;
end

function onSongStart()
	dadY = getProperty('dad.y')
	bfY = getProperty('boyfriend.y')
	for i = 0,7 do
		local xA = getPropertyFromGroup('strumLineNotes', i, 'x')
		local yB = getPropertyFromGroup('strumLineNotes', i, 'y')
		x[i] = xA
		y[i] = yB
	end
	doTweenY('floatDAD1', 'dad', dadY + 100, 1.1, 'circInOut')
	doTweenY('floatBF1', 'boyfriend', bfY - 70, 0.8, 'circInOut')
end

function onTweenCompleted(tag)
	if tag == 'floatDAD1' then
		doTweenY('floatDAD2', 'dad', dadY - 100, 1.1, 'circInOut')
	elseif tag == 'floatDAD2' then
		doTweenY('floatDAD1', 'dad', dadY + 100, 1.1, 'circInOut')
	end
	if tag == 'floatBF1' then
		doTweenY('floatBF2', 'boyfriend', bfY + 70, 0.8, 'circInOut')
	elseif tag == 'floatBF2' then
		doTweenY('floatBF1', 'boyfriend', bfY - 70, 0.8, 'circInOut')
	end
end

function onStartCountdown()
	if not allowCountdown and isStoryMode and not seenCutscene then
		setProperty('inCutscene', true);
		runTimer('startDialogue', 0.8);
		allowCountdown = true;
		return Function_Stop;
	end
	return Function_Continue;
end

function onTimerCompleted(tag, loops, loopsLeft)
	if tag == 'startDialogue' then
		startDialogue('dialogue3');
	end
end