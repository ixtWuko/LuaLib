local RandomString = {}

local DEFAULT_CHARACTERS = { 'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 
                             'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z', 
                             'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 
                             'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z', 
                             '0', '1', '2', '3', '4', '5', '6', '7', '8', '9' }
local DEFAULT_CHARACTERS_AMOUNT = #DEFAULT_CHARACTERS

function RandomString.SimpleRandom(length, characters)
    local chars = DEFAULT_CHARACTERS
    local charsAmount = DEFAULT_CHARACTERS_AMOUNT
    if characters then
        chars = characters
        charsAmount = #characters
    end
    local ret = {}
    local random = math.random
    for i = 1, length do
        ret[i] = chars[random(1, charsAmount)]
    end
    return table.concat(ret)
end

return RandomString