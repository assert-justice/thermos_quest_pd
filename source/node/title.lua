import "common"
import "component"

local gfx <const> = playdate.graphics

class("Title").extends(Component)

function Title:init(x, y, width, height, title)
    Title.super.init(self, x, y, width, height)
    self.align = kTextAlignment.center
    self.title = title
    self.sprite = gfx.sprite.new()
    self.sprite:setCenter(0, 0)
    self.sprite:moveTo(self.x, self.y)
end

function Title:mount()
    local text = self.title
    -- print(type(self.title))
    if type(self.title) == "function" then 
        text = self.title()
    end
    self.sprite:add()
    local image = gfx.image.new(self.width, self.height)
    gfx.pushContext(image)
        gfx.drawTextInRect(text, 0, 0, self.width, self.height, nil, nil, self.align)
    gfx.popContext()
    self.sprite:setImage(image)
end

function Title:unmount()
    self.sprite:remove()
end