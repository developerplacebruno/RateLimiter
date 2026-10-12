--!strict
local Players = game:GetService("Players")

local RateLimiter = {}
RateLimiter.__index = RateLimiter

function RateLimiter.new(cooldown: number?)
	local self = setmetatable({}, RateLimiter)
	self.cooldown = cooldown or 0.1
	self.lastCheck = {}

	Players.PlayerRemoving:Connect(function(player)
		self.lastCheck[player] = nil
	end)

	return self
end

function RateLimiter:check(player)
	local currentTime = tick()
	local lastTime = self.lastCheck[player] or 0

	if currentTime - lastTime <= self.cooldown then
		return false
	end

	self.lastCheck[player] = currentTime
	return true
end

return RateLimiter
