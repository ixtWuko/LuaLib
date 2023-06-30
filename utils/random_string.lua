local time = require("utils.time")

local random_string = {}

local DEFAULT_CHARACTERS = { 'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n',
                             'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z',
                             'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N',
                             'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z',
                             '0', '1', '2', '3', '4', '5', '6', '7', '8', '9' }
local DEFAULT_CHARACTERS_AMOUNT = #DEFAULT_CHARACTERS

function random_string.SimpleRandom(length, characters)
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

function random_string.TimestampRandom(length, characters)
    local chars = DEFAULT_CHARACTERS
    local charsAmount = DEFAULT_CHARACTERS_AMOUNT
    if characters then
        chars = characters
        charsAmount = #characters
    end
    local timestamp = string.format("%x", time.GetTimestampInMillisecond())
    local timestampLength = #timestamp
    assert(length > timestampLength, "the parameter 'length' should be greater than " .. timestampLength)
    local remainLength = length - timestampLength
    local ret = {}
    local random = math.random
    for i = 1, remainLength do
        ret[i] = chars[random(1, charsAmount)]
    end
    return timestamp .. table.concat(ret)
end

local MachineIdLength = 10
local RandomPartLength = 12
local RandomPartMax = 2 ^ RandomPartLength - 1
function random_string.SnowFlake(machineId)
    local timestamp = time.GetTimestampInMillisecond()
    local random = math.random(0, RandomPartMax)
    local ret = (timestamp  << (MachineIdLength + RandomPartLength)) +
                (machineId << RandomPartLength) + random
    return string.format("%16x", ret)
end

return random_string
