import "common"
import "node/node_helpers"
import "node/option"
import "node/node"
import "node/title"
import "node/select"
import "player"

local pd <const> = playdate
local gfx <const> = playdate.graphics
local pl <const> = player

-- act2 = {}

local items = {
    {
        name =  "cracked cup",
        desc =  "It's a cup. With a crack in it. Essentially, a cracked cup.<br>This thing isn't going to hold anything unless you find a way to seal the crack."
    },
    {
        name = "ballpoint pen",
        desc = "Out of ink, but if your employee evaluation next month goes well, you may be rewarded with a shiny new one."
    },
    {
        name = "frozen orange juice",
        desc = "'Now with twice the acid content!', the label assures helpfully."
    },
    {
        name = "car keys",
        desc = "They aren't yours, so you probably won't have any use for them."
    },
    {
        name =  "lighter fluid",
        desc =  "A small bottle of lighter fluid"
    },
    {
        name =  "defaced keycard",
        desc =  "It's your keycard but an ugly mustache has been drawn on it. It's not going to work in this state!"
    },
    {
        name =  "pristine keycard",
        desc =  "Cleaned up and ready to go!"
    },
    {
        name =  "gross gum",
        desc =  "Pried off the keycard reader. Supple, but alluringly impermeable.<br>Why did you take this again?"
    },
    {
        name = "gummy cup",
        desc = "The gum has sealed the crack admirably. But will it hold??"
    },
    {
        name = "orange juice",
        desc = "Now in liquid form!"
    },
    {
        name = "cup with orange juice",
        desc = "A caustic concoction."
    },
    {
        name = "cup with lighter fluid",
        desc = "A cup of lighter fluid. Maybe you could use it as a solvent?"
    },
    {
        name = "rubber chicken",
        desc = "It used to have a pulley in it, but someone tore it off. Sounds like something tiny is rattling around inside."
    },
    {
        name =  "bobby pin",
        desc =  "The key to luscious locks, or antiquated adornment. Who even uses these anymore?"
    },
    {
        name = "camping stove",
        desc = "No one could seem to figure out how to use the built-in stove, so eventually management sprung for a portable one.<br>You hardly even noticed the deduction from your paycheck."
    }
}

local interactions = {              
    {
        requires = {"rubber chicken","car keys"},
        response = "Wielding the curiously sharp car keys with great depth of focus, as if venting some esoteric childhood frustration, you ferociously tear the rubber chicken to shreds.<br>Inside you find a shiny bobby pin for some reason.",
        yields = {"bobby pin"}
    },
    {
        requires = {"rubber chicken","ballpoint pen"},
        response = "Brandishing the now-defunct writing implement as if it were a less mighty tool of some sort, you ravenously imbue the rubber chicken with a multitude of lacerations.<br>Inside you find a shiny bobby pin for some reason.",
        yields = {"bobby pin"}
    },
    {
        requires = {"car keys","defaced keycard"},
        response = "Trying to fix a key with another key? I guess that makes a certain sense. Though of course, it's terribly incorrect.",
        yields = {"car keys","defaced keycard"}
    },
    {
        requires = {"cracked cup", "defaced keycard"},
        response = "You put the keycard in the cup but nothing happens. Shame.",
        yields = {"cracked cup", "defaced keycard"}
    },
    {
        requires = {"cracked cup", "orange juice"},
        response = "You put some orange juice in the cup but it just drains out through the crack and pools safety-hazardly on the floor.<br>You still have plenty left though.",
        yields = {"cracked cup", "orange juice"}
    },
    {
        requires = {"gummy cup", "defaced keycard"},
        response = "You put the keycard in the gummy cup but still nothing happens. What a let down!",
        yields = {"gummy cup", "defaced keycard"}
    },
    {
        requires = {"cracked cup", "lighter fluid"},
        response = "You pour the lighter fluid in the cup and it immediately drains through the crack and pools safety-hazardly on the floor.<br>Hopefully you didn't need the lighter fluid!.",
        yields = {"cracked cup"}
    },
    {
        requires = {"defaced keycard","ballpoint pen"},
        response = "The pen is out of ink. Besides, you're trying remove the mustache, not embellish it.",
        yields = {"defaced keycard","ballpoint pen"}

    },
    {
        requires = {"camping stove","lighter fluid"},
        response = "No need. It's got one of those self-contained fuel thingies.",
        yields = {"camping stove","lighter fluid"}
    },
    {
        requires = {"camping stove","frozen orange juice"},
        response = "You slowly heat the orange juice over the gently invigorating flame of the camping stove. Miraculously, you manage to melt the OJ without damaging the container or yourself.<br>Of course you do, you're a fucking professional.",
        yields = {"orange juice"}
    },
    {
        requires = {"gummy cup", "lighter fluid"},
        response = "You put the lighter fluid in the cup. Yay?",
        yields = {"cup with lighter fluid"}
    },
    {
        requires = {"cup with lighter fluid", "defaced keycard"},
        response = "Hmm, the lighter fluid doesn't seem to do anything. Looks like you'll need something stronger... <br> (You dump out the lighter fluid)",
        yields = {"gummy cup", "lighter fluid","defaced keycard"}
    },
    {
        requires = {"gummy cup", "orange juice"},
        response = "You fill the cup to the brim with nutritious, highly caustic orange juice.",
        yields = {"cup with orange juice"}
    },
    {
        requires = {"frozen orange juice","lighter fluid"},
        response = "What, are you just going to pour the lighter fluid directly onto orange juice? Then what? Use a stove or something!",
        yields = {"frozen orange juice","lighter fluid"}
    },
    {
        requires = {"frozen orange juice","gummy cup"},
        response = "You attempt to shove the frozen orange juice into the cup, but without success. Maybe this would work better if it wasn't frozen?",
        yields = {"frozen orange juice","gummy cup"}
    },
    {
        requires = {"cup with orange juice", "defaced keycard"},
        response = "You put the keycard in the cup, cleaning off the silly facial hair. Finally!",
        yields = {"pristine keycard"}
    },
    {
        requires = {"gross gum","cracked cup"},
        response = "You gently massage the disgusting premasticated goop into the crack in the cup. Success! She should be seaworthy now...",
        yields = {"gummy cup"}
    }
}

