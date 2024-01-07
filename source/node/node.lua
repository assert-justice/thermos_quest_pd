import "CoreLibs/object"

class("Node").extends()

function Node:init()
    self.parent = nil
    self.components = {}
    self.visitedFn = nil
    self.firstVisitedFn = nil
    self.visited = false
    self.isGlobal = false
end

function Node:update() 
    for name,comp in pairs(self.components) do
        comp:update()
    end
end

function Node:mount() 
    if not self.visited and self.firstVisitedFn then self.firstVisitedFn() self.visited = true end
    if self.visitedFn then self.visitedFn() end
    for name,comp in pairs(self.components) do
        comp:mount()
    end
end

function Node:unmount() 
    for name,comp in pairs(self.components) do
        comp:unmount()
    end
end

function Node:navigate(name) 
    self.parent:navigate(name)
end

function Node:addComponent(name, component)
    assert(not self.components[name])
    self.components[name] = component
    component.parent = self
end

function Node:getComponent(name)
    assert(self.components[name])
    return self.components[name]
end
