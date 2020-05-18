io.stdout:setvbuf("no")

--********************************************
--day job to do
--- clean the code and increase level gaming complication with pad and size and ball speed

--Local Data
local DisplayWidth, DisplayHeight
local Life = 0
local InitialeLife = 5 
local InitialeJoker = 5
local InitialisationSpeedX = 400
local InitialisationSpeedY = 400
local PadCollisionFlag = false
local BriqueCollision = false
local BriqueIndestructibleCollision = false
local Title = true
local Timer = 0
local GenericalTimer = false
local GenericalTimerCnt = 0
local Level = 1
local CreditButton = false

--Array
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
  
  
local Animation = {}
  Animation.time = 0
  Animation.briquecollisionframe = 1
  Animation.briquecollisiontrigger = false
  
  
local LevelActiv = {}

local BonusMalus = {}
  BonusMalus.hightspeedball = false
  BonusMalus.lowspeedball = false
  BonusMalus.upsizepad = false
  BonusMalus.lowsizepad = false
  BonusMalus.upspeedpad = false
  BonusMalus.lowspeedfactor = false
  BonusMalus.formula1factor = false
  BonusMalus.snailfactor = false
  
--Image
ImageBall2 = love.graphics.newImage("image/Ball2.png")
ImageBrique = love.graphics.newImage("image/Brique4.png")
ImageBriqueIndestructible = love.graphics.newImage("image/Brique5.png")
local GammePicture = "image/Earth.png"
local image = love.graphics.newArrayImage(GammePicture)
local LogoFttm = love.graphics.newImage("logo/logofttm.png")



--Audio declaration
SoundPadResize = love.audio.newSource("audio/PadCollision.ogg", "static")
SoundGameMusic = love.audio.newSource("audio/GameMusic.mp3", "stream")
SoundReducePad = love.audio.newSource("audio/Malus.mp3", "static")
SoundUpPad = love.audio.newSource("audio/Bonus.mp3", "static")
SoundSpeedBall = love.audio.newSource("audio/SpeedBall.mp3", "static")
SoundBriqueCollision = love.audio.newSource("audio/BriqueCollision3.mp3", "static")
SoundBriqueIndestructible1 = love.audio.newSource("audio/BriqueIndestructible1.mp3", "static")
SoundBriqueIndestructible2 = love.audio.newSource("audio/BriqueIndestructible2.mp3", "static")
SoundWarningOneLife = love.audio.newSource("audio/EndLife2.mp3", "static")

--Audio parametring interface
SoundWarningOneLife:setVolume(0.4)

--GameMusique
--love.audio.play(SoundGameMusic)
--SoundGameMusic:setLooping(true)


--Font and text definition
  local TitleFont = love.graphics.newFont("font/Averus/Averus.ttf", 60)
  local UserActionRequestFont = love.graphics.newFont("font/Coolvetica/Coolvetica rg.ttf", 35)
  local InformationFont = love.graphics.newFont("font/Coolvetica/Coolvetica rg.ttf", 70)
  local InterfaceFont = love.graphics.newFont("font/Coolvetica/Coolvetica rg.ttf", 25)
  
--font parametring
love.graphics.setFont(InterfaceFont)
  
--Object text
  local PushSpaceObject = love.graphics.newText( UserActionRequestFont, " Push [space] " )
  local YouLooseObject = love.graphics.newText( InformationFont, "DUDE, YOU LOOSE!! " )
  local TitleChar = love.graphics.newText( TitleFont, " Neo Stone Breaker " )
  local YouWinObject = love.graphics.newText( InformationFont," You Win!!")
  
--Sprites
--Ball on brique collision sprite
  local SpriteChocBallBric = love.graphics.newImage("sprites/Choc2.png")
  local SpritChocBallCut = {}
  SpritChocBallCut[1] = love.graphics.newQuad( 120 * 0  , 120 * 0 , 120, 120, SpriteChocBallBric:getDimensions())
  SpritChocBallCut[2] = love.graphics.newQuad( 120 * 1  , 120 * 0 , 120, 120, SpriteChocBallBric:getDimensions())
  SpritChocBallCut[3] = love.graphics.newQuad( 120 * 2  , 120 * 0 , 120, 120, SpriteChocBallBric:getDimensions())
  SpritChocBallCut[4] = love.graphics.newQuad( 120 * 0  , 120 * 1 , 120, 120, SpriteChocBallBric:getDimensions())
  SpritChocBallCut[5] = love.graphics.newQuad( 120 * 1  , 120 * 1 , 120, 120, SpriteChocBallBric:getDimensions())
  SpritChocBallCut[6] = love.graphics.newQuad( 120 * 2  , 120 * 1 , 120, 120, SpriteChocBallBric:getDimensions())
  SpritChocBallCut[7] = love.graphics.newQuad( 120 * 0  , 120 * 2 , 120, 120, SpriteChocBallBric:getDimensions())
  SpritChocBallCut[8] = love.graphics.newQuad( 120 * 1  , 120 * 2 , 120, 120, SpriteChocBallBric:getDimensions())
  SpritChocBallCut[9] = love.graphics.newQuad( 120 * 2  , 120 * 2 , 120, 120, SpriteChocBallBric:getDimensions())
  SpritChocBallCut[10] = love.graphics.newQuad( 120 * 0  , 120 * 3 , 120, 120, SpriteChocBallBric:getDimensions())
  SpritChocBallCut[11] = love.graphics.newQuad( 120 * 1  , 120 * 3 , 120, 120, SpriteChocBallBric:getDimensions())
  SpritChocBallCut[12] = love.graphics.newQuad( 120 * 2  , 120 * 3 , 120, 120, SpriteChocBallBric:getDimensions())


