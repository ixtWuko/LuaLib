--- local ENUM_SAMPLE = enum {
---     FIRST_NAME = 1,
---     SECOND_NAME = 2,
---     THIRD_NAME = 3,
--- }


local RandomString = require("RandomString")

local private = setmetatable({}, { __mode = "k" })

local ENUM_ID_LENGTH = 8
local EnumIdGenerator
EnumIdGenerator = function()
    local id = RandomString.SimpleRandom(ENUM_ID_LENGTH)
    if not private[id] then
        return id
    end
    return EnumIdGenerator()
end

local enum_metatable = {
    __index = function(enumId, key)
        local storage = private[enumId]
        return storage[key]
    end,
    __newindex = function()
        assert(false, "enum modification forbidden.")
    end,
    __tostring = function(enumId)
        return "enum: " .. enumId
    end,
    __metatable = "enum"
}

local function enum(nameTable)
    assert(type(nameTable) == "table", "enum MUST be a table.")
    for name in pairs(nameTable) do
        assert(type(name) == "string", "enum name MUST be a string")
    end

    local enumId = EnumIdGenerator()
    private[enumId] = nameTable
    debug.setmetatable(enumId, enum_metatable)
    return enumId
end

return enum