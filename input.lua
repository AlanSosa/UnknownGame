local vector = require 'vector'

input = {}

function input:update()
end

function input:getMovementDirecion()
	local delta = vector(0,0)

	if love.keyboard.isDown('left') then
        delta.x = -1
    elseif love.keyboard.isDown('right') then
        delta.x =  1
    end

    if love.keyboard.isDown('up') then
        delta.y = -1
    elseif love.keyboard.isDown('down') then
        delta.y =  1
    end
     delta:normalizeInplace()
	return delta
end


function input:isShootButtonPressed()
    if love.keyboard.isDown('space') then
        return true
    else 
        return false
    end
end