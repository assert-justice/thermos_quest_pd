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
    if self.rules[name] then
        name = self.rules[name]()
    end
    -- print("")
    -- print(name)
    -- for na,no in pairs(self.nodes) do print(na) end
    -- print(self.nodes[name])
    assert(self.nodes[name])
    player.currentNode = name
    self.currentNode = self.nodes[name]
    self.currentNode:mount()
end