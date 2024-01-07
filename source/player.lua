import "CoreLibs/object"

class("Player").extends()

function Player:init()
    self.name = "[player name]"
    self.honorific = "Mx."
    self.state = {}
    self.inventory = {}
    self.currentAct = 3
    self.maxAct = 5
    self.nodeName = "start"
end

player = Player()