util = {
}
vector = require 'vector'

function util:fromPolar(angle, magnitude) 
	return magnitude * vector( math.cos(angle), math.sin(angle)) 
end

function util:clamp(low, n, high) 
	return math.min(math.max(low, n), high) 
end

--[[
    Stores utility functions used by our game engine.
]]

-- takes a texture, width, and height of tiles and splits it into quads
-- that can be individually drawn
function util:generateQuads(atlas, tilewidth, tileheight)
    local sheetWidth = atlas:getWidth() / tilewidth
    local sheetHeight = atlas:getHeight() / tileheight

    local sheetCounter = 1
    local quads = {}

    for y = 0, sheetHeight - 1 do
        for x = 0, sheetWidth - 1 do
            -- this quad represents a square cutout of our atlas that we can
            -- individually draw instead of the whole atlas
            quads[sheetCounter] =
                love.graphics.newQuad(x * tilewidth, y * tileheight, tilewidth,
                tileheight, atlas:getDimensions())
            sheetCounter = sheetCounter + 1
        end
    end

    return quads
end
