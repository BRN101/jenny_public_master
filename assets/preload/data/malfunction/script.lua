local virus = 0
local idk = 0
local virus0 = true
local x = {}
local y = {}
local direct = 1
local normal = true

function onCreate()
    setPropertyFromClass('GameOverSubstate', 'characterName', 'j_bf');
    setPropertyFromClass('GameOverSubstate', 'deathSoundName', 'fnf_loss_sfx');
    setPropertyFromClass('GameOverSubstate', 'loopSoundName', 'gameOver');
    setPropertyFromClass('GameOverSubstate', 'endSoundName', 'gameOverEnd');
    for i = 2,1,-1 do
        if downscroll then
            makeLuaSprite('combo' .. i, 'fx/combo' .. i, 100, 100);
        else
            makeLuaSprite('combo' .. i, 'fx/combo' .. i, 100, 510);
        end
        setObjectCamera('combo' .. i, 'camHud');
        scaleObject('combo' .. i, 2, 1/2)
        addLuaSprite('combo' .. i, false);
    end
    makeAnimatedLuaSprite('static', 'fx/static', 0, 0)
    addAnimationByPrefix('static', 'idle', 'idle', 24, true)
    setObjectCamera('static', 'camHud')
    scaleObject('static', 1280/498, 720/376)
    setProperty('static.alpha', 0)
    addLuaSprite('static', true)
end

function onUpdate(elapsed)
    if downscroll then
        setProperty('combo2.y', 250 - 150*(virus/100))
    else
        setProperty('combo2.y', 660 - 150*(virus/100))
    end
    scaleObject('combo2', 2, 0.5*(virus/100))
end

function onStepHit()
    if virus > 0 then
        virus = virus - 0.5 / 2
    end
    if virus < 1 and normal == false then
        goback()
    end
end

function onSongStart()
    objectPlayAnimation('static', 'idle', true)
    for i = 0,7 do
        local xA = getPropertyFromGroup('strumLineNotes', i, 'x')
        local yB = getPropertyFromGroup('strumLineNotes', i, 'y')
        x[i] = xA
        y[i] = yB
    end
    if downscroll then
        direct = direct * -1
    end
end

function goback()
    for i = 0,7 do
        noteTweenX(i..'back2', i, x[i], 0.8, 'circInOut')
        noteTweenY(i..'back3', i, y[i], 0.8, 'circInOut')
        noteTweenAngle(i..'back4', i, 0, 0.8, 'circInOut')
    end
    normal = true
end

function goodNoteHit(id, direction, noteType, isSustainNote)
    if noteType == 'Glitch' then
        scramble()
        staticThing()
        if virus >=75 then
            virus = 100
        else
            virus = virus + 25
        end
        normal = false
    end
end

function scramble()
    local directionals = {0, -100, 100, 0}
    local directionals2 = {-110, -20, 20, 110}
    local rndmX = 0
    for i = 4,7 do
        if i == 4 then
            rndmX = getRandomInt(-80, 0)
        elseif i == 5 then
            rndmX = getRandomInt(-50, 50)
        elseif i == 6 then
            rndmX = getRandomInt(-50, 50)
        else
            rndmX = getRandomInt(0, 80)
        end
        local rndmY = getRandomInt(-20, 160) * direct
        setPropertyFromGroup('strumLineNotes', i, 'y', y[i] + rndmY)
        setPropertyFromGroup('strumLineNotes', i, 'x', x[i] - 100 + rndmX)

        --opponent part

        setPropertyFromGroup('strumLineNotes', (i-4), 'y', y[i] + directionals[i-3] + rndmY)
        setPropertyFromGroup('strumLineNotes', (i-4), 'x', x[i] - 100 + directionals2[i-3] + rndmX)


        setPropertyFromGroup('strumLineNotes', (i-4), 'alpha', getRandomFloat(0.1,0.3))
        setPropertyFromGroup('strumLineNotes', (i-4), 'angle', getRandomFloat(0,360))
    end
    normal = false
end


function staticThing()
    cancelTween('staticAlphaThing')
    setProperty('static.alpha', 0.75)
    doTweenAlpha('staticAlphaThing', 'static', 0, 1, 'circInOut')
end


function opponentNoteHit(id, direction, noteType, isSustainNote)
	if getProperty('health') > 0.40 and virus > 0 then
        setProperty('health', getProperty('health')- 0.035*(0.75 + (virus/100)))
    end
end

--credits to @letteryusef on twitter for the 13 lines of code below, tysm <3!

function onCreatePost()
    triggerEvent('Set GF Speed', 30)
    setProperty('cameraSpeed', 2.2)
    setProperty('boyfriend.color', getColorFromHex('7E98C6'))
    setProperty('gf.color', getColorFromHex('7E98C6'))
end

function onBeatHit()
    if curBeat == 12 then
        triggerEvent('Set GF Speed', 1) 
    end
end