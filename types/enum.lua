--[[ Sample:
local ENUM_SAMPLE = enum {
     FIRST_NAME = 1,
     SECOND_NAME = 2,
     THIRD_NAME = 3,
}
]]--

local __newindex = function()
    assert(false, "modification of enum is forbidden.")
end

local enum = function(nameTable)
    assert(type(nameTable) == "table", "enum MUST be a table.")
    for name in pairs(nameTable) do
        assert(type(name) == "string", "enum name MUST be a string")
    end

    nameTable.__index = nameTable
    nameTable.__newindex = __newindex
    nameTable.__metatable = "enum"
    local enum_object = setmetatable({}, nameTable)
    return enum_object
end

return enum
