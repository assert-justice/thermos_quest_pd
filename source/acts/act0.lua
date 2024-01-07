import "common"
import "node/node_helpers"
import "node/option"
import "player"

local pd <const> = playdate
local gfx <const> = playdate.graphics
local pl <const> = player

function act0()
    local act = {}
    local titles = {"Mr.", "Ms.", "Mx.", "Doctor", "Captain"}
    local firstNames = {"Marla","Winifred","Albert","Ester","Fenric","Vanessa","Edith","Rene","Trilby","Sanjay","Mateo","Madeline","Stetson","Thing","Franz","Wensleydale","Petra","Marty","Emmett","Biff","Lyndon","Dick","Dolemite","Martok","Alowishus","Grogu","Rupret","Apollonius","Terspichore","Demosthenes","Anastasia","Xerxes","Phobos","Ganymede","Hyperion","Umbriel","Proteus","Charon","Dysnomia","Steve","Oedon","Percy","Hikaru","Wally","Shawn","Hermes","Toby","Nashandra"}
    local middleNames = {"Duke","Pearl","Seersucker","Foxglove","Hootenanny","Devadander","Snakes","Houndstooth","Obediah","Tyrion","Wafflemacher","Bader","S","Argyle","'Two Sheds'","Damask","Matelasse","Quatrefoil","Suzani","Chevron","Paisley","Ogee","Herringbone","Chinoiserie","Lingthusiasm","Titania","Millicent","Zilpah","Ziggy","Linus","Trilobyte","Arachnidae","Atticus","Xen","Teriyaki","Soba","Radiatore","Fusilli","Fettuccine","Linguine","Gnocchi","Manicotti","Spaghetti","Ravioli","Tortellini"}
    local lastNames = {"Griggs","Head","Marzipan","Haberdasher","O'Hara","Stilton","StarRider","Mateo","Etoufee","Lamar","Gloop","Thing","Newstead","Hearst","Nidhogg","Goulash","Jambalaya","Power","Scriabin","Bartok","Abercrombie","von Ribbentrop","Terkel","Weinrib","Charlemagne","Lothric","Threepwood","Tannen","Malloy","Disraeli","Vendrick","Hyrule","Stubbs","Finklestein","Seraphim","Osborn","Parker","Richards","Wayne","Batman","Goober","Venture","Picard","Dax","Bourbon","Wong","Raine"}

    local titleOptions = {}
    for idx,str in ipairs(titles) do
        titleOptions[idx] = Option(str, "summary", nil, function() pl.honorific = str end)
    end
    local firstNameOptions = {}
    for idx,str in ipairs(firstNames) do
        firstNameOptions[idx] = Option(str, "middle_name", nil, function() pl.name = str end)
    end
    local middleNameOptions = {}
    for idx,str in ipairs(middleNames) do
        middleNameOptions[idx] = Option(str, "last_name", nil, function() pl.name = pl.name .. " " .. str end)
    end
    local lastNameOptions = {}
    for idx,str in ipairs(lastNames) do
        lastNameOptions[idx] = Option(str, "honorific", nil, function() pl.name = pl.name .. " " .. str end)
    end
    act["start"] = newTitleTextNode("Prologue","On your walk home from Ethical Corp™ you are filled with a dawning horror as you realize... You left your thermos behind! And it's after hours! Flustered you try to remember your first name:", firstNameOptions)
    act["middle_name"] = newTextNode("Good job! After some more consideration you remember your middle name:", middleNameOptions)
    act["last_name"] = newTextNode("Truly your powers of recollection are remarkable. Your last name then?", lastNameOptions)
    act["honorific"] = newTextNode("Finally, what honorific do you go by?", titleOptions)
    act["summary"] = newTextNode(function() return "Of course, your name is and has always been " 
        .. pl.honorific .. " " .. pl.name end, {Option("Of course", "next")})
    return act
end
