local titlescreen = require "scripts/titlescreen"
local opening = require "scripts/opening_transition"

gamestate = {
	scene = opening
}

function love.load()
	love.window.setTitle("Road to AC")
	love.window.setMode(1280,720)
end

function love.update(dt)
	gamestate.scene:update(dt)
end

function love.draw()
	gamestate.scene:draw()
end

function love.keypressed(key, scancode, isrepeat)
	if gamestate.scene.keypressed then
		gamestate.scene:keypressed(key, scancode, isrepeat)
	end
end