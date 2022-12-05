--Uncomment for Lua Debugging in Zerobrane
--if arg[#arg] == "-debug" then require("mobdebug").start() end

--Libraries
push = require 'libraries/push/push'
lbtn = require 'libraries/shuv/LBtn'
lsldr = require 'libraries/shuv/LSldr'

--Globals
gColorNeonPink = {1,.4,.768,1}
gColorNeonBlue = {0.360,1,0.901,1}
gColorNeonLightPink = {1.0,0.654,0.894,1}
gColorBlack = {0.0,0.0,0.0,1.0}

gGameTargetWidth = 1600
gGameTargetHeight = 900

--Locals
local lSettingsBtn = nil
local lExitGameBtn = nil
local lDemoSldr = nil

--Push window handling
local windowWidth, windowHeight = love.window.getDesktopDimensions()
windowWidth, windowHeight = windowWidth*.7, windowHeight*.7 --make the window a bit smaller than the screen itself
push:setupScreen(gGameTargetWidth, gGameTargetHeight, windowWidth, windowHeight, {fullscreen = false})

--User Functions. NOTE -- These must go first, otherwise they'll be nil when trying to register handlers in the set function
local function GameSettingsClick()
  if push ~= nil then
    push:switchFullscreen(gameTargetWidth,gameTargetHeight)
  end
end

local function GameExitClick()
  love.event.quit()
end

local function GameSliderClick()
  
end

--Love2D Native Calls
function love.load()
  love.window.setTitle( "Slider Bar Project" )
  love.graphics.setNewFont(20)
  lFont = love.graphics.getFont()
  lFontSize = 20
  lFontOffset = 30
  
  lSettingsBtn = LBtn(200, 600,150,50,gColorNeonPink,"Full Screen",lFont,gColorBlack,lFontSize ,gColorNeonBlue, 12,gColorBlack)
  lExitGameBtn = LBtn(400, 600,150,50,gColorNeonPink,"Exit Game",lFont,gColorBlack,lFontSize,gColorNeonBlue, 12,gColorBlack)
  lDemoSldr = LSldr(200, 400,400,50,gColorNeonPink,"Slider",lFont,gColorBlack,lFontSize,gColorNeonBlue, 12,gColorBlack)
  
  lSettingsBtn:setVisible(true)
  lExitGameBtn:setVisible(true)
  lDemoSldr:setVisible(true)
  
  lSettingsBtn:setOnClick(GameSettingsClick)
  lExitGameBtn:setOnClick(GameExitClick)
  lDemoSldr:setOnClick(GameSliderClick)
  
end

function love.draw()
  push:start()
  
  lSettingsBtn:draw(love)
  lExitGameBtn:draw(love)
  
  love.graphics.setColor(1,1,1,1)
  love.graphics.print("Slider", 180,360)
  love.graphics.print("Slider Value:", 180,470)
  lDemoSldr:draw(love)
  
  push:finish()
end

function love.update(dt)
  if lSettingsBtn then
    lSettingsBtn:update(love,push,dt)
  end
  
  if lExitGameBtn then
    lExitGameBtn:update(love,push,dt)
  end
  
  if lDemoSldr then
    lDemoSldr:update(love,push,dt)
  end
end

function love.mousepressed(x, y, button)
  
  if lSettingsBtn then
    lSettingsBtn:mousepressed(love,push,x,y,button)
  end
  
  if lExitGameBtn then
    lExitGameBtn:mousepressed(love,push,x,y,button)
  end
  
  if lDemoSldr then
    lDemoSldr:mousepressed(love,push,x,y,button)
  end
end



