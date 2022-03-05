local bruh = 0
local followchars = true;
local xx = 520.95;
local yy = 1700;
local xx2 = 1300.9;
local yy2 = 2100;
local ofs = 50;
local del = 0;
local del2 = 0;
local dadY = 0
local dadCarY = 0
local bfY = 0
local gfY = 0
local carY = 0
local speed = 1



function onCreate()
    speed = 240/getPropertyFromClass('ClientPrefs', 'framerate')
    for i = 1,2 do
        makeLuaSprite('sky' .. i, 'jenny/sky', -700 + (i-1) * (6208),350);
        scaleObject('sky' .. i, 4, 5)
        addLuaSprite('sky' .. i, false);
    end

    for i = 1,2 do
        makeLuaSprite('backbuildings' .. i, 'jenny/backbuildings', -700 + (i-1) * (12000),550);
        scaleObject('backbuildings' .. i, 4, 4)
        addLuaSprite('backbuildings' .. i, false);
    end

    --lazy code zzz
    for i = 1,3 do
        local a = 0
        if i == 2 then
            a = -1
        elseif i == 3 then
            a = 1
        end
        makeLuaSprite('buildings' .. i, 'jenny/buildings', -800 + (3000*2.4)*a,1250);
        scaleObject('buildings' .. i, 2.4, 2.7)
        addLuaSprite('buildings' .. i, false);
    end

    makeLuaSprite('car', 'jenny/car', 3200, 2500);
	addLuaSprite('car', false);

    makeLuaSprite('jennycar', 'jenny/jennycar', -100,1850);
    scaleObject('jennycar', 1.4, 1.4)
	addLuaSprite('jennycar', false);
end

function onSongStart()
    dadY = getProperty('dad.y')
    dadCarY = getProperty('jennycar.y')
    carY = getProperty('car.y')
    bfY = getProperty('boyfriend.y')
    gfY = getProperty('gf.y')

    runTimer('float', 1.1, 0)
end

function onStepHit()
    if curStep == 1 or curstep == 6 then
    end
end


function onUpdate(elapsed)


    for i = 1,3 do
        if getProperty('buildings' .. i .. '.x') > (3000*2.4 - 800) then
            setProperty('buildings'.. i .. '.x', getProperty('buildings' .. i .. '.x') - 3000*2.4*2)
        end
        setProperty('buildings'.. i .. '.x', getProperty('buildings' .. i .. '.x') + 4 * speed)
    end

    for i = 1,2 do
        if getProperty('backbuildings' .. i .. '.x') < (-12000 + 700) then
            setProperty('backbuildings'.. i .. '.x', getProperty('backbuildings' .. i .. '.x') + 12000*2)
        end
        if getProperty('sky' .. i .. '.x') < (-6208 + 700) then
            setProperty('sky'.. i .. '.x', getProperty('sky' .. i .. '.x') + 6208*2)
        end

        setProperty('backbuildings'.. i .. '.x', getProperty('backbuildings' .. i .. '.x') - 0.5/2 * speed)
        setProperty('sky'.. i .. '.x', getProperty('sky' .. i .. '.x') - 0.25/2 * speed)
    end
end

function onTimerCompleted(tag, loops, loopsLeft)
    if tag == 'float' then
        if bruh == 0 then
            doTweenY('floatSHIT1', 'dad', dadY - 150, 1, 'circInOut')
            doTweenY('floatSHIT2', 'jennycar', dadCarY - 150, 1, 'circInOut')

            doTweenY('floatSHIT5', 'boyfriend', bfY + 100, 1, 'linear')
            doTweenY('floatSHIT6', 'car', carY + 100, 1, 'linear')
            doTweenY('floatSHIT7', 'gf', gfY + 100, 1, 'linear')
            bruh = 1
        elseif bruh == 1 then
            doTweenY('floatSHIT3', 'dad', dadY + 150, 1, 'circInOut')
            doTweenY('floatSHIT4', 'jennycar', dadCarY + 150, 1, 'circInOut')

            doTweenY('floatSHIT8', 'boyfriend', bfY - 100, 1, 'linear')
            doTweenY('floatSHIT9', 'car', carY - 100, 1, 'linear')
            doTweenY('floatSHIT10', 'gf', gfY - 100, 1, 'linear')
            bruh = 0
        end
    end
end


