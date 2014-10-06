

function circleCollision(a, b)
  return math.sqrt(math.pow(a.x-b.x, 2) + math.pow(a.y-b.y, 2)) < a.r + b.r
end

function printMidText(text, y, font)
  prevFont = graphics.getFont()  
  graphics.setFont(font)
  graphics.printf(text, WIDTH * 0.5 - 999 * 0.5, y, 999, "center")
  graphics.setFont(prevFont)
end


function printFont(font, text, x, y, r, sx, sy, ox, oy)
  local previousFont = love.graphics.getFont()
  love.graphics.setFont(font)
  love.graphics.print(text, x, y, r, sx, sy, ox, oy)
  love.graphics.setFont(previousFont)
end


function printFontCentered(font, text, x, y, width)
  local previousFont = love.graphics.getFont()
  love.graphics.setFont(font)
  love.graphics.printf(text, x - width / 2, y, width, "center")
  love.graphics.setFont(previousFont)
end
