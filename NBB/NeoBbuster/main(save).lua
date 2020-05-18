io.stdout:setvbuf("no")

--********************************************
--day job to do
--- clean the code and increase level gaming complication with pad and size and ball speed

local DisplayWidth, DisplayHeight
local Life = 5 
local InitialeLife = 5 
local Joker = 5
local InitialeJoker = 5
local InitialisationSpeedX = 400
local InitialisationSpeedY = 400
local PadCollisionFlag = false
local BriqueCollision = false
local Title = true
local Timer = 0
local GenericalTimer = false
local GenericalTimerCnt = 0

local Pad ={}
  Pad.x = 0
  Pad.y = 0
  Pad.initialwidth = 110
  Pad.width = Pad.initialwidth
  Pad.height = 15
  Pad.speed = 10
  Pad.sizeoffsetremove = 10
  Pad.speedoffset = 1
  Pad.widthoffset = 2
  
local Ball ={}
  Ball.x = 0
  Ball.y = 0
  Ball.radian = 13
  Ball.color = 0
  Ball.glue = false
  Ball.vx = 0
  Ball.vy = 0
  Ball.speedinc = 25
  Ball.orientation = 0

  
local Brique = {}
  Brique.numberwidth = 8
  Brique.numberheight = 6
  Brique.height = 0
  Brique.width = 0
  Brique.counter = 0
  
local Level_1 = {}

local BonusMalus = {}
  BonusMalus.hightspeedball = false
  BonusMalus.lowspeedball = false
  BonusMalus.upsizepad = false
  BonusMalus.lowsizepad = false
  BonusMalus.upspeedpad = false
  BonusMalus.lowspeedfactor = false
  BonusMalus.formula1factor = false
  BonusMalus.snailfactor = false
  
SoundPadResize = love.audio.newSource("audio/PadCollision.ogg", "stream")
SoundGameMusic = love.audio.newSource("audio/GameMusic.mp3", "stream")
SoundReducePad = love.audio.newSource("audio/Malus.mp3", "stream")
SoundUpPad = love.audio.newSource("audio/Bonus.mp3", "stream")
SoundSpeedBall = love.audio.newSource("audio/SpeedBall.mp3", "stream")
SoundBriqueCollision = love.audio.newSource("audio/BriqueCollision3.mp3", "stream")

ImageBall1 = love.graphics.newImage("image/Ball1.png")
ImageBall2 = love.graphics.newImage("image/Ball2.png")

ImageBrique1 = love.graphics.newImage("image/Brique1.png")
ImageBrique2 = love.graphics.newImage("image/Brique2.png")
ImageBrique3 = love.graphics.newImage("image/Brique3.png")





love.audio.play(SoundGameMusic)

--image a decaler dans le load pour changer le fond d ecran du niveau
  local GammePicture = "image/Earth.png"
  local image = love.graphics.newArrayImage(GammePicture)
  
  local SpriteChoc = {"sprites/Choc2.png", "sprites/Choc2.png", "sprites/Choc2.png", "sprites/Choc2.png", "sprites/Choc2.png", "sprites/Choc2.png"}
  SpriteChocBrique = love.graphics.newArrayImage(SpriteChoc)
    
  
  local TitleFont = love.graphics.newFont("font/Averus/Averus.ttf", 60)
  local UserActionRequestFont = love.graphics.newFont("font/Coolvetica/Coolvetica rg.ttf", 35)
  
  local PushSpaceObject = love.graphics.newText( UserActionRequestFont, " Push [space] ")
  
  local TitleChar = " Neo Stone Breaker "



function love.load()
  
  DisplayWidth = love.graphics.getWidth()
  DisplayHeight = love.graphics.getHeight()
  Pad.x = ( DisplayWidth / 2 ) - (Pad.width / 2)
  Pad.width = Pad.initialwidth
  Brique.height = (DisplayHeight / 3.5 ) / Brique.numberheight
  Brique.width = DisplayWidth / Brique.numberwidth
  Brique.counter = Brique.numberheight * Brique.numberwidth
  begin()
  
end

