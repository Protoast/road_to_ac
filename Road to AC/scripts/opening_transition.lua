local gamescreen = {}
local screenw, screenh = 1280, 720

local titlescreen = require "scripts/titlescreen"
local opacity = -1
local titleopacity = -.2
local musicTimer = 0

titlescreen.menuTheme:setVolume(0)
titlescreen.menuTheme:play()

function gamescreen:draw()
	love.graphics.setColor(255,255,255,titleopacity)
	love.graphics.draw(titlescreen.titleImage)
	love.graphics.setColor(255,255,255,titleopacity*1.8)
	love.graphics.draw(titlescreen.titleText, screenw/2-titlescreen.titleText:getWidth()/2, screenh/2-titlescreen.titleText:getHeight()/2-250)
	love.graphics.setColor(255,255,255,1)
	for i,v in ipairs(titlescreen.buttons) do
		local alpha = opacity-v.id
		if alpha<0 then
			break
		else
			if alpha>(.75) then
				alpha = .75
			end
			love.graphics.setColor(255,255,255,alpha)
			love.graphics.draw(v.img, v.lside, v.tside)
			love.graphics.setColor(255,255,255,1)
		end
	end
	if opacity>#buttons+1 then
		gamestate.scene = titlescreen
	end
end

function gamescreen:update(dt)
	opacity = opacity + dt*2
	if titleopacity < (.6) then
		titleopacity = titleopacity + dt/2
	end
	titlescreen:updateMusic(dt)
end

return gamescreen