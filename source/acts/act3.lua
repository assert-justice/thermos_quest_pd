import "common"
import "node/node_helpers"
import "node/option"
import "player"

local pd <const> = playdate
local gfx <const> = playdate.graphics
local pl <const> = player

function act3()
    local act = {}
    local hwVisited = false
    local foundPassword = false
    act["start"] = newTitleTextNode("_Act the third: Abandon Hope all yea who Enter Here_", "Having bypassed the break room you enter a terrifying new domain: the cubicle farm. It will take all of your wits to find your humble desk. Gather your courage adventurer for your trials are far from over.",{
        Option("Embark", "hallway")
    })
    act["hallway"] = newTitleTextNode("Hallway", "A pretty normal hallway all things considered. A bit musky maybe. There is some tasteful art on the walls as well as employee of month placards. Ahead of you is the locker room and to the left is the cubicle farm proper.",{
        Option("Examine Art", "art"),
        Option("Examine Placards", "placards"),
        Option("Go forward to locker room", function()if hwVisited then return "quiz" else return "hw_intro" end end),
        Option("Go left to Harry's cubicle", "harry"),
    })
    act["art"] = newQuipNode("Art", "You consider the art. The art moves you. You have a quiet moment.",{
        Option("Finish your contemplation", "back")
    })
    act["placards"] = newQuipNode("Placards", "Here reside the present and former employees of the month. One day you may join their hallowed ranks. Your coworker H.W. has won for the last eight months solid.",{
        Option("Suck ups", "back")
    })
    act["hw_intro"] = newQuipNode("Locker Room", "Before you can open the door to the locker room you are accosted by Horse Wizard, a charming and very marketable character who is a wizard as well as a horse. They eye you with suspicion as their tail flicks with consternation.",{
        Option("Blimey", "quiz", nil, function() hwVisited = true end)
    })
    act["quiz"] = newTitleTextNode("Locker Room", "'Who goes there?' H.W. asks 'You may only pass me if you speak the password. But: I am a magnanimous horse wizard. I will give you a hint: What word is three letters long and can be both an animal and an operating system?' They issue a conspiratorial whinney.",{
        Option("Say 'It's GNU'", "exit", function() return foundPassword end),
        Option("[Shuffle out awkwardly]", "hallway"),
    })
    act["exit"] = newQuipNode("Locker Room", "H.W. Neighs with approval 'You have pleased this Horse Wizard. Venture forth to your ultimate fate and prepare to cut a rug.' You hear the distinct sound of newsprint rustling behind them.",{
        Option("Tally ho!", "next")
    })
    act["harry"] = newTitleTextNode("Harry's Cubicle", "Harry is a dutiful albeit unimaginative worker.",{
        Option("Go right to the hallway", "hallway"),
        Option("Go forward to Deb's cubicle", "deb"),
        Option("Go down to your cubicle", "cubicle"),
    })
    act["cubicle"] = newTitleTextNode(function() return "The Cubicle of " 
        .. pl.honorific .. " " .. pl.name end, "Your home away from home. Where you grind out a third of your life selling your labor for a fraction of the value you generate. At least you have a stress ball.",{
        Option("Examine stress ball", "stress_ball"),
        Option("Examine red fish", "red_fish"),
        Option("Go forward to Harry's cubicle", "harry"),
    })
    act["stress_ball"] = newQuipNode("Stress Ball", "One of these days it's going to pop.",{
        Option("Better get back to it", "back")
    })
    act["red_fish"] = newQuipNode("stress_ball", "Your thermos isn't here! Where it should be there is kind of a red fish.",{
        Option("Maybe Chekhov's gun is around here somewhere...", "back")
    })
    act["deb"] = newTitleTextNode("Deb's Cubicle", "Deborah's desk is pretty cluttered. You see pictures of her kids and an assortment of novelty coffee cups. Her computer displays the 'pipes' screensaver like it's 1998.",{
        Option("Examine photos", "photos"),
        Option("Examine coffee cups", "coffee_cups"),
        Option("Examine computer", "computer"),
        Option("Go down to Harry's cubicle", "harry"),
        Option("Go forward to Jane's cubicle", "jane"),
    })
    act["photos"] = newQuipNode("Art", "You have a moment to think about the nature of family and how work alienates us from our loved ones.",{
        Option("Let's not", "back")
    })
    act["coffee_cups"] = newQuipNode("Art", "Many thrift shops and antique stores have been pillaged for the bounty you see here. There are mugs depicting cats, color changing mugs, rough clay mugs (possibly made by her kids). You wonder if she uses them all.",{
        Option("Mysteries abound", "back")
    })
    act["computer"] = newQuipNode("Deb's Computer", "It seems Deb left her computer running. She's playing some game and is stuck on an obnoxious inventory puzzle.",{
        Option("Oof. Good luck with that.", "back")
    })
    act["jane"] = newTitleTextNode("Jane's Cubicle", "Jane keeps a tidy cubicle with hardly any environmental storytelling to speak of. She does have one of those dipping bird things though. A neatly folded newspaper is just next to her keyboard.",{
        Option("Examine bird thing", "bird"),
        Option("Examine newspaper", "newspaper"),
        Option("Go down to Deb's cubicle", "deb"),
    })
    act["bird"] = newQuipNode("Dipping Bird Thing", "A long time ago your high school physics teacher explained how these things work. You don't remember though.",{
        Option("Probably magic", "back")
    })
    act["newspaper"] = newQuipNode("Newspaper", "You snoop through Jane's personal space in a way only acceptible in video games. Sure enough you find GNU scribbled in the crossword.",{
        Option("Thanks Jane", "back", nil, function()foundPassword = true end)
    })
    return act
end
