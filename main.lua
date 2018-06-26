require 'player'
require 'map'
local Camera = require 'Camera'

local SCROLL_SPEED = 62
local vector = require "vector"

-- an object to contain our map data
map = map:create(1,7)


push = require 'push'

-- close resolution to NES but 16:9
virtualWidth = 320
virtualHeight = 224

-- actual window resolution
windowWidth = 1280
windowHeight = 720

local cam = Camera( 
		272, 
		160, 
		{ x = 8, y = 8, resizable = true, maintainAspectRatio = true } 
		)

function love.load()

	texture_01 = love.graphics.newImage('images/background-01-01.png')
	textureForeGround = love.graphics.newImage('images/background-01-07.png')
	foregroundPosition = vector( - textureForeGround:getWidth() / 2,   - textureForeGround:getHeight() / 2 )
	player:load(1000000, 1000000)
	player.scrollSpeed = SCROLL_SPEED
	-- a speed to multiply delta time to scroll map; smooth value
	map.scrollSpeed = SCROLL_SPEED 

	-- sets up virtual screen resolution for an authentic retro feel
    -- push:setupScreen(virtualWidth, virtualHeight, windowWidth, windowHeight, {
        --fullscreen = false,
       --resizable = true
    -- })
    -- Moves at the same speed as the main layer
    layer_background = cam:addLayer('background', 1 , {relativeScale = 0} )
	layer_foreground = cam:addLayer('foreground', 1 , {relativeScale = .5} )
	far = cam:addLayer('far', 0)
end

function love.update(dt)
	--map:update(dt)
	cam:translate(SCROLL_SPEED * dt , 0 )
	cam:update()
	player:update(dt)

	foregroundPosition.x = cam:getScreenCoordinates(- textureForeGround:getWidth() / 2,   - textureForeGround:getHeight() / 2 )
	--cameraPosition = cam:getWorldCoordinates(player.position.x,  player.position.y)
	--print("Close cam " .. close.scale)
	--player.bullets.update()
end

function love.draw()
	 
	cam:push()
		-- By default, translation is half camera width, half camera height
		-- So this draws a rectangle at the center of the screen.
		layer_background:push()
			love.graphics.draw(texture_01, - texture_01:getWidth() / 2, - texture_01:getHeight() / 2 )
		layer_background:pop()

		far:push()
			--push:apply('start')
			love.graphics.rectangle( 'fill', 0, 0, 64, 64 )
			--position= position+1	 		--map:render()
	 	    --push:apply('end')
		far:pop()
		
		player:draw()
		
		for _,bullet in pairs(player.bullets) do
			bullet:draw()
		end

		cam:push( 'foreground' )
		    love.graphics.draw(textureForeGround, - textureForeGround:getWidth() / 2,   - ( (textureForeGround:getHeight() / 2 )) )
			--love.graphics.setColor(255,0,0)
			--love.graphics.rectangle( 'fill', 100, -60, 64, 200 )
			--love.graphics.setColor(255,255,255)
		cam:pop( 'foreground' )
	cam:pop()
	-- love.graphics.setColor(255,255,255)	
	
	
end