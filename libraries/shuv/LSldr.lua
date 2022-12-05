LSldr = {}
LSldr.__index = LSldr

setmetatable(LSldr, {
  __call = function (cls, ...)
    return cls.new(...)
  end,
})

function LSldr.new(x,y,w,h,bgcolor,text,font,fontcolor,fontsize,hgcolor,radius,bordercolor)
  local self = setmetatable({}, LSldr)
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

function LSldr:setOnClick(event)
  self.onClickEvent = event
end

function LSldr:draw(love)
  love.graphics.setFont(self.font)
  if self ~= nil and self.visible then
    --draw internal retangles
    love.graphics.setColor( self.currentColor )
    love.graphics.rectangle("fill", self.x, self.y, self.w , self.h) --background
  end
end

function LSldr:update(love, push, dt)
  
end

function LSldr:mousepressed(love, push, x, y, button)
  
end

function LSldr:print()
  print("slider")
end

function LSldr:setVisible(visible)
  self.visible = visible
end