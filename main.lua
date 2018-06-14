require 'player'
require 'map'
local Camera = require 'Camera'

local SCROLL_SPEED = 62

-- an object to contain our map data
-- map = map:create(1,7)


-- push = require 'push'

-- close resolution to NES but 16:9
virtualWidth = 320
virtualHeight = 224

-- actual window resolution
windowWidth = 1280
windowHeight = 720

local cam = Camera( 
		200, 
		200, 
		{ x = 32, y = 32, resizable = true, maintainAspectRatio = true } 
		)

function love.load()
	player:load(WINDOW_WIDTH, WINDOW_HEIGHT)
	player.scrollSpeed = SCROLL_SPEED
	-- a speed to multiply delta time to scroll map; smooth value
	--map.scrollSpeed = SCROLL_SPEED 

	-- sets up virtual screen resolution for an authentic retro feel
    -- push:setupScreen(virtualWidth, virtualHeight, windowWidth, windowHeight, {
        --fullscreen = false,
        --resizable = true
    -- })
    -- Moves at the same speed as the main layer
	
	
end
close = cam:addLayer( 'close', 2, { relativeScale = .5 } )
far = cam:addLayer('far', .5)


function love.update(dt)
	-- map:update(dt)
	cam:translate(SCROLL_SPEED * dt , 0 )
	cam:update()
	player:update(dt)


	--player.bullets.update()
end

function love.draw()
	-- push:apply('start')
	-- map:render()
	
	cam:push()
		-- By default, translation is half camera width, half camera height
		-- So this draws a rectangle at the center of the screen.
		far:push()
			love.graphics.rectangle( 'fill', 100, 0, 64, 64 )
		far:pop()

		player:draw()
		for _,bullet in pairs(player.bullets) do
			bullet:draw()
		end

		cam:push( 'close' )
			love.graphics.rectangle( 'fill', 100, 0, 64, 64 )
		cam:pop( 'close' )

		
	cam:pop()
	-- love.graphics.setColor(255,255,255)	
	
	-- push:apply('end')
end