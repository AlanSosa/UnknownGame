local vector = require "vector"
require 'input'
require 'bullet'
require 'util'

player = {
}

function player:load(wWidth, wHeight)
	self.TEXTURE = love.graphics.newImage('images/player_dummy.png')
	self.position = vector(0,0)
	self.velocity = vector(0,0)
	self.coolDown = 3
	self.bullets = {}
	self.SPEED = 250
	self.isDead = false
	self.size = vector( 1,1 )
	self.orientation = vector(1,0):angleTo()
	self.limitXA = 0
	self.limitXB = wWidth
	self.limitYA = 0
	self.limitYB = wHeight
end

bulletsCount = 0

function player:update(dt)
	self.velocity = input:getMovementDirecion() * self.SPEED
	self.aim = input:getMovementDirecion()
	--self.orientation = input:getMovementDirecion():angleTo()
	self.position = self.position + self.velocity * dt 
	-- scroll the ship
	self.position.x = self.position.x + dt * self.scrollSpeed

	if self.coolDown <= 0 and input:isShootButtonPressed() then
		self:shoot()
	end

	if self.coolDown >= 0 then
		self.coolDown = self.coolDown - 1
	end

	for i,b in ipairs(self.bullets) do
		if b.position.x > self.limitXB then
			table.remove(self.bullets,i)
		end	
		b:update(dt)
	end
	
	--self.limitXA = self.limitXA + dt * self.scrollSpeed
	--self.limitXB = self.limitXB + dt * self.scrollSpeed

	--self.limitYA = self.limitYA + dt * self.scrollSpeed
	--self.limitYB = self.limitYB + dt * self.scrollSpeed

	--self.position.x = util:clamp(self.limitXA, self.position.x, self.limitXB - self.TEXTURE:getWidth())
	--self.position.y = util:clamp(0, self.position.y, 480 - self.TEXTURE:getHeight())

	--print("x : " .. self.position.x)
	--print("y : " .. self.position.y)
	
end

function player:draw()
	--love.graphics.draw(self.TEXTURE, self.position.x,self.position.y)
	love.graphics.draw(self.TEXTURE, self.position.x, self.position.y, self.orientation, self.size.x, self.size.y)
end

function player:kill()
end

function player:shoot()
	self.coolDown = 3,
	table.insert(player.bullets, bullet:create())
end