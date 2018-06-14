bullet = {}
bullet.__index = bullet

local vector = require 'vector'
require 'util'

function bullet:create()
	local this = {
		TEXTURE = love.graphics.newImage('images/bullet_dummy.png'),
		position = vector(player.position.x + 17 , player.position.y + 10),
		velocity = vector (0,0),
		orientation = vector(0,0):angleTo(),
		SPEED = 1400
	}
	this.size = vector (1,1)
	setmetatable(this,self)
	return this
end

function bullet:update(dt)

	--Creates a Cool rocket effect
	--SPEED = 1.5
	--self.velocity = self.velocity * self.SPEED
	--self.position = self.position + self.velocity * dt
	
	--Without converting the orientation to polar Coordenates
	--self.position = self.position + self.velocity * self.SPEED * dt

	self.velocity = util:fromPolar( self.orientation, self.SPEED )
	self.position = self.position + self.velocity * dt
end


function bullet:draw()
	love.graphics.draw(self.TEXTURE, self.position.x, self.position.y, self.orientation, self.size.x, self.size.y)
	--love.graphics.draw(self.TEXTURE, self.position.x,self.position.y)
	--love.graphics.rectangle("fill",self.position.x , self.position.y, 15, 5)
end
