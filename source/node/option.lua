import "common"

local pd <const> = playdate
local gfx <const> = playdate.graphics

class("Option").extends()

function Option:init(text, dest, hideFn, useFn)
    self.text = text
    self.dest = dest
    self.hideFn = hideFn
    self.useFn = useFn
end

function Option:isVisible()
    if(self.hideFn == nil) then return true end
    return self.hideFn(self)
end

function Option:use()
    if(self.useFn ~= nil) then self.useFn(self) end
end

function Option:getText()
    if type(self.text) == "string" then 
        return self.text 
    elseif type(self.text) == "function" then 
        return self.text()
    else
        return "[Invalid text]"
    end
end

function Option:getDest()
    if type(self.dest) == "string" then 
        return self.dest 
    elseif type(self.dest) == "function" then 
        return self.dest()
    else
        return "[Invalid dest]"
    end
end
