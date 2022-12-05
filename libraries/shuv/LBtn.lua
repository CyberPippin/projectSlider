LBtn = {}
LBtn.__index = LBtn

setmetatable(LBtn, {
  __call = function (cls, ...)
    return cls.new(...)
  end,
})

function LBtn.new(x,y,w,h,bgcolor,text,font,fontcolor,fontsize,hgcolor,radius,bordercolor)
  local self = setmetatable({}, LBtn)
  self.x = x
  self.y = y
  self.w = w
  self.h = h
  self.bgcolor = bgcolor
  self.text = text
  self.font = font
  self.fontcolor = fontcolor
  self.fontsize = fontsize
  self.currentColor = self.bgcolor
  self.hgcolor = hgcolor
  self.onClickEvent = nil
  self.r = radius
  self.bordercolor = bordercolor
  self.visible = false
  return self
end

function LBtn:setOnClick(event)
  self.onClickEvent = event
end

function LBtn:draw(love)
  love.graphics.setFont(self.font)
  if self ~= nil and self.visible then
    --draw internal retangles
    love.graphics.setColor( self.currentColor )
    love.graphics.rectangle("fill", self.x + self.r, self.y + self.r, self.w - (self.r * 2), self.h - self.r * 2) --main window
    love.graphics.rectangle("fill", self.x + self.r, self.y, self.w - (self.r * 2), self.r)
    love.graphics.rectangle("fill", self.x + self.r, self.y + self.h - self.r, self.w - (self.r * 2), self.r)
    love.graphics.rectangle("fill", self.x, self.y + self.r, self.r, self.h - (self.r * 2))
    love.graphics.rectangle("fill", self.x + (self.w - self.r), self.y + self.r, self.r, self.h - (self.r * 2))
    
    --draw corners
    love.graphics.arc("fill", self.x + self.r, self.y + self.r, self.r, math.rad(-180), math.rad(-90))
    love.graphics.arc("fill", self.x + self.w - self.r , self.y + self.r, self.r, math.rad(-90), math.rad(0))
    love.graphics.arc("fill", self.x + self.r, self.y + self.h - self.r, self.r, math.rad(-180), math.rad(-270))
    love.graphics.arc("fill", self.x + self.w - self.r , self.y + self.h - self.r, self.r, math.rad(0), math.rad(90))
    
    --draw text
    love.graphics.setColor( self.fontcolor )
    if self.fontsize then
      love.graphics.printf(self.text, self.x, (self.y + self.h/2) - self.fontsize/2, self.w, "center")
    end
    
    --draw border
    love.graphics.setColor(self.bordercolor)
    love.graphics.arc("line", "open", self.x + self.r, self.y + self.r, self.r, math.rad(-180), math.rad(-90))
    love.graphics.arc("line", "open", self.x + self.w - self.r , self.y + self.r, self.r, math.rad(-90), math.rad(0))
    love.graphics.arc("line", "open", self.x + self.r, self.y + self.h - self.r, self.r, math.rad(-180), math.rad(-270))
    love.graphics.arc("line", "open", self.x + self.w - self.r , self.y + self.h - self.r, self.r, math.rad(0), math.rad(90))
      
    love.graphics.line( self.x + self.r, self.y, self.x + self.w - self.r, self.y) --top
    love.graphics.line( self.x + self.r, self.y+ self.h, self.x + self.w - self.r, self.y + self.h) --bottom
    love.graphics.line( self.x, self.y + self.r, self.x, self.y + self.h - self.r) --left
    love.graphics.line( self.x + self.w, self.y + self.r, self.x + self.w, self.y + self.h-self.r) --right
  end
end

function LBtn:update(love, push, dt)
  if love ~= nil then
    if push ~= nil then
      mouseX = love.mouse.getX()
      mouseY = love.mouse.getY()
      
      mouseX, mouseY = push:toGame(mouseX, mouseY)
      
      if self ~= nil then
        if mouseX ~= nil and mouseY ~= nil then
          if (mouseX >= self.x) and (mouseY >= self.y) and (mouseX <= (self.x+self.w)) and (mouseY <= (self.y+self.h)) then
            self.currentColor = self.hgcolor
          else
            self.currentColor = self.bgcolor
          end
        end
      end
    end
  end
end

function LBtn:mousepressed(love, push, x, y, button)
  mouseX, mouseY = push:toGame(x, y)
  if self ~= nil and self.visible and mouseX ~= nil and mouseY ~= nil then
    if (mouseX >= self.x) and (mouseY >= self.y) and (mouseX <= (self.x+self.w)) and (mouseY <= (self.y+self.h)) then
      if self.onClickEvent ~= nil then
        self.onClickEvent()
      end
    end
  end
end

function LBtn:print()
  print("button")
end

function LBtn:setVisible(visible)
  self.visible = visible
end