--Load function
function love.load()
  
  if Life < 5 then
      Life = InitialeLife
  end
  
  DisplayWidth = love.graphics.getWidth()
  DisplayHeight = love.graphics.getHeight()
  Pad.x = ( DisplayWidth / 2 ) - (Pad.width / 2)
  Pad.width = Pad.initialwidth
  Brique.height = (DisplayHeight / 3.5 ) / Brique.numberheight
  Brique.width = DisplayWidth / Brique.numberwidth
  Brique.counter = Brique.numberheight * Brique.numberwidth
  LevelSelection()
  
end

--dt is time between love.update
function love.update(dt)
  
  if Life > 0 then
  --animation brique collision explosion
    Animation.time = Animation.time + ( 50 * dt )
    Animation.briquecollisionframe = math.ceil(Animation.time)
    
    if Animation.briquecollisionframe == 12 then
      
      Animation.briquecollisionframe = 1
      Animation.time = 0
      
    end
  
    Pad.y = DisplayHeight - (Pad.height + 20)
    
    if love.keyboard.isDown("right") and Pad.x < ( DisplayWidth - Pad.width) then
      Pad.x = Pad.x + Pad.speed
    end
    
    if love.keyboard.isDown("left")and Pad.x > 0 then
      Pad.x = Pad.x - Pad.speed
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
    if Y >= 1 and Y <= #LevelActiv and X >= 1 and X <= Brique.width then
      if LevelActiv[Y][X] == 1 then
        --rajouter une condition pour l'acceleration de la balle en cas de rebomd entre differentes brique car dans un cas l 'acceleration est + et l autre -
        Ball.vy = 0 - Ball.vy 
        --drawing brique destruction
        LevelActiv[Y][X] = 0
        BriqueCollision = true
    
        --width pad malus on random brique x, y equal to rand num generated
        if Y == math.random(1,Brique.numberheight) or x == math.random(1,Brique.numberwidth) then
        
          BriqueMalusBonus(Brique.numberheight, Brique.numberwidth, 0 )
        
        end
          
        --indestructible brique collision
      elseif LevelActiv[Y][X] == 2 then
          
        Ball.vy = 0 - Ball.vy 
        BriqueIndestructibleCollision = true
        
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

  
end

function love.draw()
  
  --draw backscreen image game
   love.graphics.drawLayer(image, 1, 50, 50)
   
  
  --chek to replace it by graphic.text
  if Title == true then
    love.graphics.draw(TitleChar, 81 , 50)
    UserPushSpace()
    
    --Drawing credit for intellectual property
    if love.keyboard.isDown("e") then
      
      love.graphics.draw(LogoFttm, 50 , 150, 0,  0.5, 0.5)
      love.graphics.print("Code by Jerome Chapoul", 500, 250)
      love.graphics.print("Flying To The Cyber Moon", 500, 300)
      love.graphics.print("Siret N °: 853352318", 500, 350)
      
    end

