function love.load()
    imagedata = love.image.newImageData("pig.png")
    image = love.graphics.newImage(imagedata)
end
 
function love.draw()
    love.graphics.draw(image)
end
 
function love.keypressed(key)
    if key == "e" then
        -- Modify the original ImageData and apply the changes to the Image.
        imagedata:mapPixel(function(x, y, r, g, b, a) return r/2, g/2, b/2, a/2 end)
        image:replacePixels(imagedata)
    end
end