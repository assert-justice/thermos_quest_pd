import "common"
import "player"

local gfx <const> = playdate.graphics

class("NodeManager").extends()

function NodeManager:init()
    self.nodes = {}
    self.currentNode = nil
    self.rules = {}
    self.nameStack = {}
end

function NodeManager:update()
    self.currentNode:update()
end

function NodeManager:clear()
    for name,node in pairs(self.nodes) do
        if not node.isGlobal then self.nodes[name] = nil end
    end
end

function NodeManager:addNode(name, node, isGlobal)
    -- check for collisions
    assert(self.nodes[name] == nil)
    self.nodes[name] = node
    node.parent = self
    node.isGlobal = isGlobal
end

function NodeManager:addRule(name, ruleFn)
    -- check for collisions
    assert(self.rules[name] == nil)
    self.rules[name] = ruleFn
end

function NodeManager:navigate(name)
    -- maybe add transitions?
    if self.currentNode then self.currentNode:unmount() end
    -- check for special names
    if name == "back" then
        self.nameStack[#self.nameStack] = nil
        name = self.nameStack[#self.nameStack]
    elseif self.rules[name] then
        name = self.rules[name]()
    end
    assert(self.nodes[name])
    player.currentNode = name
    self.nameStack[#self.nameStack+1] = name
    self.currentNode = self.nodes[name]
    self.currentNode:mount()
end