local defaultResponses = {
    "Like the ancient hominids smashing rocks together to discover fire, you slam the objects into each other over and over again in a futile attempt at creation.<br>Every nerve in your body focuses intensely on this profound act of desperation. Eventually you relent, collapsing on the floor in a pathetic huddled mass of exhaustion.<br>The items have defeated you. Oh well, try something else?",
    "That doesn't seem to work.",
    "Is that even legal in this state?",
    "A valiant, even inspirational effort. Unfortunately it doesn't do anything",
    "Nothing happens.",
    "You've gained nothing except for knowledge. Well done.",
    "A great idea, aside from being incredibly wrong.",
    "You're joking, right?",
    "Nah, I don't think so.",
    "You could do that, but it would probably lead to a non-standard game over.",
    "I wouldn't recommend it!",
    "What a silly notion.",
    "It's just crazy enough to not work.",
    "That's contrived even for an adventure game.",
    "You ask the impossible.",
    "I'm sorry Dave, I can't do that.",
    "The inventory police will not allow it.",
    "Nope.",
    "Look, if you're into that I'm not going to judge, but do it on your own time.",
    "No way.",
    "HAHAHAHAHAHAHA no.",
    "The Supreme Court has upheld your sincerly-held religious belief, which won't permit you to combine these items.<br>Feel free to come back to this game and try again after you've successfully lobbied for court reform.",
    "That, uh, isn't a good idea.",
    "How amusingly incorrect of you!",
    "Are you even taking this seriously?",
    "Well that accomplished absolutely nothing. But hey, at least you're trying.",
    "That's not the worst idea you've had. It's still wrong though.",
    "I question your approach to this problem."
}

