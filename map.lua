--[[
    Contains tile data and necessary code for rendering a tile map to the
    screen.
]]

require 'util'

-- object-oriented boilerplate; establish Map's "prototype"
map = {}
map.__index = map

-- constructor for our map object
function map:create(TILE_BRICK, TILE_EMPTY)
    local this = {
        -- our texture containing all sprites

        spritesheet = love.graphics.newImage('images/tile-sheet.png'),
        tileWidth = 32, -- Tile width measured in pixels
        tileHeight = 32, -- Tile height measured in pixels
        mapWidth = 5000, -- Map width measured in tiles
        mapHeight = 9, -- Map height measured in tiles
        tiles = {}, 

        -- camera offsets
        camX = 0,
        camY = 0 -- -3
    }

    this.TILE_BRICK = TILE_BRICK;
    this.TILE_EMPTY = TILE_EMPTY;
    -- generate a quad (individual frame/sprite for each title)
    this.tileSprites = util:generateQuads(this.spritesheet, 32, 32);

    -- generate a quad (individual frame/sprite) for each tile
    this.tileSprites = util:generateQuads(this.spritesheet, 32, 32)

    -- cache width and height of map in pixels
    this.mapWidthPixels = this.mapWidth * this.tileWidth
    this.mapHeightPixels = this.mapHeight * this.tileHeight

    -- sprite batch for efficient tile rendering
    this.spriteBatch = love.graphics.newSpriteBatch(this.spritesheet, this.mapWidth *
        this.mapHeight)

    -- more OO boilerplate so we have access to class functions
    setmetatable(this, self)

    -- first, fill map with empty tiles
    for y = 1, this.mapHeight do
        for x = 1, this.mapWidth do
            this:setTile(x, y, TILE_EMPTY)
        end
    end

    -- -- fill bottom half of map with tiles
    for y = this.mapHeight / 2, this.mapHeight do
        for x = 1, this.mapWidth do
            this:setTile(x, y, TILE_BRICK)
        end
    end

    -- create sprite batch from tile quads
    print ("Drawing Map")
    for y = 1, this.mapHeight do
        for x = 1, this.mapWidth do
            print (this:getTile(x,y) .. " : " .. (x - 1) * this.tileWidth .. " , " .. (y - 1) * this.tileHeight)
            this.spriteBatch:add(this.tileSprites[this:getTile(x, y)],
                (x - 1) * this.tileWidth, (y - 1) * this.tileHeight)
        end
    end

    return this
end

-- function to update camera offset with delta time
function map:update(dt)
    self.camX = self.camX + dt * self.scrollSpeed
end

-- returns an integer value for the tile at a given x-y coordinate
function map:getTile(x, y)
    --print( "Get : " .. (y - 1) * self.mapWidth + x)
    return self.tiles[(y - 1) * self.mapWidth + x]
end

-- sets a tile at a given x-y coordinate to an integer value
function map:setTile(x, y, tile)
    print( tile .. " : " .. (y - 1) * self.mapWidth + x )
    self.tiles[(y - 1) * self.mapWidth + x] = tile
end

-- renders our map to the screen, to be called by main's render
function map:render()
    love.graphics.translate(math.floor(-map.camX + 0.5), math.floor(-map.camY + 0.5))
    -- replace tile-by-tile rendering with spriteBatch draw call
    love.graphics.draw(self.spriteBatch)
end
