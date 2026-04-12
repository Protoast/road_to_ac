local gamescreen = {
	selected_button = 1,
	menuTheme = love.audio.newSource("music/menutheme.mp3", "stream"),
	titleImage = love.graphics.newImage("sprites/title.png"),
	titleText = love.graphics.newImage("sprites/titlename.png"),
	musicTimer = 0,
	buttonHoverSfx = love.audio.newSource("sfx/hover.wav", "static")
}

function gamescreen:updateMusic(dt)
	if self.musicTimer < 10 then
		self.musicTimer = self.musicTimer + dt
		self.menuTheme:setVolume(self.musicTimer/100)
	end
end

function Button(image, dx, dy, idn, selectable)
	local self = {
		img = image,
		x = dx,
		y = dy,
		id = idn,
		lside = dx-image:getWidth()/2,
		rside = dx+image:getWidth()/2,
		tside = dy-image:getHeight()/2,
		bside = dy+image:getHeight()/2,
		is_selected = false,
		is_selectable = selectable
	}

	function self:update()
		if not self.is_selectable then
			return
		end
		if not gamestate.scene == gamescreen then
			return
		end
		mx, my = love.mouse.getX(), love.mouse.getY()
		if (mx>self.lside and mx<self.rside and my>self.tside and my<self.bside) or gamescreen.selected_button == self.id then
			if gamescreen.selected_button ~= self.id then
				local sfx = love.audio.newSource("sfx/hover.wav", "static")
				sfx:play()
			end
			self.is_selected = true
			gamescreen.selected_button = self.id
			for i,v in ipairs(buttons) do
				if v.id ~= self.id then
					v.is_selected = false
				end
			end
		end
	end

	function self:draw()
		if not self.is_selected and self.is_selectable then
			love.graphics.setColor(255, 255, 255, .75)
		end

		love.graphics.draw(self.img, self.lside, self.tside)
		love.graphics.setColor(255, 255, 255, 1)
	end

	return self
end

local screenw, screenh = 1280, 720

local playbutton = love.graphics.newImage("sprites/Play-button.png")
local optbutton = love.graphics.newImage("sprites/Options_Button.png")
local exitbutton = love.graphics.newImage("sprites/Exit_Button.png")

buttons = {
	Button(playbutton, screenw/2-250, screenh/2+250, 1, true),
	Button(optbutton, screenw/2, screenh/2+250, 2, true),
	Button(exitbutton, screenw/2+250, screenh/2+250, 3, true),
}

function gamescreen:keypressed(key, scan, isrepeat)
	if key == "s" then
		self.selected_button = self.selected_button + 1
		local sfx = love.audio.newSource("sfx/hover.wav", "static")
		sfx:play()
	elseif key == "w"  then
		self.selected_button = self.selected_button - 1
		local sfx = love.audio.newSource("sfx/hover.wav", "static")
		sfx:play()
	end
end

function gamescreen:draw()
	love.graphics.setColor(255,255,255,.6)
	love.graphics.draw(self.titleImage)
	love.graphics.setColor(255,255,255,1)
	love.graphics.draw(self.titleText, screenw/2-self.titleText:getWidth()/2, screenh/2-self.titleText:getHeight()/2-250)
	for i,v in ipairs(buttons) do
		v:draw()
	end
	love.graphics.print(gamescreen.selected_button)
end

function gamescreen:update(dt)
	for i,v in ipairs(buttons) do
		v:update()
	end
	self:updateMusic(dt)
end

gamescreen.buttons = buttons

return gamescreen