--dt is time between love.update
function love.update(dt)
  
    Pad.y = DisplayHeight - (Pad.height + 20)
    
    if love.keyboard.isDown("right") and Pad.x < ( DisplayWidth - Pad.width) then
      Pad.x = Pad.x + Pad.speed
    end
    
    if love.keyboard.isDown("left")and Pad.x > 0 then
      Pad.x = Pad.x - Pad.speed
    end
    
    --Joker touch to reduce ballspeed
    if love.keyboard.isDown("t") then
      --love.keyboard.setKeyRepeat( enable )
      --function love.keypressed(key, isrepeat)

      if Joker > 0 then
        
        Joker = Joker - 1
        
        if Ball.vx < 0 then
          Ball.vx = 0 - InitialisationSpeedX
        else 
          Ball.vx = InitialisationSpeedX
        end
        
        if Ball.vy < 0 then
          Ball.vy = 0 - InitialisationSpeedY
        else 
          Ball.vy = InitialisationSpeedY
        end
        
      end
    
    end
    
  
  if Ball.glue == true then
    Ball.x = Pad.x + Pad.width / 2
    Ball.y = DisplayHeight - Pad.height - (Ball. radian + 20)
  else
    Ball.x = Ball.x + (Ball.vx * dt)
    Ball.y = Ball.y + (Ball.vy * dt)
  end
  
  local X = math.floor(Ball.x / Brique.width) + 1
  local Y = math.floor(Ball.y / Brique.height) + 1
  
  --collision ball on brique and destruction
  if Y >= 1 and Y <= #Level_1 and X >= 1 and X <= Brique.width then
    if Level_1[Y][X] == 1 then
      --rajouter une condition pour l'acceleration de la balle en cas de rebomd entre differentes brique car dans un cas l 'acceleration est + et l autre -
      Ball.vy = 0 - Ball.vy 
      --drawing brique destruction
      Level_1[Y][X] = 0
      BriqueCollision = true
        
      --width pad malus on random brique x, y equal to rand num generated
      if Y == math.random(1,Brique.numberheight) or x == math.random(1,Brique.numberwidth) then
      
        --PadAnimationResising(Pad.width / 2)
        BriqueMalusBonus(Brique.numberheight, Brique.numberwidth, 0 )
      
      end
      
    end
  end
  
  --reverse ball touche right display screen
  if Ball.x > DisplayWidth then
    
    Ball.vx = 0 - Ball.vx
    Ball.x = DisplayWidth
  
  --reverse ball touch roof top wall of the display screen
  elseif Ball.y < 0 then
  
    Ball.vy = 0 - Ball.vy
    Ball.y = 0
    
  -- reverse ball touch wall left from display  
  elseif Ball.x < 0 then
    
    Ball.vx = 0 - Ball.vx
    Ball.x = 0
    
   --Ball miss down of the display end life
  elseif Ball.y > DisplayHeight then
    
      Ball.glue = true
      Pad.speed = 10
      Ball.speed = 10
      Life = Life - 1
      PadAnimationResising(Pad.initialwidth - ( (InitialeLife - Life) * Pad.sizeoffsetremove ))
    
  end
  
  --reverse ball collision  pad detection
  if Ball.x > Pad.x and Ball.x < (Pad.x + Pad.width) and Ball.y > Pad.y and Ball.y < Pad.y + Pad.height then
    
    PadCollisionFlag = true
    --gestion of ball speed accelerationduring pad contact with ball
    Ball.vy = 0 - Ball.vy - Ball.speedinc
    Pad.speed = Pad.speed + Pad.speedoffset
    PadAnimationResising( Pad.width + Pad.widthoffset)
    
      --incrementer un systeme de viser avec la ball proportionel a la taille de la raquete ou le mouvement du pad 
      if Ball.vx > 0 then
        
        Ball.vx = Ball.vx + Ball.speedinc 
         
        if Ball.x > (Pad.x + (Pad.width / 6)) and Ball.x < (Pad.x + ((Pad.width / 6) * 5)) then
        
          Ball.vx = Ball.vx + Ball.speedinc 


        --reverse ball bound for for external part pad collision
        elseif Ball.x <= (Pad.x + (Pad.width / 6))  then
          
          Ball.vx = 0 - Ball.vx - Ball.speedinc 
        

        end
        
      elseif Ball.vx < 0 then
        
        Ball.vx = Ball.vx - Ball.speedinc 
        
        if Ball.x > (Pad.x + (Pad.width / 6)) and Ball.x < (Pad.x + ((Pad.width / 6) * 5)) then
        
          Ball.vx = Ball.vx - Ball.speedinc 
        
        --reverse ball bound for for external part pad collision
        elseif Ball.x >= (Pad.x + ((Pad.width / 6)  * 5)) then
          
          Ball.vx = Ball.vx - (Ball.vx * 2) -  Ball.speedinc 

        end
      
      end
    
    end

  
end

function love.draw()
  
  --draw backscreen image game
   love.graphics.drawLayer(image, 1, 50, 50)
   
  
  --chek to replace it by graphic.text
  if Title == true then
    love.graphics.setFont(TitleFont)
    love.graphics.print( TitleChar, 98 , 50)
    UserPushSpace()

  else

    local X, Y 
    local Bx = 0 
    local By = 0
    
    --Drawinf of the mesh grill create in begin()
    for x = 1, Brique.numberheight do
      Bx = 0
        for y = 1, Brique.numberwidth do
          if Level_1[x][y] == 1 then
            -- + 1 / -1 incrementation for brique space betweem them 
            love.graphics.draw(ImageBrique3, Bx + 1 , By + 1,  Ball.orientation , 0.15, 0.055)
            
          end
          
          Bx = Bx + Brique.width
        end
        By = By + Brique.height
    end
    
    --Fill Square drawing att position x,y and size ,y, x 
    love.graphics.draw(ImageBrique3, Pad.x , Pad.y,  Ball.orientation , Pad.width* 0.0017, 0.04)
    love.graphics.draw(ImageBall2, Ball.x - 18 , Ball.y - 25,  Ball.orientation , 0.1, 0.1)
    
    
    --Pad collision sound
    if PadCollisionFlag == true then
      
      love.audio.play(SoundPadResize)
      PadCollisionFlag = false
      
    end
    
     --malus pad reduction sound
    if BonusMalus.lowsizepad == true  then
      
      love.audio.play(SoundReducePad)
      BonusMalus.lowsizepad = false
      
    end
    
      --bonus pad up sizesound
    if BonusMalus.upsizepad == true  then
      
      love.audio.play(SoundUpPad)
      BonusMalus.upsizepad = false
      
    end
    
    -- Up speed Ball
    if BonusMalus.hightspeedball == true  then
      
      love.audio.play(SoundSpeedBall)
      BonusMalus.hightspeedball = false
      
    end
    
    if BriqueCollision  == true  then
      
      love.audio.play(SoundBriqueCollision)
      BriqueCollision = false
      Brique.counter = Brique.counter - 1
      SpriteChoc()
      
    end
    
    -- End level
    if Brique.counter == 0 then

      love.graphics.print( " You Win!!", 250 , 50)
      UserPushSpace()

    end
    
    
    --To finish, bug to print on display
    if Life == 0 then
      love.graphics.print("YOU LOOSE", 700, 700)
    end
  end