function act2()
    local act = {}
    local heldItems = {}
    local options = {Option("Great...", "room")}
    local startNode = newTitleTextNode("_Act Two: Time to take Inventory_","After that ordeal you make it to the break room. A keycard reader will let you further into the compound. Good news: you have the card. Bad news: a rascally cowoker has defaced it with a big gross mustache. You'll need to get it off with some kind of contrived inventory puzzle...", options)
    startNode:getComponent("description"):resize(10, 30, 380, 200)
    startNode:getComponent("select"):resize(50, 200, 300, 30)
    startNode.firstVisitedFn = function() 
        pl.inventory = {}
        pl.inventory["defaced keycard"] = true
        pl.inventory["ballpoint pen"] = true
    end
    act["start"] = startNode
    
    local cupboardState = "locked"
    local cupboardDescFn = function()
        local desc = "A cupboard housing untold wonders, perhaps. Or else just dishes and stuff, who knows?"
        if cupboardState == "locked" then 
            desc = desc .. "\nThe cupboard is firmly locked. Maybe you can find a key?"
        elseif cupboardState == "full" then
            desc = desc .. "\nYou use the bobby pin and defeat the lock! Inside is a cracked cup and a camping stove."
        else
            desc = desc .. "\nThis area seems to be cleared out."
        end
        return desc
    end
    local cupboard = newTitleTextNode("Cupboard", cupboardDescFn,{
        Option("Unlock with bobby pin", "cupboard", function() return pl.inventory["bobby pin"] end, function() pl.inventory["bobby pin"] = nil cupboardState = "full" end),
        Option("Pilfer the items", "cupboard", function() return cupboardState == "full" end, function() pl.inventory["cracked cup"] = true  pl.inventory["camping stove"] = true cupboardState = "empty" end),
        Option("Go back", "room"),
        Option("[Look at inventory]", "inventory"),
    })
    act["cupboard"] = cupboard

    local stoveState = "full"
    local stoveDescFn = function()
        local desc = "An old grimy stove. Sometimes it has trouble lighting."
        if stoveState == "full" then
            desc = desc .. "\nThe stove contains lighter fluid and a rubber chicken for some reason."
        else
            desc = desc .. "\nThis area seems to be cleared out."
        end
        return desc
    end
    local stove = newTitleTextNode("Stove", stoveDescFn,{
        Option("Pilfer the items", "stove", function() return stoveState == "full" end, function() pl.inventory["lighter fluid"] = true  pl.inventory["rubber chicken"] = true stoveState = "empty" end),
        Option("Go back", "room"),
        Option("[Look at inventory]", "inventory"),
    })
    act["stove"] = stove

    local keyReaderState = "full"
    local keyReaderDescFn = function()
        local desc = "An ancient and intimidating key reader."
        if keyReaderState == "full" then
            desc = desc .. "\nUnder the key reader is a wad of gross gum. You could take it... I guess?"
        else
            desc = desc .. "\nThe key reader is gumless thanks to you."
        end
        return desc
    end
    local keyReader = newTitleTextNode("Key Reader", keyReaderDescFn,{
        Option("Pilfer the items", "key_reader", function() return keyReaderState == "full" end, function() pl.inventory["gross gum"] = true keyReaderState = "empty" end),
        Option("Swipe the key!", "next", function() return pl.inventory["pristine keycard"] end),        
        Option("Go back", "room"),
        Option("[Look at inventory]", "inventory"),
    })
    act["key_reader"] = keyReader

    local freezerState = "full"
    local freezerDescFn = function()
        local desc = "Neglect has left it a morass of various abandoned food items. As you stare into the frosty abyss, you reflect that in the end we become nothing, eradicated by time and freezer burn."
        if freezerState == "full" then
            desc = desc .. "\nThe freezer contains frozen orange juice and car keys. Naturally."
        else
            desc = desc .. "\nThis area seems to be cleared out."
        end
        return desc
    end
    local freezer = newTitleTextNode("Freezer", freezerDescFn,{
        Option("Pilfer the items", "freezer", function() return freezerState == "full" end, function() pl.inventory["frozen orange juice"] = true  pl.inventory["car keys"] = true freezerState = "empty" end),
        Option("Go back", "room"),
        Option("[Look at inventory]", "inventory"),
    })
    act["freezer"] = freezer

    local inventoryOptions = {}
    for idx,item in ipairs(items) do
        inventoryOptions[idx] = Option("*" .. item.name .. "*: " .. item.desc,
        function() if #heldItems > 1 then return "summary" else return "inventory" end end, 
        function() return pl.inventory[item.name] and heldItems[1] ~= item.name end,
        function() heldItems[#heldItems+1] = item.name end
    )
    end
    inventoryOptions[#inventoryOptions+1] = Option("[Return to room]", "room")
    local inventory = Node()
    inventory:addComponent("title", Title(0, 10, 400, 24, function() 
        if #heldItems == 0 then 
            return "Your inventory. Pick an item to combine." 
        else 
            return "Holding "..heldItems[1].." you combine it with..." 
        end 
    end))
    inventory:addComponent("select", Select(10, 30, 380, 210, inventoryOptions, gfx.getSystemFont():getHeight()*3))
    act["inventory"] = inventory

    local summary = newTitleTextNode("Results:", function()
        local res = "[funny line]"
        heldItems[heldItems[1]] = true
        heldItems[heldItems[2]] = true
        for idx,interaction in ipairs(interactions) do
            local found = true
            for f, name in ipairs(interaction.requires) do
                if not heldItems[name] then found = false break end
            end
            if found then
                -- remove inventory items
                for f, name in ipairs(interaction.requires) do
                    pl.inventory[name] = nil
                end
                -- add whatever was yeilded
                for f, name in ipairs(interaction.yields) do
                    pl.inventory[name] = true
                end
                return interaction.response
            end
        end
        res = defaultResponses[math.random(#defaultResponses)]
        return res
    end, {Option("[Return to room]", "room")})
    act["summary"] = summary

    local roomNode = newTitleTextNode("The Room", "As you look around the room you note the following points of interest:", {
        Option("Cupboard", "cupboard", function() return cupboardState ~= "empty" end),
        Option("Stove", "stove", function() return stoveState ~= "empty" end),
        Option("Key Reader", "key_reader"),
        Option("Freezer", "freezer", function() return freezerState ~= "empty" end),
        Option("[Look at inventory]", "inventory"),
    })
    roomNode:getComponent("select"):resize(50, 100, 300, 130)
    roomNode.visitedFn = function() heldItems = {} end
    act["room"] = roomNode
    return act
end
