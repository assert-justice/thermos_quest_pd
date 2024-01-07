import "CoreLibs/object"

class("Component").extends()

function Component:init(x, y, width, height)
    self.x = x 
    self.y = y 
    self.width = width
    self.height = height
end

function Component:resize(x, y, width, height)
    self.x = x 
    self.y = y 
    self.width = width
    self.height = height
end

function Component:update()
end

function Component:mount()
end

function Component:unmount()
end