else
  
    --Print life
    love.graphics.print("Life :  " .. Life, 10, DisplayHeight - 40)

    local X, Y 
    local Bx = 0 
    local By = 0
    
    --Drawinf of the mesh grill create in begin()
    for x = 1, Brique.numberheight do
      Bx = 0
        for y = 1, Brique.numberwidth do
          
          --1 normal brique, 2 indestructible brique
          if LevelActiv[x][y] == 1  and Life > 0 then
            
            -- + 1 / -1 incrementation for brique space betweem them 
            love.graphics.draw(ImageBrique, Bx + 1 , By + 1,  Ball.orientation , 0.15, 0.08)
            
          elseif LevelActiv[x][y] == 2 and Life > 0 then
            
            love.graphics.draw(ImageBriqueIndestructible, Bx + 1 , By + 1,  Ball.orientation , 0.15, 0.08)
            
          end
          
          Bx = Bx + Brique.width
        end
        By = By + Brique.height
    end
    
    if Life > 0 and Brique.counter > 0 then
    
      --Fill Square drawing att position x,y and size ,y, x 
      love.graphics.draw(ImageBrique, Pad.x , Pad.y,  Ball.orientation , Pad.width* 0.0017, 0.08)
      
      --draw ball
      love.graphics.draw(ImageBall2, Ball.x - 18 , Ball.y - 25,  Ball.orientation , 0.1, 0.1)
      
    end
    
    
    --Pad collision sound
    if PadCollisionFlag == true then
      
      love.audio.stop(SoundPadResize)
      love.audio.play(SoundPadResize)
      PadCollisionFlag = false
      
    end
    
     --malus pad reduction sound
    if BonusMalus.lowsizepad == true  then
      
      love.audio.stop(SoundReducePad)
      love.audio.play(SoundReducePad)
      BonusMalus.lowsizepad = false
      
    end
    
      --bonus pad up sizesound
    if BonusMalus.upsizepad == true  then
      
      love.audio.stop(SoundUpPad)
      love.audio.play(SoundUpPad)
      BonusMalus.upsizepad = false
      
    end
    
    -- Up speed Ball
    if BonusMalus.hightspeedball == true  then
      
      love.audio.stop(SoundSpeedBall)
      love.audio.play(SoundSpeedBall)
      BonusMalus.hightspeedball = false
      
    end
    
    --brique collision 
    if BriqueCollision  == true  then
      
      --stop musique and restart it if lot of bricks are crushed
      love.audio.stop(SoundBriqueCollision)
      love.audio.play(SoundBriqueCollision)
      BriqueCollision = false
      Animation.briquecollisiontrigger = true
      Brique.counter = Brique.counter - 1
      Animation.time = 0
    
    elseif BriqueIndestructibleCollision == true then
    
      love.audio.stop(SoundBriqueIndestructible2)
      love.audio.play(SoundBriqueIndestructible2)
      BriqueIndestructibleCollision = false
      
    end
    
    --animation brique collision --seter l'origine de l'explosion sur la brique
    if Animation.briquecollisiontrigger == true and Animation.briquecollisionframe  < 11 then
      
      --love.graphics.draw(SpriteChocBallBric, SpritChocBallCut[Animation.briquecollisionframe], 400  , 400 ,  0 , 1, 1)
      
    else 
      
      Animation.briquecollisiontrigger = false
      
    end
    
    -- End level
    if Brique.counter == 0 then

      love.graphics.draw(YouWinObject, 265 , 100)
      UserPushSpace()

    end
    
    
    --To finish, bug to print on display
    if Life == 0 then
      
      love.graphics.draw(YouLooseObject, 125, 100)
      
      UserPushSpace()
      
    elseif Life == 1 then
      
      love.audio.play(SoundWarningOneLife)
      
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

function LevelSelection()
  
  Ball.glue = true
  
  local Y, X = 0, 0
  
  if Level == 1 then
  
    --Creation of the level mesh brique to create
    for Y = 1, Brique.numberheight do
      
      LevelActiv[Y] = {}
      
        for X = 1, Brique.numberwidth do
          
          LevelActiv[Y][X] = 1
          
        end
    end
    
  elseif Level == 2 then
    
   --Creation of the level mesh brique to create
    for Y = 1, Brique.numberheight do
      
      LevelActiv= {{1,1,1,1,1,1,1,1},
                   {1,2,1,2,1,2,1,2},
                   {1,1,1,1,1,1,1,1},
                   {2,1,2,1,2,1,2,1},
                   {1,1,1,1,1,1,1,1},
                   {1,2,1,2,1,2,1,2}}
    end
    
  elseif Level == 3 then
    
    --Creation of the level mesh brique to create
    for Y = 1, Brique.numberheight do
      
      LevelActiv[Y] = {}
      
        for X = 1, Brique.numberwidth do
          
          if Y == 2 or Y == 4 or Y == 6 or Y == 8 then
          
            LevelActiv[Y][X] = 2
            
          elseif Y == 1 or Y == 3 or Y == 5 or Y == 7 then
          
            LevelActiv[Y][X] = 1
          
          end
          
        end
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

    Life = Life + 1
  
  end
  
  
end

function love.keypressed(key, scancode, isrepeat)
   
   if key == "escape" then
     
      love.event.quit()
      
   end
   
   if key == "space" then
     
      Title = false
      
      --restart game when life = 0
      if Life == 0 then
        
        SoundGameMusic:stop()
        SoundGameMusic:play()
        
        love.load()
        
        
      end
      
      --Level completed
      if Brique.counter == 0 then
        
        Level = Level + 1
        love.load()
        
      end
      
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

