img = love.graphics.newImage("Choc2.png")
 
-- Let's say we want to display only the top-left 
-- 32x32 quadrant of the Image:
top_left = love.graphics.newQuad(0, 0, 120, 120, img:getDimensions())
 
-- And here is bottom left:
bottom_left = love.graphics.newQuad(0, 120, 120, 120, img:getDimensions())
 
function love.draw()
	love.graphics.draw(img, top_left, 50, 50)
	--love.graphics.draw(img, bottom_left, 50, 50)
	-- v0.8:
	-- love.graphics.drawq(img, top_left, 50, 50)
	-- love.graphics.drawq(img, bottom_left, 50, 200)
end