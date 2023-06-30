local table = table
local next = next
local ipairs = ipairs
local pairs = pairs
local assert = assert
local type = type
local tostring = tostring

function table.isEmpty(tb)
    return not next(tb)
end

function table.ilength(tb)
    local len = 0
    for _ in ipairs(tb) do
        len = len + 1
    end
    return len
end

function table.length(tb)
    local len = 0
    for _ in pairs(tb) do
        len = len + 1
    end
    return len
end

function table.copy(tb)
    assert(type(tb) == 'table', "parameter must be table!")
    local ret = {}
    for k, v in pairs(tb) do
        ret[k] = v
    end
    setmetatable(ret, getmetatable(tb))
    return ret
end

function table.deepcopy(tb)
    if type(tb) ~= 'table' then
        return tb
    end
    local ret = {}
    for k, v in pairs(tb) do
        ret[k] = table.deepcopy(v)
    end
    setmetatable(ret, table.deepcopy(getmetatable(tb)))
    return ret
end

function table.imerge(ta, tb)
    local ret = {}
    for i, v in ipairs(ta) do
        ret[i] = v
    end
    local len = #ret
    for i, v in ipairs(tb) do
        ret[len + i] = v
    end
    return ret
end

function table.merge(ta, tb)
    local ret = {}
    for k, v in pairs(ta) do
        ret[k] = v
    end
    for k, v in pairs(tb) do
        ret[k] = v
    end
end

--region table.dump
local EMPTY_PER_DEPTH = "    "
local _insert = table.insert
local _insert_empty = function(str, depth)
    for _ = 1, depth do
        _insert(str, EMPTY_PER_DEPTH)
    end
end

local _dump
_dump = function(tb, str, curDepth)
    if type(tb) == 'table' then
        _insert(str, "\n")
        _insert_empty(str, curDepth)
        _insert(str, "{\n")
        for k, v in pairs(tb) do
            _insert_empty(str, curDepth + 1)
            _insert(str, tostring(k))
            _insert(str, " = ")
            _dump(v, str, curDepth + 1)
        end
        _insert_empty(str, curDepth)
        _insert(str, "}\n")
    else
        _insert(str, tostring(tb))
        _insert(str, ",\n")
    end
end

function table.dump(tb)
    local strTable = {}
    _dump(tb, strTable, 0)
    return table.concat(strTable)
end
--endregion table.dump
