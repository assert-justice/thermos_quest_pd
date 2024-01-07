import "common"
import "node/node_helpers"
import "node/option"
import "node/node_manager"
import "player"
import "acts/act0"
import "acts/act1"
import "acts/act2"

local pd <const> = playdate
local gfx <const> = playdate.graphics
local pl <const> = player

local nodeManager = nil

local acts = {act0, act1, act2}

function setAct(actId)
    -- clear on global nodes
    nodeManager:clear()
    -- set the player act
    pl.currentAct = actId
    if actId > pl.maxAct then pl.maxAct = actId end
    -- add act nodes
    local act = acts[actId]()
    for name,node in pairs(act) do
        nodeManager:addNode(name,node)
    end
end

function setup()
    nodeManager = NodeManager()
    nodeManager:addRule("next", function()
        pl.currentAct += 1
        if not acts[pl.currentAct] then return "credits" end
        setAct(pl.currentAct)
        return "start"
    end)
    local titleNode = newTitleCardNode("_Thermos Quest_","A game by Gale, Johnathan, and Riley",{
        -- Option("Resume", "start", function() return pl.currentAct == 1 end),
        Option("Resume", "start", function() return pl.currentAct > 1 end, function()setAct(pl.currentAct) end),
        Option("Begin", "start", nil, function()setAct(1) end),
        Option("Chapter Select", "chapter_select"),
    })
    nodeManager:addNode("title", titleNode, true)
    local creditsNode = newTitleCardNode("_Thanks for Playing_","A game my Gale, Johnathan, and Riley",{
        Option("Begin", "start", nil, function()setAct(1) end),
        Option("Chapter Select", "chapter_select"),
    })
    nodeManager:addNode("credits", creditsNode, true)
    local chapterSelectNode = newTitleNode("Chapter Select",{
        Option("Prologue", "start", nil, function()setAct(1) end),
        Option("Act 1", "start", function()return pl.maxAct>1 end, function()setAct(2) end),
        Option("Act 2", "start", function()return pl.maxAct>2 end, function()setAct(3) end),
        Option("Act 3", "start", function()return pl.maxAct>3 end, function()setAct(4) end),
        Option("Act 4", "start", function()return pl.maxAct>4 end, function()setAct(5) end),
        Option("Act 5", "start", function()return pl.maxAct>5 end, function()setAct(6) end),
    })
    nodeManager:addNode("chapter_select", chapterSelectNode, true)
    nodeManager:navigate("title")
end

setup()

function pd.update()
    nodeManager:update()
    gfx.sprite.update()
    pd.timer.updateTimers()
end