end

function love.mousepressed(x, y, n)
  
  if Ball.glue == true then
    Ball.glue = false
    Ball.vx = InitialisationSpeedX 
    Ball.vy = 0 - InitialisationSpeedY
  end
  
end

function begin()
  
  Ball.glue = true
  
  Level_1 = {}
  
  local Y, X = 0, 0
  
  --Creation of the level mesh brique to create
  for Y = 1, Brique.numberheight do
    Level_1[Y] = {}
      for X = 1, Brique.numberwidth do
        Level_1[Y][X] = 1
      end
  end

end

function love.keypressed(key)
  
end

--Reduction function for pad modification
function PadAnimationResising(SizeExpected)
  
  if Pad.width > SizeExpected then
    
    while Pad.width > SizeExpected and Pad.width > 0 do
    
      Pad.width = Pad.width - 1
    
    end
  
  else
  
    while Pad.width < SizeExpected and Pad.width < DisplayWidth do
    
      Pad.width = Pad.width + 1
    
    end
    
  end
  
end

--Give bonus or malus at hazardous colision stones
function BriqueMalusBonus(XBrique, YBrique, GameLevel)
  
  local Rand = math.random(1, 7)
  local LowSpeedFactor = 0.8
  local UpSpeedFactor = 1.2

  if Rand == 1 then
    
    --Malus reduce pad size by 2
    BonusMalus.lowsizepad = true
    PadAnimationResising(Pad.width / 2)
      
  elseif Rand == 2 then
      
    --Upgrade pad width by two  
    BonusMalus.upsizepad = true
    PadAnimationResising(Pad.width * 2)
      
  elseif Rand == 3 then
    BonusMalus.hightspeedball = true
    FullSpeedUP(UpSpeedFactor + 0.2, UpSpeedFactor + 0.2 , UpSpeedFactor + 0.2)
      
  elseif Rand == 4 then
      
    Pad.speed = Pad.speed * UpSpeedFactor
  
  elseif Rand == 6 then
      
    Pad.speed = Pad.speed * LowSpeedFactor
    
  elseif Rand == 7 then

    FullSpeedUP(Ball.vx * 1.5, Ball.vx * 1.5 , Ball.vx * 1.5)
    Pad.width = DisplayWidth / 3
    
  elseif Rand == 8 then

    Life = Life + 1
  
  end
  
  
end

function love.keypressed(key, scancode, isrepeat)
   
   if key == "escape" then
      love.event.quit()
   end
   
   if key == "space" then
      Title = false
   end
   
   
end

--Wait user push space button
function UserPushSpace()
  
  Timer = Timer + 1
  
  if Timer <= 35 then
  
    love.graphics.draw(PushSpaceObject, 310, 500)
  
  elseif Timer > 70 then
    
    Timer = 0
    
  end
    
end

-- use to up or down ball and pad speed
function FullSpeedUP( Ballvx, BallVy, PadSpeed)
  
    Ball.vx = Ball.vx * BallVy
    Ball.vy = Ball.vy * BallVy
    Pad.speed = Pad.speed * PadSpeed

end

--Generic timer witch take cycle in input
function TimerOneSec(CycleToWait)

  GenericalTimerCnt =  GenericalTimerCnt + 1
  
  if GenericalTimerCnt == GenericalTimerCnt then
    
    GenericalTimer = true
    GenericalTimerCnt = 0
    
  else 
    
    GenericalTimer = false
    
  end

  
end

--Sprite for brique choc
function SpriteChoc()
  
   love.graphics.drawLayer(SpriteChocBrique, 1, 200, 200)
   love.graphics.drawLayer(SpriteChocBrique, 2, 200, 200)
   love.graphics.drawLayer(SpriteChocBrique, 3, 200, 200)
   love.graphics.drawLayer(SpriteChocBrique, 4, 200, 200)
   love.graphics.drawLayer(SpriteChocBrique, 5, 200, 200)
   love.graphics.drawLayer(SpriteChocBrique, 6, 200, 200)

end