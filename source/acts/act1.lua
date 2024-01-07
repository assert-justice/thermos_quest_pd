import "common"
import "node/node_helpers"
import "node/option"
import "player"

local pd <const> = playdate
local gfx <const> = playdate.graphics
local pl <const> = player

local guesses = {
    {
        number ="1776",
        response ="That would be pretty trite, wouldn't it?",
        prompt = "Certainly"
    },
    {
        number = "0451",
        response = "NEEEEEEEEEEEEEERD",
        prompt = "Fine"
    },
    {
        number ="1066",
        response ="Pip pip, jolly good try, but that isn't the combination.",
        prompt = "Bollocks"
    },
    {
        number ="1941",
        response ="Ah, of course, the year Cheerios were invented. That's got to be it! ...Oh wait, never mind. That isn't right after all.",
        prompt = "How disappointing"
    },
    {
        number ="12345",
        response ="This is a door, not your luggage.",
        prompt = "Oh, ok"
    },
    {
        number ="1588",
        response ="On October 8, 1588, Spain declined. Unfortunately, this information won't help you open the door.",
        prompt = "Strange reference but ok"
    },            	
    {
        number ="2525",
        response ="In the year 2525<br>If man is still alive.<br>If woman can survive, they may find.<br><br>In the year 3535<br>Ain't gonna need to tell the truth, tell no lies.<br>Everything you think, do and say, is in the pill you took today.<br><br>In the year 4545<br>Ain't gonna need your teeth, won't need your eyes.<br>You won't find a thing to chew.<br>Nobody's gonna look at you.<br><br>In the year 5555<br>Your arms hanging limp at your sides.<br>Your legs got nothing to do.<br>Some machine doing that for you.<br><br>In the year 6565<br>Ain't gonna need no husband, won't need no wife.<br>You'll pick your son, pick your daughter too.<br>From the bottom of a long glass tube. Whoa-oh<br><br>In the year 7510<br>If God's a-comin, he oughta make it by then.<br>Maybe he'll look around himself and say.<br>Guess it's time for the judgment day.<br><br>In the year 8510<br>God is gonna shake his mighty head.<br>He'll either say.I'm pleased where man has been.<br>Or tear it down and start again. Whoa-oh<br><br>In the year 9595<br>I'm kinda wonderin if man is gonna be alive.<br>He's taken everything this old Earth can give.<br>And he ain't put back nothing.Whoa-oh<br><br>Now it's been ten thousand years<br>Man has cried a billion tears.<br>For what he never knew,<br>now man's reign is through.<br><br>But through eternal night.<br>The twinkling of starlight.<br>So very far away.<br>Maybe it's only yesterday.<br><br>In the year 2525<br>If man is still alive.<br>If woman can survive, they may find.",
        prompt ="Great, there goes the music budget"
    },
    {
        number ="42",
        response ="NEEEEEEEEEEEEEERD",
        prompt ="Got me"
    },
    {
        number ="5040",
        response ="Highly composite of you! But also wrong, unfortunately.",
        prompt = "Sorry to be so divisive"
    },
    {
        number ="58008",
        response ="How childish. But you can't turn the whole door upside-down, and it doesn't have a screen anyway, so what are you even doing here?",
        prompt = "I don't know. I've never known. Why am I the way that I am?"
    },
    {
        number ="3.14159",
        response ="What? Look there isn't even a decimal point on this thing.",
        prompt = "That's dumb"
    },
    {
        number ="208173890789012",
        response ="Hey, how did you get my bank account number? Anyway, that doesn't seem to work.",
        prompt = "Darn"
    }, 
    {
        number ="Margaret Thatcher's birthday",
        response ="Gross!",
        prompt = "Fair"
    },
    {
        number ="666",
        response ="Sure, that might be a likely combination if this were an evil corporation, but this is Ethical Corp™ we're talking about. They're not evil. Probably!",
        prompt = "Makes sense to me"
    },
    
    {
        number ="2",
        response ="That's it? Just TWO? Sorry, I can't do just two.",
        prompt = "It was weird of me to try it"
    },           
    {
        number ="0112358132235",
        response ="The ghost of Leonardo Fibonacci (who haunts this compound for some reason) chortles with delight. Unfortunately, you are no closer to getting this door open.",
        prompt = "Fiddlesticks"
    },
    {
        number ="777-3456",
        response ="Hello and welcome to Moviefone! We're sorry but our service is temporarily unavailable right now. Plus you still need to get this jerkin' door open! Please try again later!",
        prompt = "Whatever"
    },
    {
        number ="e^(i ** pi)",
        response ="I hate to be the negative one but you've left me little choice. You're WRONG.",
        prompt ="Seems unlikely"
    },
    {
        number ="TREE(3)",
        response ="What am I, a botanist?",
        prompt = "Yes. Yes you are a botanist. Let me take another stab at this door please?"
    }, 
    {
        number ="Aleph-nought",
        response ="You don't have time for that",
        prompt = "Ok"
    },
    {
        number ="Avogadro's number?",
        response ="You can't remember it. High school chemistry class is truly a foreign country.",
        prompt ="Oh well"
    },
    {
        number = "A solution to Reimann zeta function with a real part NOT equal to one half.",
        response = "Very impressive. Unfortunately that's not the code for the keypad. Go collect your Millennium Prize",
        prompt = "Ok but not before I get my thermos"
    },
    {
        number = "[Kick it in frustration]",
        response = "Against all odds this works. The door to the office unlocks.",
        prompt = "lemme in",
        correct = true
    },
}

function act1()
    local act = {}
    local guessedOptions = {}
    local guessCount = 0
    local options = {}
    for idx,guess in ipairs(guesses) do
        local hideFn = function() return not guessedOptions[guess] end
        local useFn = function() guessedOptions[guess] = true guessCount += 1 end
        local dest = "start"
        if guess.correct then 
            dest = "next"
            hideFn = function() return guessCount > 2 end
            useFn = nil
        end
        local op = Option(guess.number, guess.number, hideFn, useFn)
        options[idx] = op
        local prompt = Option(guess.prompt, dest)
        act[guess.number] = newTextNode(guess.response, {prompt})
    end

    local startNode = newTitleTextNode("_Act 1: The Treachery of Objects_","To get back in first you'll have to enter a combination on a keypad. What do you enter?", options)
    startNode:getComponent("select"):resize(50, 100, 300, 140)
    act["start"] = startNode
    return act
end
